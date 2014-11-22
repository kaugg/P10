// Vertex shader
// The vertex shader is run once for every /vertex/ (not pixel)!
// It can change the (x,y,z) of the vertex, as well as its normal for lighting.
// KEMBLE HILDRETH

// Set automatically by Processing
uniform mat4 transform;
uniform mat3 normalMatrix;
uniform vec3 lightNormal;

// Space for uniform variables ( you can make your own! =D )
// Pass in things from Processing with shader.set("variable_name", value);
// Then declare them here with: uniform float variable_name;

uniform float mx;
uniform float my;

uniform float myTime;
uniform bool ctr_animate;
uniform bool ctr_discard;
uniform bool ctr_pulsate;
uniform bool ctr_rainbow;

uniform bool ctr_mouse1;

uniform bool ctr_waves;


// Come from the geometry/material of the object
attribute vec4 vertex;
attribute vec4 color;
attribute vec3 normal;

// These values will be sent to the fragment shader
varying vec4 vertColor;
varying vec3 vertNormal;
varying vec3 vertLightDir;
varying vec4 vertPos;

void main() {
  vertColor = color;
  
  vertNormal = normalize(normalMatrix * normal);
  
  // We have to create a copy of vertex because modifying
  // attribute variables is against the rules
  vec4 vert = vertex;  
  
  
  
  
  if(ctr_animate) // enable animation
  {
    // This animates the ball
	vert.x = vert.x - cos(myTime)*100;
	vert.z = vert.z - cos(myTime)*100;
	vert.y = vert.y/(cos(myTime/2));  
  }	
	
  if(ctr_waves) // enable waves
  {
    // This animates the ball
	vert.x = vert.x + 10*cos(myTime)*sin(vert.y);
	//vert.y = vert.y + 10*cos(myTime)*sin(vert.y);  
	//vert.z = vert.z + 10*cos(myTime)*sin(vert.x);  
  }	
	
  if(ctr_pulsate) // enable pulsate
  {
    // This animates the ball
	vert.x = vert.x;
	vert.z = vert.z-50*(sin(myTime*2));
	vert.y = vert.y;  
  }	
	
   if(ctr_discard) // discard vertices
  {
	  //vert.x = vert.x-sin(myTime)*100;
	  //vert.z = vert.y;
	  //vert.y = vert.z; 
  }
	
	
  // think of gl_Position as a return value for vertex shaders
  gl_Position = transform * vert; 
  vertLightDir = -lightNormal;
  vertPos = vert;
}