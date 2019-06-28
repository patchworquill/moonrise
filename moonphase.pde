color f=#ffffff, bg=#202020;
float t, theta, radius, a;
int frames=480;
PImage moon;

void setup() {
   radius=500;//screen.width; 
	 size(radius, radius);
   noStroke();
   moon = loadImage("moon.png");
   a = 0; // 0% opacity?
}
void draw() {
   t = (frameCount%frames)/(float)frames;
   background(bg);
   image(moon, 0,0, radius-1, radius-1);
   translate(width/2, height/2);
   rotate(PI/2);
   if (t<0.5) {
      float tt=map(t,0,0.5,0,1); // normalizing the time of the first half of the cycle
      if (tt<.5) {
         fill(bg);
         float r = map(tt, 0, 0.5, radius, 0);
         arc(0, 0, radius, r, 0, PI); // new moon left, shrinking
         arc(0, 0, radius, radius, PI, TWO_PI); // moon right, stable
         //print("waxing crescent");
      } else {
				 fill(bg);
				 arc(0, 0, radius, radius, PI, TWO_PI); // moon right, stable
         float r = map(tt, 0.5, 1.0, 0, radius);
         fill(f);
         arc(0, 0, radius, r, PI, TWO_PI); // moon upper, increasing
         //print("waxing gibbous");
      }
   } else {
      float tt=map(t,0.5,1,0,1); // normalizing the time of the second half of the cycle
      if (tt<.5) {
         fill(f,a);
         arc(0, 0, radius, radius, PI, TWO_PI); // moon right, stable
         float r = map(tt, 0, 0.5, radius, 0);
         fill(bg);
         arc(0, 0, radius, radius, 0, PI); // dark right, stable > partly hidden by the following arc
         fill(f);
         arc(0, 0, radius, r, 0, PI); // bg lower, decreasing
         //print("waning gibbous");
      } else { // waning crescent
         fill(bg);
         float r = map(tt, 0.5, 1.0, 0, radius);
         arc(0, 0, radius, radius, 0, PI); // dark left, stable
         arc(0, 0, radius, r, PI, TWO_PI); // dark right, increasing
      }
   }
   theta+=TWO_PI/frames;
   //if (frameCount<=frames) saveFrame("image-###.gif");
}
