// KEMBLE HILDRETH

PShader catShader;
PShader ballShader;
PImage catTexture;

float offset = -10;


boolean hideShpere = false;  // toggle red stroke on sphere

boolean animate = false;    // toggle animation
boolean rainbow = false;    // toggle rainbow coloring
boolean discard = false;    // toggle discarding vertices
boolean pulsate = false;    // toggle a pulsating animation and color glow

boolean discard_1 = false;
boolean discard_2 = false;
boolean discard_3 = false;

boolean mouse_1 = false;

boolean animate_discard = false;

boolean waves = false;

boolean color_cycle = false;

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
  
  ballShader.set("mx",mouseX); // send time to shader
  ballShader.set("my",mouseY); // send time to shader
  
  // Send controls to vertex shader
  ballShader.set("ctr_animate",animate);  // turn on animation for shader
  ballShader.set("ctr_rainbow",rainbow);  // turn on rainbow for shader
  ballShader.set("ctr_pulsate",pulsate);  // turn on pulsate for shader
  ballShader.set("ctr_discard",discard);  // turn on discard for shader
  
  ballShader.set("ctr_discard1",discard_1);  // turn on discard for shader
  ballShader.set("ctr_discard2",discard_2);  // turn on discard for shader
  ballShader.set("ctr_discard3",discard_3);  // turn on discard for shader
  
  ballShader.set("ctr_mouse1",mouse_1);  // turn on mouse color effect
  ballShader.set("ctr_animate_discard",animate_discard);  // allow for discarded vertices to be animated
  ballShader.set("ctr_waves",waves);  // allow for discarded vertices to be animated
  ballShader.set("ctr_color_cycle",color_cycle);  // allow for discarded vertices to be animated
    
       
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
  
  if(pulsate)
  {
    fill(#22FFAA);
  }
  else if(animate)
  {
    fill(#FF2233);
  }
  else if(discard)
  {
    fill(#ffce00);
  }
  else if(waves)
  {
    fill(#1166ff);
  }
  else
  {
    fill(#BBBBFF);
  }
  
  if( hideShpere )
  {
    noStroke();
  }
  else
  {
    stroke(#CCCCFF);
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
  if (key=='1') {waves = true; hideShpere= true; animate = true; discard = true; discard_1 = true;}  // combination key 1
  if (key=='2') {pulsate = true; discard = true; discard_3 = true; animate_discard=false; rainbow=true;  hideShpere= true;}  // combination key 2
  if (key=='x') {pulsate = false; discard = false; animate = false; rainbow = false; hideShpere= false; animate_discard=false; waves=false;}  // reset all effects
  
  if (key=='j') {discard_1=!discard_1;}  // discard vertices mode 1  [color]
  if (key=='k') {discard_2=!discard_2;}  // discard vertices mode 1  [color]
  if (key=='l') {discard_3=!discard_3;}  // discard vertices mode 1  [color]
  
  if (key=='m') {mouse_1=!mouse_1;}  // discard vertices mode 1  [color]
  if (key==';') {animate_discard=!animate_discard;}  // animate discard vertices
  if (key=='w') {waves=!waves;}  // animate waves
  if (key=='c') {color_cycle=!color_cycle;}  // animate waves
}
