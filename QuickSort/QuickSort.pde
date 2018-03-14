Float[] arr;
float xStep;

void setup() {
  fullScreen();
  stroke(0);
  fill(0, 255, 0);
  arr = new Float[width];
  xStep = width / arr.length;
  for (int i = 0; i < arr.length; i++) {
    arr[i] = new Float(random(1));
  }
  noLoop();
  quicksort(arr, 0, arr.length-1);
}

void draw() {
  background(255);
  for (int i = 0; i < arr.length; i++) {
    float y = map(arr[i], 0, 1, 0, height);
    float x = map(i, 0, arr.length, 0, width);
    rect(x, height - y, x + xStep, height);
  }
}

void quicksort(Comparable[] c, int l, int h) {
  if (l < h)
  {
    int p = partition(c, l, h);
    quicksort(c, l, p - 1);
    quicksort(c, p + 1, h);
  }
}

int partition(Comparable[] c, int l, int h) {
  Comparable pivot = c[h];
  int i = l - 1;
  for (int j = l; j < h; j++) {
    if (c[j].compareTo(pivot) < 0) {
      i++;
      swap(c, i, j);
    }
  }
  swap(c, i+1, h);
  return i+1;
}

void swap(Comparable[] c, int a, int b) {
  Comparable t = c[b];
  c[b] = c[a];
  c[a] = t;
  draw();
}