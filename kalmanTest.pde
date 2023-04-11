float randomValue=25.0;
float lastValue = 0.;
float alphaValue =0.;
float alpha = 0.1;
float estimateValue;

float varianceProcess, varianceEstimateMeasurement;
KalmanFilter kf;

Plotter randomPlot, kalmanPlot, alphaPlot;

import controlP5.*;
ControlP5 cp5;
PFont uiFont;



void setup(){
  size(800, 400);
  
  kf = new KalmanFilter(pow(varianceProcess, 2), pow(varianceEstimateMeasurement, 2));
  cp5 = new ControlP5(this);
  uiFont = loadFont("Iosevka-SS14-12.vlw");
  
  setGUI();
   
  randomPlot = new Plotter(600, color(200), 0.5);
  alphaPlot = new Plotter(600, color(#0FBDFF), 1.3);
  kalmanPlot = new Plotter(600, color(255, 255, 0), 1.5);
  
}

void setGUI(){
  cp5.addSlider("varianceProcess")
    .setPosition(100, 50)
    .setSize(200, 20)
    .setRange(0, 0.09)
    .setValue(0.02)
    .getCaptionLabel()
    .setFont(uiFont)
    .toUpperCase(false);
    
  cp5.addSlider("varianceEstimateMeasurement")
    .setPosition(100, 80)
    .setSize(200, 20)
    .setRange(0, 0.9)
    .setValue(0.1)
    .getCaptionLabel()
    .setFont(uiFont)
    .toUpperCase(false);
}

//void slider(float

void draw(){
  kf.setVariance(varianceProcess,varianceEstimateMeasurement);
  background(30);
  
  // original noised sensor value
  randomValue = randomValue + random(-10, 10);
  //randomValue = random(50) + random(-50, 50);
  
  // alpha filtering (a.k.a moving average)
  alphaValue = alpha * randomValue + (1-alpha)* alphaValue; 
  
  // kalman filtering
  kf.update(randomValue);
  estimateValue = kf.getEstimated();
  
  randomPlot.update(randomValue);
  kalmanPlot.update(estimateValue);
  alphaPlot.update(alphaValue);
  
  // draw variances 
  push();
  textFont(uiFont);
  textAlign(LEFT, CENTER);
  fill(255, 255, 0);
  text(varianceProcess, 30, 60); 
  text(varianceEstimateMeasurement, 30, 90);
  pop();
  
  push();
  translate(0, height/4);
  
  randomPlot.draw(100, 100);
  kalmanPlot.draw(100, 100);
  alphaPlot.draw(100, 100);
  pop();
  
  //println(randomValue + " " + estimateValue);
}
