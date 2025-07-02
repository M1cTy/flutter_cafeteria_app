import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'menu_data.dart';
import 'seat_map.dart';
import 'cafeteria_info.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'cafeteria_status.dart';
import 'cafeteria_image.dart';
import 'cafeteria_menu_grid.dart';
import 'cafeteria_map_page.dart'; // 追加

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
    '学食マップ', // 追加
  ];

  final List<List<List<int>>> seatMatrices = [
    [
      [1, 1, 1, 1, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 1, 1, 1, 1, 1],
      [0, 0, 0, 1, 1, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2],
      [1, 0, 0, 1, 1, 1, 0, 1, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
      [1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 0, 2],
      [0, 1, 2, 1, 1, 0, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 2, 2, 0, 1],
      [0, 1, 1, 1, 0, 1, 1, 2, 1, 0, 1, 1, 1, 1, 1, 0, 2, 2, 0, 1],
      [0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 1, 0, 0, 0, 0, 1],
    ],
    [
      [1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
      [1, 2, 1, 1, 1, 1, 1, 1, 1, 1],
      [1, 1, 1, 1, 1, 2, 1, 1, 1, 1],
      [1, 1, 1, 1, 1, 2, 1, 2, 1, 1],
      [1, 1, 1, 1, 1, 1, 1, 2, 1, 1],
    ],
    [
      [1, 1, 2, 1, 1, 1, 1, 1, 1, 1],
      [1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
      [1, 1, 1, 1, 1, 2, 1, 1, 1, 1],
      [1, 1, 1, 1, 1, 2, 1, 1, 1, 1],
    ],
    [
      [1, 1, 1, 1, 1, 1, 1, 1],
      [1, 1, 1, 1, 1, 1, 1, 1],
      [1, 1, 2, 2, 1, 1, 1, 1],
      [1, 1, 1, 1, 1, 1, 1, 1],
    ],
    [
      [1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2],
      [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
      [1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 0, 0],
    ],
  ];

  final List<List<int>> congestionDataList = [
    [3, 14, 50, 96, 80, 31, 27, 20, 12], // バブレストラン
    [2, 10, 40, 80, 70, 30, 25, 18, 5], // FAMILIA KITCHEN
    [1, 8, 30, 60, 55, 20, 15, 10, 100], // ふうりゅう
    [1, 5, 20, 40, 35, 15, 10, 8, 20], // Café Lounge
    [2, 12, 45, 90, 75, 28, 32, 27, 51], // シダックス
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 100),
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
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          // 各ページ
          _buildCafeteriaPage(context, 0),
          _buildCafeteriaPage(context, 1),
          _buildCafeteriaPage(context, 2),
          _buildCafeteriaPage(context, 3),
          _buildCafeteriaPage(context, 4),
          const CafeteriaMapPage(),
        ],
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
          NavigationDestination(icon: Icon(Icons.map), label: 'マップ'),
        ],
      ),
    );
  }

  Widget _buildCafeteriaPage(BuildContext context, int index) {
    final menusForSelected = menus[index];
    final List<int> congestionData = congestionDataList[index];
    final timeLabels = ['9', '10', '11', '12', '13', '14', '15', '16', '17'];
    final dailyMenusForSelected = dailyMenus[index];

    // --- 日替わりメニュー追加 ---

    return FadeTransition(
      opacity: _fadeAnimation,
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(
              _titles[index],
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            centerTitle: false,
            floating: false,
            pinned: false, // ← これでスクロール時にAppBarが消える
            snap: false,
            automaticallyImplyLeading: false,
            backgroundColor: Theme.of(context).colorScheme.surface,
            actions: [
              IconButton(
                icon: const Icon(Icons.refresh),
                tooltip: '更新',
                onPressed: () {
                  setState(() {
                    // TODO: API等から最新データ取得処理を実装
                  });
                },
              ),
              IconButton(
                icon: const Icon(Icons.info_outline),
                tooltip: 'info',
                onPressed: () {
                  final info = cafeteriaInfos[index];
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text(
                        info.title,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      content: SingleChildScrollView(
                        child: Center(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 600),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // 画像の幅を明示的に制約
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: SizedBox(
                                    width: 600,
                                    child: AspectRatio(
                                      aspectRatio: 16 / 9, // 画像のアスペクト比に合わせて調整
                                      child: Image.asset(
                                        getCafeteriaImageAsset(index),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 12),
                                ...info.body.map((e) {
                                  if (e.isEmpty)
                                    return const SizedBox(height: 8);
                                  return MarkdownBody(
                                    data: e,
                                    styleSheet: MarkdownStyleSheet(
                                      p: const TextStyle(fontSize: 15),
                                      strong: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  );
                                }),
                              ],
                            ),
                          ),
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('閉じる'),
                        ),
                      ],
                    ),
                  );
                },
              ),
              IconButton(
                icon: const FaIcon(FontAwesomeIcons.github),
                tooltip: 'GitHub',
                onPressed: () {
                  // GitHubリポジトリのURLを開く
                  const url = 'https://github.com/M1cTy/flutter_cafeteria_app';
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('GitHub'),
                      content: Text(url),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('閉じる'),
                        ),
                        TextButton(
                          onPressed: () async {
                            Navigator.of(context).pop();
                            // URLを開く
                            // ignore: deprecated_member_use
                            await launchUrl(Uri.parse(url));
                          },
                          child: const Text('ブラウザで開く'),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
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
                            "Status",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          // 混雑度のテキスト表示
                          Builder(
                            builder: (context) {
                              final int latestCongestion =
                                  congestionData.isNotEmpty
                                  ? congestionData.last
                                  : 0;
                              final List<int> userCounts = [32, 18, 12, 8, 21];
                              final List<int> avgStayMinutes = [
                                28,
                                22,
                                19,
                                15,
                                24,
                              ];
                              final int userCount = userCounts[index];
                              final int avgStay = avgStayMinutes[index];
                              return CafeteriaStatus(
                                latestCongestion: latestCongestion,
                                userCount: userCount,
                                avgStay: avgStay,
                                congestionData: congestionData,
                                timeLabels: timeLabels,
                              );
                            },
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
                            seatMatrix: seatMatrices[index],
                            onTap: (row, col) {
                              // タップ時の処理
                            },
                          ), // ← ここを差し替え
                          const SizedBox(height: 24),
                          // --- 日替わりメニュー追加 ---
                          if (dailyMenusForSelected.isNotEmpty) ...[
                            Text(
                              "日替わりメニュー",
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
                                  itemCount: dailyMenusForSelected.length,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisSpacing: 16,
                                        crossAxisSpacing: 16,
                                        childAspectRatio: 1.5,
                                      ),
                                  itemBuilder: (context, index) {
                                    final menu = dailyMenusForSelected[index];
                                    final bool soldOut =
                                        menu['soldOut'] == 'true';
                                    return ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.zero,
                                        backgroundColor: soldOut
                                            ? Colors.grey[300]
                                            : Colors.white,
                                        foregroundColor: soldOut
                                            ? Colors.grey
                                            : Colors.black,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            16,
                                          ),
                                        ),
                                        elevation: 2,
                                      ),
                                      onPressed: soldOut ? null : () {},
                                      child: Stack(
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  child: ColorFiltered(
                                                    colorFilter: soldOut
                                                        ? ColorFilter.mode(
                                                            Colors.black
                                                                .withOpacity(
                                                                  0.3,
                                                                ),
                                                            BlendMode.darken,
                                                          )
                                                        : ColorFilter.mode(
                                                            Colors.transparent,
                                                            BlendMode.multiply,
                                                          ),
                                                    child: Image.asset(
                                                      menu['image']!,
                                                      fit: BoxFit.cover,
                                                      width: double.infinity,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 8),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 8.0,
                                                    ),
                                                child: Text(
                                                  menu['name']!,
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 16,
                                                  ),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.left,
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
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
                                          if (soldOut)
                                            Positioned.fill(
                                              child: Container(
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  color: Colors.black
                                                      .withOpacity(0.4),
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                ),
                                                child: const Text(
                                                  '売り切れ',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16,
                                                    shadows: [
                                                      Shadow(
                                                        blurRadius: 4,
                                                        color: Colors.black54,
                                                        offset: Offset(1, 1),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),
                          ],
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
                              constraints: const BoxConstraints(maxWidth: 600),
                              child: CafeteriaMenuGrid(
                                menus: menusForSelected,
                                selectedIndex: _selectedIndex,
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
    );
  }
}
