PShader catShader;
PShader ballShader;
PImage catTexture;

float offset = -10;


boolean hideShpere = false;  // toggle red stroke on sphere

boolean animate = false;    // toggle animation
boolean rainbow = false;    // toggle rainbow coloring
boolean discard = false;    // toggle discarding vertices
boolean pulsate = false;    // toggle a pulsating animation and color glow

boolean play = true;  // star running the time counter

void setup() {
  size(640, 640, P3D);
  noStroke();
  fill(204);
  
  catTexture = loadImage("data/the_cat.png");
  catShader = loadShader("data/TextFrag.glsl", "data/TextVert.glsl");
  ballShader = loadShader("data/BasicFrag.glsl", "data/BasicVert.glsl");
}

float timeX = 0;

void draw() {
  
  if(play)
  {
    timeX += 0.1;
    ballShader.set("myTime",timeX); // send time to shader
  }
  
  // Send controls to vertex shader
  ballShader.set("ctr_animate",animate);  // turn on animation for shader
  ballShader.set("ctr_rainbow",rainbow);  // turn on rainbow for shader
  ballShader.set("ctr_pulsate",pulsate);  // turn on pulsate for shader
  ballShader.set("ctr_discard",discard);  // turn on discard for shader
  
      
  background(0); 
  float dirY = (mouseY / float(height) - 0.5) * 2;
  float dirX = (mouseX / float(width) - 0.5) * 2;
  if (mousePressed) 
    offset += (mouseX - pmouseX); /// float(width);
  directionalLight(204, 204, 204, -dirX, -dirY, -1);
  translate(width/2, height/2);
  
  // Picture in the background
  // Provided so that you can see "holes"
  // where the sphere is transparent, and have an
  // example of how to use textures with shaders
  shader(catShader);
  noStroke();
  fill(#00FFAA);
  textureMode(NORMAL);
  beginShape();
    texture(catTexture);
    vertex(-300, -300, -200, 0,0);
    vertex( 300, -300, -200, 1,0);
    vertex( 300,  300, -200, 1,1);
    vertex(-300,  300, -200, 0,1);
  endShape();
  
  // Sphere
  shader(ballShader); // replace resetShader() with a call to use your own shader
  fill(#EEEEFF);
  
  if( hideShpere )
  {
    noStroke();
  }
  else
  {
    stroke(#DD0000);
  }
  
  sphereDetail(32);
  sphere(120);
}

void keyPressed() { keys(); };

void keys() {
  if (key==' ') {hideShpere=!hideShpere;} // space to hide stroke on sphere
  if (key=='a') {animate=!animate;}  // animate funky      [motion 1]
  if (key=='s') {rainbow=!rainbow;}  // rainbow color     [color]
  if (key=='d') {discard=!discard;}  // discard vertices  [color]
  if (key=='f') {pulsate=!pulsate;}  // pulsate, & use mouse movement [motion 2]
  if (key=='p') {play=!play;}  // pause and start time
  if (key=='1') {}  // combination key 1
  if (key=='2') {}  // combination key 2
}
