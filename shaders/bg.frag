// ignore-line
#include <flutter/runtime_effect.glsl>

uniform float iTime;
uniform vec2 iResolution;
out vec4 fragColor;

const float PI = 3.14159265359;

void mainImage(out vec4 fragColor, in vec2 fragCoord)
{
  float x = fragCoord.x / iResolution.x;
  float y = fragCoord.y / iResolution.y;

  float r = 0.0;
  float g = 0.0;
  float b = 0.0;
  float a = 1.0;

  float offset = 0.5 * sin(iTime * PI);

  if (x > 0.5 + offset)
  {
    r = 1.0;
  }
  if (y < 0.5)
  {
    g = 1.0;
  }

  fragColor = vec4(r, g, b, a);
  // vec2 uv = -1.0 + 2.0 * fragCoord.xy / iResolution.xy;
  // uv.x *= iResolution.x / iResolution.y;
  // // uv *= 10.0;
  // // vec2 p = uv;
  // // p.x += 0.1 * sin(iTime / 100);
  // // p.y += 0.5 * cos(iTime);
  // // float r = 5;
  // // float c = circle(p, r);
  // return;
  // discard;
  // float center_dist = length(uv);
  // if (center_dist < 0.01)
  // {
  //   return;
  //   discard;
  // }

  // fragColor = vec4(1.0);

  // return if black
  // if (c < 0.1)
  // {
  //   return;
  // }

  // fragColor = vec4(hsv(r + 0.0, 0.6, c), 1.0);
}

void main() { mainImage(fragColor, FlutterFragCoord().xy); }
