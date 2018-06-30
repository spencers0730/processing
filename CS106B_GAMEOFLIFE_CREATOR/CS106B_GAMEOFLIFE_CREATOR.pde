boolean[][] g;
int size = 50;


PrintWriter output;

void setup() {
  fullScreen();
  noStroke();
  frameRate(15);
  fill(255);
  g = new boolean[width / size][height / size];
  output = createWriter("output.txt");
}

void draw() {
  background(0);

  for (int i = 0; i < g.length; i++) {
    for (int j = 0; j < g[0].length; j++) {
      if (g[i][j]) {
        rect(i * size, j * size, size, size);
      }
    }
  }
  if (keyPressed && key == ' ') {
    output.println(g[0].length);
    output.println(g.length);
    for (int j = 0; j < g[0].length; j++) {
      for (int i = 0; i < g.length; i++) {
        output.print((g[i][j]) ? 'X' : '-');
      }
      output.println();
    }
    output.flush();  // Writes the remaining data to the file
    output.close();  // Finishes the file
    exit();  // Stops the program
  }
}

void mousePressed() {
  g[mouseX / size][mouseY / size] = !g[mouseX / size][mouseY / size];
}
