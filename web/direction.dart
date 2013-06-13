library direction;

class Direction {
  final int deltaRow;
  final int deltaCol;
  
  const Direction(this.deltaRow, this.deltaCol);
  
  static const N = const Direction(1, 0);
  static const S = const Direction(-1, 0);
  static const E = const Direction(0, 1);
  static const W = const Direction(0, -1);
  static const NW = const Direction(1, -1);
  static const SW = const Direction(-1, -1);
  static const NE = const Direction(1, 1);
  static const SE = const Direction(-1, 1);
  
  static Direction getDir(String dir) {
    switch(dir) {
      case "n":
        return Direction.N;
        break;
      case "s":
        return Direction.S;
        break;
      case "e":
        return Direction.E;
        break;
      case "w":
        return Direction.W;
        break;
      case "ne":
        return Direction.NE;
        break;
      case "nw":
        return Direction.NW;
        break;
      case "se":
        return Direction.SE;
        break;
      case "sw":
        return Direction.SW;
        break;
      default:
        assert(false);
    }
  }
}