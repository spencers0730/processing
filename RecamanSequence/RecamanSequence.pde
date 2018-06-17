boolean[] visited;
int current, step;
int n = 30;

void setup() {
  fullScreen();
  ellipseMode(CENTER);
  current = 1;
  step = 1;
  visited = new boolean[n];
  background(255);
  stroke(0);
  noFill();
}
void draw(){  while (current + step <= n) {
    visited[current] = true;
    float s = map(step, 1, n, 0, width);

    if (current - step > 0 && !visited[current - step - 1]) {
      current -= step;
    } else {
      current += step;
    }
    step++;

    if (step % 2 == 0) {
      arc(s * .75, height / 2, s, s, 0, PI);
    } else {    
      arc(s * .75 , height / 2, s, s, -PI, 0);
    }
  }}
