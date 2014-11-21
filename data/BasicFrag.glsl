// Fragment shader
// The fragment shader is run once for every /pixel/ (not vertex!)
// It can change the color and transparency of the fragment.

#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_LIGHT_SHADER

// Space for uniform variables ( you can make your own! =D )
// Pass in things from Processing with shader.set("variable_name", value);
// Then declare them here with: uniform float variable_name;

uniform float myTime;
uniform bool ctr_animate;
uniform bool ctr_discard;
uniform bool ctr_pulsate;
uniform bool ctr_rainbow;


// These values come from the vertex shader
varying vec4 vertColor;
varying vec3 vertNormal;
varying vec3 vertLightDir;
varying vec4 vertPos;

void main() {  
  float intensity;
  
  // vec4 because RGBA
  vec4 color;
  // simple diffuse lighting
  intensity = max(0.0, dot(vertLightDir, vertNormal));
  
  
  color.rgb = vec3(intensity);
  color.a = 1;
  //color.r *= 0.5; // make it kind of cyan by decreasing red,
                  // just as an example. feel free to change
                  // this.
				  
				  
	if(ctr_rainbow) // make colors rainbow
	{		
		// Make ball gradient rainbow and animate
		color.r = vertNormal.x + cos(myTime)*100;
		color.g = vertNormal.z + cos(myTime)/90;
		color.b = vertNormal.y + cos(myTime)/30;
	} 
  
  
  if(ctr_discard) // discard vertices
  {
	  if(vertPos.x > vertPos.y )
	  {
		discard;
	  }
  }
  
  
  
  
  
  // The "return value" of a fragment shader
  gl_FragColor = color * vertColor;
}