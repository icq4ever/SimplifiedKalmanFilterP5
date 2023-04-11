class KalmanFilter{

  float varProcess;              // process Variance              // 프로세스 공분산
  float varEstimateMeasurement;  // estimate mesurement Variance  // 측정 공분산
  float postEstimate;            // posteri estimate              // 추정된 값
  float postErrorEstimate;       // posteri error estimate        // 추정값 에러공분산

  // constructor
  KalmanFilter(float _varP, float _varEM){
    this.varProcess = _varP;
    this.varEstimateMeasurement = _varEM;
    this.postEstimate = 0.0;
    this.postErrorEstimate = 1.0;
  }
  
  // change variance for process, estimate measurement 
  void setVariance(float _varP, float _varEM){
    this.varProcess = _varP;
    this.varEstimateMeasurement = _varEM;
  }

  // update kalmanFilter
  void update(float input){
    float preEstimate = this.postEstimate;
    float preErrorEstimate = this.postErrorEstimate + this.varProcess;

    float kalmanGain = preErrorEstimate / (preErrorEstimate + this.varEstimateMeasurement);
    this.postEstimate = preEstimate + kalmanGain * (input - preEstimate);
    this.postErrorEstimate = (1 - kalmanGain) * preErrorEstimate;
  }

  float getEstimated(){
    return this.postEstimate;
  }
};
