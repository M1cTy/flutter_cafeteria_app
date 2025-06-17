String getCafeteriaImageAsset(int index) {
  switch (index) {
    case 0:
      return 'assets/images/pub.webp'; // バブレストラン
    case 1:
      return 'assets/images/familia.webp'; // FAMILIA KITCHEN
    case 2:
      return 'assets/images/furyu.webp'; // ふうりゅう
    case 3:
      return 'assets/images/cafe.webp'; // Café Lounge
    case 4:
      return 'assets/images/cidax.webp'; // シダックス
    default:
      return 'assets/images/pub.webp';
  }
}
