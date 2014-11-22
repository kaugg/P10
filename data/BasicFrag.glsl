// Fragment shader
// The fragment shader is run once for every /pixel/ (not vertex!)
// It can change the color and transparency of the fragment.
// KEMBLE HILDRETH

#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_LIGHT_SHADER

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

uniform bool ctr_discard1;
uniform bool ctr_discard2;
uniform bool ctr_discard3;

uniform bool ctr_mouse1;

uniform bool ctr_animate_discard = false;

uniform bool ctr_waves;

uniform bool ctr_color_cycle;

// These values come from the vertex shader
varying vec4 vertColor;
varying vec3 vertNormal;
varying vec3 vertLightDir;
varying vec4 vertPos;

void main() {  
  float intensity;
  float time_cos;
  
  // vec4 because RGBA
  vec4 color;
  // simple diffuse lighting
  intensity = max(0.0, dot(vertLightDir, vertNormal));
  
  
  color.rgb = vec3(intensity);
  color.a = 1;
  //color.r *= 0.5; // make it kind of cyan by decreasing red,
                  // just as an example. feel free to change
                  // this.
			


	if(ctr_animate_discard)
	{
		time_cos = cos(myTime);
	}
	else
	{
		time_cos = 1;
	}

	if(ctr_waves)
	{
		color.a = 0.9;
	}
	
	if(ctr_color_cycle)
	{
		color.r = cos(myTime/640);
		color.g = cos(myTime/640);
		color.b = cos(myTime/640);
	}
				  
	if(ctr_rainbow) // make colors rainbow
	{		
		// Make ball gradient rainbow and animate
		color.r = vertNormal.x + cos(myTime)*100;
		color.g = vertNormal.z + cos(myTime)/90;
		color.b = vertNormal.y + cos(myTime)/30;
	} 
  
  
  if(ctr_discard) // discard vertices
  {
	  // MODE 1
	  if( (cos(vertPos.x*0.3)*cos(vertPos.x*0.3) > sin(vertPos.y*0.3)*sin(vertPos.y*0.3)*time_cos) &&
			(ctr_discard1))
	  {
      discard;
	  }
	  
	  // MODE 2
	  if((cos(vertPos.z*0.3)*cos(vertPos.x*0.3)*time_cos > sin(vertPos.x*0.3)*sin(vertPos.y*0.3)) &&
			(ctr_discard2))
	  {
        discard;
	  }  
	  
	  // MODE 3
	  if((cos(vertPos.z*0.3)*cos(vertPos.z*0.3)*time_cos > sin(vertPos.x*0.3)*sin(vertPos.y*0.3)) &&
			(ctr_discard3))
	  {
        discard;
	  }
	  
  }
  
  if(ctr_mouse1)
  {
		color.r = mx/my;
		color.g = 0.2;
		color.b = 0.8;
  }
  
  
  // The "return value" of a fragment shader
  gl_FragColor = color * vertColor;
}