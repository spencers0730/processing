import processing.sound.*;

FFT fft;
AudioIn in;

final static int bands = 512;
float bandWidth;

float[] spectrum;
float[] oldSpectrum;

float smoothing = .9;

void setup() {
  fullScreen();
  bandWidth = float(width) / bands;
  spectrum = new float[bands];
  oldSpectrum = new float[bands];
  
  fft = new FFT(this, bands);
  in = new AudioIn(this, 0);
  
   in.start();
   fft.input(in);
   fill(255);
   noStroke();
  //frameRate(3);
  print(width, bandWidth);
}

void draw() {
  background(0);
 
  arrayCopy(spectrum, oldSpectrum);
  
  fft.analyze(spectrum);
  for(int i= 0; i < bands; i++) {
    float amplitude = smoothing * oldSpectrum[i] + (1 - smoothing) * spectrum[i];
    
    float h = map(amplitude, 0, .5, 0, height); 
    rect(i * bandWidth, height, bandWidth, -h);
  }
}
