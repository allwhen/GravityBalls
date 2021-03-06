//declare variables
int num = 30;
float[] x = new float[num];
float[] y = new float[num];
float[] velX = new float[num];
float[] velY = new float[num];
float[] diam = new float[num];
//gravitational constant
float g = .00000087;
void setup() {
  //set size of canvas
  size(800, 600);

  //initialize variables
  for (int i = 0; i<num; i++) {
    x[i] = random(width);
    y[i] = random(height);
    diam[i] = random(40, 80);
    velX[i] = random(-5, 5);
    velY[i] = random(-5, 5);
  }
}

float d(float x1,float y1,float x2,float y2) {
  return sqrt((x1-x2)*(x1-x2)+(y1-y2)*(y1-y2));
}

void draw() {
  //draw background to cover previous frame
  background(0);

  //draw ball
  for (int i = 0; i<num; i++) {
    //add velocity to position
    x[i] += velX[i];
    y[i] += velY[i];

    ellipse(x[i], y[i], diam[i], diam[i]);
    //bounce ball if it hits walls
    if (x[i] + diam[i]/2 >= width) {
      velX[i] = -abs(velX[i]);    //if the ball hits the right wall, assign x velocity the negative version of itself
    } else if (x[i] - diam[i]/2 <= 0) {
      velX[i] = abs(velX[i]);     //if the ball hits the left wall, assign x velocity the positive version of itself
    }
    if (y[i] + diam[i]/2 >= height) {
      velY[i] = -abs(velY[i]);
    } else if (y[i] - diam[i]/2 <= 0) {
      velY[i] = abs(velY[i]);
    }
    else {
      //only gravity when not below bottom or above top
      velY[i]+=.07;
    }
    for (int j=0; j<num; j++) {
      if (j == i) {
        //no attraction to self
        continue;
      }
      //gravity force formula times trig stuff. cosine = delta x/distance, sine = delta y/distance.
      velX[i]+=g*(x[i]-x[j])*diam[j]*diam[j]*diam[i]*diam[i]/(4*d(x[i],y[i],x[j],y[j])*d(x[i],y[i],x[j],y[j])*d(x[i],y[i],x[j],y[j]));
      velY[i]+=g*(y[i]-y[j])*diam[j]*diam[j]*diam[i]*diam[i]/(4*d(x[i],y[i],x[j],y[j])*d(x[i],y[i],x[j],y[j])*d(x[i],y[i],x[j],y[j]));
    }
  }
}