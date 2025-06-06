import 'package:flutter/material.dart';

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

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static const List<String> _titles = [
    'バブレストラン (8号館1階)',
    'FAMILIA KITCHEN (コムスクエア)',
    'ふうりゅう 東海大学店 (ログハウス)',
    'Café Lounge (14号館地下1階)',
    'シダックス (19号館1階)',
  ];

  // 仮の商品データ
  static const List<List<Map<String, String>>> _menus = [
    [
      {'image': '../assets/images/menu1.png', 'name': '唐揚げ定食', 'price': '¥600'},
      {'image': '../assets/images/menu1.png', 'name': 'カツ丼', 'price': '¥650'},
      {'image': '../assets/images/menu1.png', 'name': '親子丼', 'price': '¥550'},
      {
        'image': '../assets/images/menu1.png',
        'name': '味噌汁セット',
        'price': '¥100',
      },
    ],
    // 他の店舗も同様にデータを追加
    [
      {'image': '../assets/images/menu1.png', 'name': 'タコライス', 'price': '¥700'},
      {'image': '../assets/images/menu1.png', 'name': 'ガパオライス', 'price': '¥750'},
      {'image': '../assets/images/menu1.png', 'name': 'グリーンカレー', 'price': '¥800'},
      {'image': '../assets/images/menu1.png', 'name': 'サラダボウル', 'price': '¥500'},
    ],
    [
      {'image': '../assets/images/menu1.png', 'name': '醤油ラーメン', 'price': '¥600'},
      {'image': '../assets/images/menu1.png', 'name': '味噌ラーメン', 'price': '¥650'},
      {'image': '../assets/images/menu1.png', 'name': 'チャーハン', 'price': '¥550'},
      {'image': '../assets/images/menu1.png', 'name': '餃子セット', 'price': '¥300'},
    ],
    [
      {'image': '../assets/images/menu1.png', 'name': 'カフェラテ', 'price': '¥350'},
      {'image': '../assets/images/menu1.png', 'name': 'サンドイッチ', 'price': '¥400'},
      {'image': '../assets/images/menu1.png', 'name': 'ケーキセット', 'price': '¥600'},
      {'image': '../assets/images/menu1.png', 'name': '紅茶', 'price': '¥300'},
    ],
    [
      {'image': '../assets/images/menu1.png', 'name': 'マルゲリータピザ', 'price': '¥900',},
      {'image': '../assets/images/menu1.png', 'name': 'カルボナーラ', 'price': '¥850'},
      {'image': '../assets/images/menu1.png', 'name': 'ミートソースパスタ', 'price': '¥800'},
      {'image': '../assets/images/menu1.png', 'name': 'サラダ', 'price': '¥400'},
    ],
  ];

  @override
  Widget build(BuildContext context) {
    final menus = _menus[_selectedIndex];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _titles[_selectedIndex],
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "メニュー",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                itemCount: menus.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 1.5, // 高さを揃える
                ),
                itemBuilder: (context, index) {
                  final menu = menus[index];
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 2,
                    ),
                    onPressed: () {},
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start, // 追加: 左揃え
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              menu['image']!,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            menu['price']!,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.left, // 念のため
                          ),
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.waves), label: 'バブレストラン',),
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
