import java.util.*;
class Set {
  private List<Dot> dots;
  public PVector min, max;
  public float dotSize;
  public float dotSpeed;
  public float minConnect;
  public float minConnectSq;
  public static final float minWidth = 0;
  public static final float maxWidth = 2;

  Set(int num, float dotSize, float dotSpeed, float minConnect, PVector min, PVector max) {
    dots = new ArrayList<Dot>();
    this.min = min;
    this.max = max;
    this.dotSize = dotSize;
    this.dotSpeed = dotSpeed;
    this.minConnect = minConnect;
    this.minConnectSq = sq(minConnect);
    for (int i = 0; i < num; i++) {
      dots.add(new Dot(this));
    }
  }

  void update() {
    for(Dot d : dots)
          d.update();
    for (int i = 0; i < dots.size(); i++) {
      Dot d = dots.get(i);
      d.connect(dots.subList(i + 1, dots.size()));
    }
  }
}
