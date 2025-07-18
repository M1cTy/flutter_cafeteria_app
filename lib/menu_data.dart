const List<List<Map<String, String>>> menus = [
  [
    {'image': 'assets/images/menu1.png', 'name': '唐揚げ定食', 'price': '¥600'},
    {'image': 'assets/images/menu1.png', 'name': 'カツ丼', 'price': '¥650', 'soldOut': 'true',
    },
    {'image': 'assets/images/menu1.png', 'name': '親子丼', 'price': '¥550'},
    {'image': 'assets/images/menu1.png', 'name': '味噌汁セット', 'price': '¥100'},
  ],
  [
    {'image': 'assets/images/menu1.png', 'name': 'タコライス', 'price': '¥700'},
    {'image': 'assets/images/menu1.png', 'name': 'ガパオライス', 'price': '¥750'},
    {'image': 'assets/images/menu1.png', 'name': 'グリーンカレー', 'price': '¥800'},
    {'image': 'assets/images/menu1.png', 'name': 'サラダボウル', 'price': '¥500'},
  ],
  [
    {'image': 'assets/images/menu1.png', 'name': '醤油ラーメン', 'price': '¥600'},
    {'image': 'assets/images/menu1.png', 'name': '味噌ラーメン', 'price': '¥650'},
    {'image': 'assets/images/menu1.png', 'name': '担々麺', 'price': '¥550'},
    {
      'image': 'assets/images/menu1.png',
      'name': '餃子セット',
      'price': '¥300',
      'soldOut': 'true',
    },
  ],
  [
    {'image': 'assets/images/menu1.png', 'name': 'カフェラテ', 'price': '¥350'},
    {
      'image': 'assets/images/menu1.png',
      'name': 'サンドイッチ',
      'price': '¥400',
      'soldOut': 'true',
    },
    {'image': 'assets/images/menu1.png', 'name': 'ケーキセット', 'price': '¥600'},
    {'image': 'assets/images/menu1.png', 'name': '紅茶', 'price': '¥300'},
  ],
  [
    {'image': 'assets/images/menu1.png', 'name': 'マルゲリータピザ', 'price': '¥900'},
    {'image': 'assets/images/menu1.png', 'name': 'カルボナーラ', 'price': '¥850'},
    {'image': 'assets/images/menu1.png', 'name': 'ミートソースパスタ', 'price': '¥800'},
    {'image': 'assets/images/menu1.png', 'name': 'カレーライス', 'price': '¥500'},
    {
      'image': 'assets/images/menu1.png',
      'name': 'サラダ',
      'price': '¥400',
      'soldOut': 'true',
    },
  ],
];

// 日替わりメニュー
const List<List<Map<String, String>>> dailyMenus = [
  [],
  [],
  [], // ふうりゅう
  [
    {
      'name': '日替わりランチ',
      'image': 'assets/images/menu.webp',
      'price': '¥500',
      'soldOut': 'false',
    }
  ], // Café Lounge
  [
    {
      'name': '唐揚げカレー',
      'image': 'assets/images/familia_daily_curry.webp',
      'price': '¥650',
      'soldOut': 'false',
    },
    {
      'name': '日替わり丼',
      'image': 'assets/images/menu1.webp',
      'price': '¥550',
      'soldOut': 'true',
    },
  ], // シダックス
];
