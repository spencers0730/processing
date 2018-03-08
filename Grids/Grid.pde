class Grid {
  PVector pos;

  //dimensions of grid
  Point[][] points;
  int xLen;
  int yLen;

  //lengths of individual springs
  final float target;
  final float corner;

  //forces
  final float kForce;
  final float pullForce;
  final float windForce;
  final float gravityForce;

  //force associated 
  final float minGravDist;

  //wind constants
  final float windTimeStep;
  final float windSpaceStep;

  //point constants
  final float bufferLength;
  final float pointSize;
  final float dragConst;

  //updating dynamic variables
  int accuracy;
  boolean mouse;
  boolean wind;
  boolean grav;

  //wind noise time
  float windTime;

  Grid(float x, float y, int xLen, int yLen, float target, float kForce, float pullForce, 
    float windForce, float gravityForce, float minGravDist, float bufferLength, 
    float pointSize, float dragConst, float windTimeStep, float windSpaceStep) {
    this.pos = new PVector(x, y);
    this.xLen = xLen;
    this.yLen = yLen;
    this.points = new Point[xLen][yLen];
    this.target = target;
    this.corner = sqrt(2) * target;
    this.kForce = kForce;
    this.pullForce = pullForce;
    this.windForce = windForce;
    this.gravityForce = gravityForce;
    this.minGravDist = minGravDist;
    this.bufferLength = bufferLength;
    this.pointSize = pointSize;
    this.dragConst = dragConst;
    this.windTimeStep = windTimeStep;
    this.windSpaceStep = windSpaceStep;
    this.reset();
  }

  private void reset() {
    for (int i = 0; i < this.xLen; i++)
      for (int j = 0; j < this.yLen; j++) {
        float x = i * target + this.pos.x;
        float y = j * target + this.pos.y;
        //boolean anchor;
        this.points[i][j] = new Point(x, y, false, this);
      }

    this.accuracy = 2;
    this.mouse = false;
    this.wind = false;
    this.grav = false;
  }

  void changeAccuracy(int accuracy) {
    this.accuracy = accuracy;
  }

  void toggleMouse(boolean mouse) {
    this.mouse = mouse;
  }

  void toggleWind(boolean wind) {
    this.wind = wind;
  }

  void toggleGrav(boolean grav) {
    this.grav = grav;
  }

  void update() {
    int timesUp = 0;
    int shown = 0;
    for (int h = 0; h < this.accuracy; h++) {
      timesUp++;
      for (int i = 0; i < this.points.length; i++)
        for (int j = 0; j < this.points[0].length; j++) {
          boolean right = i + 1 < this.points.length;
          boolean down = j + 1 < this.points[0].length;
          boolean up = j - 1 >= 0;

          if (right)
            this.points[i][j].springForce(this.points[i + 1][j], this.target);
          if (down)
            this.points[i][j].springForce(this.points[i][j + 1], this.target);
          if (right && down)
            this.points[i][j].springForce(this.points[i + 1][j + 1], this.corner);
          if (right && up)
            this.points[i][j].springForce(this.points[i + 1][j - 1], this.corner);
        }

      for (int i = 0; i < this.points.length; i++)
        for (int j = 0; j < this.points[0].length; j++) {
          this.points[i][j].update();
        }
      this.windTime += this.windTimeStep / accuracy;
    }
    for (int i = 0; i < this.points.length; i++)
      for (int j = 0; j < this.points[0].length; j++) {
        this.points[i][j].show();
        shown++;
      }
  }

  float windAngle(float x, float y) {
    return map(noise(x * this.windSpaceStep, y * this.windSpaceStep, this.windTime), 
      0, 1, -TWO_PI, TWO_PI);
  }
}