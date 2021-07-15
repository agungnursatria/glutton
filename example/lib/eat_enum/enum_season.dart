enum Season { Spring, Summer, Fall, Winter }

class SeasonManager {
  static Season? fromIndex(int index) {
    switch (index) {
      case 0:
        return Season.Spring;
        break;
      case 1:
        return Season.Summer;
        break;
      case 2:
        return Season.Fall;
        break;
      case 3:
        return Season.Winter;
        break;
      default:
        return null;
    }
  }
}
