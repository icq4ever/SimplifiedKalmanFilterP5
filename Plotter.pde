class Plotter{
  float[] buffer;      // bufferSize
  color strokeColor; 
  float strokeW;
  
  Plotter(int bufferSize, color _strokeColor, float _strokeW){
    this.strokeColor = _strokeColor;
    this.strokeW = _strokeW;
    buffer = new float[bufferSize];
  }
  
  // push new value to buffer
  void update(float newValue){
    for(int i=0; i<buffer.length; i++){
      if(i!=buffer.length-1)  buffer[i] = buffer[i+1];
      else buffer[i] = newValue;
    }
  }
  
  // draw buffer
  void draw(float _x, float _y){
    push();
    translate(_x, _y);
    noFill();
    stroke(this.strokeColor);
    strokeWeight(this.strokeW);
    beginShape();
    for(int i=0; i<buffer.length; i++){
      vertex(i, buffer[i]);
    }
    endShape();
    pop();
  }
}
