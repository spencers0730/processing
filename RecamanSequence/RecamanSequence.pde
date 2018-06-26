boolean[] visited;
int current, step;
int n = 30;

void setup() {
  fullScreen();
  stroke(0);
  noFill();
}
void draw() {  
  background(255);
  visited = new boolean[n];
  current = 0;
  step = 1;
  while (current + step <= n) {
    float a = PI;
    int last = current;
    visited[current] = true;
    if (current - step >= 0 && !visited[current - step]) {
      current -= step;     
      a -= PI;
    } else { 
      current += step;
    }
    step++;
    float x = map((current + last) / 2, 1, n, 0, width);
    float w = map(step, 1, n, width / n, width);
    arc(x , height / 2, w, w, a - PI, a);
  }
}
