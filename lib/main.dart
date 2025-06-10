import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'menu_data.dart';
import 'seat_map.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomeScreen(),
      theme: ThemeData(fontFamily: 'IBMPlexSansJP'),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  static const List<String> _titles = [
    'バブレストラン (8号館1階)',
    'FAMILIA KITCHEN (コムスクエア)',
    'ふうりゅう 東海大学店 (ログハウス)',
    'Café Lounge (14号館地下1階)',
    'シダックス (19号館1階)',
  ];

  final seatMatrix = [
    [1, 1, 1, 1, 2, 1, 1, 1, 1, 1],
    [1, 0, 0, 1, 1, 2, 1, 1, 1, 1],
    [1, 0, 0, 1, 1, 1, 0, 1, 2, 1],
    [1, 1, 1, 0, 1, 1, 1, 1, 1, 1],
    [0, 1, 2, 1, 1, 0, 1, 1, 1, 0],
    [0, 1, 1, 1, 0, 1, 1, 2, 1, 1],
    [0, 1, 1, 1, 1, 1, 1, 1, 1, 1],
  ]; // ← ここに移動

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onNavChanged(int index) {
    _controller.reverse().then((_) {
      setState(() {
        _selectedIndex = index;
      });
      _controller.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    final menusForSelected = menus[_selectedIndex];
    final congestionData = [3, 14, 50, 96, 80, 31, 27, 20, 12];
    final timeLabels = ['9', '10', '11', '12', '13', '14', '15', '16', '17'];

    return Scaffold(
      // AppBarをSliverAppBarに変更
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Text(
                _titles[_selectedIndex],
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              centerTitle: false,
              floating: false,
              pinned: false, // ← これでスクロール時にAppBarが消える
              snap: false,
              automaticallyImplyLeading: false,
              backgroundColor: Theme.of(context).colorScheme.surface,
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 16.0,
                  right: 16.0,
                  bottom: 16.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // --- ここからグラフ追加 ---
                    Align(
                      alignment: Alignment.topCenter,
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 600),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "混雑度",
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(
                              height: 180,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16.0,
                                  horizontal: 16.0,
                                ),
                                child: LineChart(
                                  LineChartData(
                                    maxY: 100,
                                    minY: 0,
                                    gridData: FlGridData(show: true),
                                    titlesData: FlTitlesData(
                                      leftTitles: AxisTitles(
                                        sideTitles: SideTitles(
                                          showTitles: true,
                                          reservedSize: 28,
                                          getTitlesWidget: (value, meta) {
                                            if (value % 50 == 0 &&
                                                value != 0 &&
                                                value >= 0 &&
                                                value <= 100) {
                                              return Text(
                                                value.toInt().toString(),
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                textAlign: TextAlign.right,
                                              );
                                            }
                                            return const SizedBox.shrink();
                                          },
                                          interval: 50,
                                        ),
                                      ),
                                      bottomTitles: AxisTitles(
                                        sideTitles: SideTitles(
                                          showTitles: true,
                                          getTitlesWidget: (value, meta) {
                                            int idx = value.toInt();
                                            if (idx % 2 == 0 &&
                                                idx >= 0 &&
                                                idx < timeLabels.length) {
                                              return Text(
                                                timeLabels[idx] + "時",
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                textAlign: TextAlign.center,
                                              );
                                            }
                                            return const SizedBox.shrink();
                                          },
                                          reservedSize: 24,
                                          interval: 1,
                                        ),
                                      ),
                                      rightTitles: AxisTitles(
                                        sideTitles: SideTitles(
                                          showTitles: false,
                                        ),
                                      ),
                                      topTitles: AxisTitles(
                                        sideTitles: SideTitles(
                                          showTitles: false,
                                        ),
                                      ),
                                    ),
                                    borderData: FlBorderData(show: false),
                                    lineBarsData: [
                                      LineChartBarData(
                                        spots: List.generate(
                                          congestionData.length,
                                          (i) => FlSpot(
                                            i.toDouble(),
                                            congestionData[i].toDouble(),
                                          ),
                                        ),
                                        isCurved: true,
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.primary,
                                        barWidth: 4,
                                        dotData: FlDotData(show: false),
                                        belowBarData: BarAreaData(
                                          show: true,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary
                                              .withOpacity(0.2),
                                        ),
                                      ),
                                    ],
                                    extraLinesData: ExtraLinesData(
                                      verticalLines: [
                                        () {
                                          final hour = 17;
                                          final minute = 0;
                                          final index =
                                              (hour - 9) + (minute / 60);
                                          if (index < 0 ||
                                              index >= timeLabels.length)
                                            return null;
                                          return VerticalLine(
                                            x: index,
                                            color: Theme.of(
                                              context,
                                            ).colorScheme.primary,
                                            strokeWidth: 2,
                                            dashArray: null,
                                            label: VerticalLineLabel(
                                              show: true,
                                              alignment: Alignment.topLeft,
                                              style: TextStyle(
                                                color: Theme.of(
                                                  context,
                                                ).colorScheme.primary,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              labelResolver: (line) => "Now",
                                            ),
                                          );
                                        }(),
                                      ].whereType<VerticalLine>().toList(),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),
                            // --- ここまでグラフ追加 ---
                            Text(
                              "座席マップ",
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 16),
                            SeatMap(
                              seatMatrix: seatMatrix,
                              onTap: (row, col) {
                                // タップ時の処理
                              },
                            ), // ← ここを差し替え
                            const SizedBox(height: 24),
                            // --- ここからメニュー ---
                            Text(
                              "メニュー",
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Align(
                              alignment: Alignment.topCenter,
                              child: ConstrainedBox(
                                constraints: const BoxConstraints(
                                  maxWidth: 600,
                                ),
                                child: GridView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  key: ValueKey<int>(_selectedIndex),
                                  itemCount: menusForSelected.length,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisSpacing: 16,
                                        crossAxisSpacing: 16,
                                        childAspectRatio: 1.5,
                                      ),
                                  itemBuilder: (context, index) {
                                    final menu = menusForSelected[index];
                                    return ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.zero,
                                        backgroundColor: Colors.white,
                                        foregroundColor: Colors.black,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            16,
                                          ),
                                        ),
                                        elevation: 2,
                                      ),
                                      onPressed: () {},
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              child: Image.asset(
                                                menu['image']!,
                                                fit: BoxFit.cover,
                                                width: double.infinity,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0,
                                            ),
                                            child: Text(
                                              menu['name']!,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0,
                                            ),
                                            child: Text(
                                              menu['price']!,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14,
                                              ),
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onNavChanged,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.waves), label: 'バブレストラン'),
          NavigationDestination(
            icon: Icon(Icons.restaurant),
            label: 'FAMILIA KITCHEN',
          ),
          NavigationDestination(icon: Icon(Icons.ramen_dining), label: 'ふうりゅう'),
          NavigationDestination(
            icon: Icon(Icons.local_cafe),
            label: 'Café Lounge',
          ),
          NavigationDestination(icon: Icon(Icons.local_pizza), label: 'シダックス'),
        ],
      ),
    );
  }
}
