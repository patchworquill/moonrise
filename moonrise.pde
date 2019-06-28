//source: https://processing.org/examples/clock.html
// todo: menstral cycles, tides for fishers and surfing, sunwave, mooncycle, did first new moon start on J1 or later this year?
int cx, cy;
float secondsRadius;
float clockDiameter;
float moonCycle;
IntList dayCount;
String [] md;
PImage earth, moon, maskImage;
void setup() {
   size(screen.width, screen.height);
   stroke(255);
   
   int radius = min(width, height) / 2;
   clockDiameter = radius*0.8;
   secondsRadius = radius / 4;
   moonClock = radius / 1.7;
   moonCycle = 27.322;
   cx = width / 2;
   cy = height / 2 - 100;
   
   //webImg = loadImage("moon-full.jpg");
   moon = loadImage("moon.png");
   earth = loadImage("earth.gif");
   maskImage = loadImage("mask.png", "png");
   
   // apply mask
   alternateMask(moon, maskImage);
   //dayCount = new IntList(31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334, 265);
}
void draw() {
   bk = second()*4.2; //background color is function of time 255/60 ~ 4.2
   mc = 255-bk;
   background(bk);
   noStroke();
   fill(mc);
   ellipse(cx, cy, clockDiameter*2-10, clockDiameter*2-10);
   fill(bk);
   ellipse(cx, cy, clockDiameter, clockDiameter);
k = 10;
   image(earth,cx-earth.width/(2*k),cy-earth.height/(2*k)-20,earth.width/k,earth.height/k);
   
   // Angles for sin() and cos() start at 3 o'clock;
   // subtract HALF_PI to make them start at the top
   float s = map(second(), 0, 60, 0, TWO_PI) - HALF_PI;
   float m = map(minute() + norm(second(), 0, 60), 0, 60, 0, TWO_PI) - HALF_PI; 
   float h = map(hour() + norm(minute(), 0, 60), 0, 24, 0, TWO_PI * 2) - HALF_PI;
   
   // Draw the hands of the clock
   stroke(mc);
   strokeWeight(2);
   noFill();
   ellipse(cx + cos(s) * secondsRadius, cy + sin(s) * secondsRadius, 10, 10);
   ellipse(cx + cos(m) * secondsRadius, cy + sin(m) * secondsRadius, 20,20);
   ellipse(cx + cos(h) * secondsRadius, cy + sin(h) * secondsRadius, 35, 35);
   
   stroke(bk);
   // moon clock
   beginShape(POINTS);
   for (int a = 0; a < 360; a+=moonCycle) {
      float angle = radians(a)-HALF_PI;
      float x = cx + cos(angle) * moonClock;
      float y = cy + sin(angle) * moonClock;
      if ( month() == a/moonCycle){
         image(moon, x-25,y-25,50,50);
      }
      else
      noFill();
      ellipse(x, y, 50, 50);
   }
   endShape();
   
   /// digital time
   //fill=(wb);
   string ss = second();
   string mm = minute();
   string hh = hour();
   ss = addZero(ss); 
   mm = addZero(mm);
   hh = addZero(hh);
   textSize(13);
   fill(mc);
   text(hh +":"+ mm, cx-16, cy+6.5); 
   textSize(10);
   // print date
   string yy = year();
   string mm = month();
   string dd = day();
   solstice = 172; // 2019 summer solstice 
   //print("# of days since solstice:", dayRough - solstice);
   //md = new String[]{31,59,90,120,151,181,212};
   //day = dayCount[mm] + dd;
   //day = day+dd;
   text(yy+"."+mm+"."+dd,cx-23,cy+20);
   //stroke(mc);
   //line(cx,0,cx,height);
   //print(hh +":"+ mm+":"+ ss, cx-45, height-100); 
}
void sunSine(int lat){
   float sunDec = -23.44 * 0.9863 * (day() + (month()*30.5));
   
   hourAng = arccos(- tan(lat)+ tan(sunDec))
   
}
void moonPhase(){
}
void addZero(string t){
   if (t < 10){
      t = "0" + t;
   }
   return t;
}
// drop-in replacement for p.mask(m) syntax
void alternateMask(Pimage p, Pimage m) {
   m.loadPixels();
   p.loadPixels();
   for (int j=p.width*p.height-1; j >= 0; j--) {
      p.pixels[j] = p.pixels[j] & 0x00FFFFFF |    ((m.pixels[j] & 0x000000FF) << 24);
   }
   p.updatePixels();
}
