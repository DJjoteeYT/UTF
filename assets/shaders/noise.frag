#pragma header

uniform float iTime;
uniform float maxStrength; // 0.5
uniform float minStrength; // 0.125
uniform float speed; // 10.0

float random(vec2 noise)
{
  return fract(sin(dot(noise.xy, vec2(10.998, 98.233))) * 12433.14159265359);
}

void main(void)
{
  //--- Strength animate ---
  maxStrength = clamp(sin(iTime / 2.0), minStrength, maxStrength);

  vec3 colour = vec3(random(fract(openfl_TextureCoordv * fract(sin(iTime * speed))).xy)) * maxStrength;

  gl_FragColor = vec4(vec3(flixel_texture2D(bitmap, openfl_TextureCoordv)) - colour, 1.0);
}