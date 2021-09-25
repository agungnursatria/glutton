enum Season { Spring, Summer, Fall, Winter }

class SeasonManager {
  static Season? fromIndex(int? index) {
    switch (index) {
      case 0:
        return Season.Spring;
      case 1:
        return Season.Summer;
      case 2:
        return Season.Fall;
      case 3:
        return Season.Winter;
      default:
        return null;
    }
  }
}
