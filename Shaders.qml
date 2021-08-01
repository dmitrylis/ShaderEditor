pragma Singleton

import QtQuick 2.12

QtObject {

    /////////////////////////////////////////////////////////////////////////////////////////
    //
    // FRAGMENT SHADERS
    //
    /////////////////////////////////////////////////////////////////////////////////////////

    readonly property string emptyShader: "\
#ifdef GL_ES
precision lowp float;
#endif

uniform sampler2D source;
uniform float qt_Opacity;
varying highp vec2 qt_TexCoord0;

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

void main() {
    vec4 p = texture2D(source, qt_TexCoord0);

    // some code here

    gl_FragColor = p * qt_Opacity;
}"

    readonly property string emptyUvShader: "\
#ifdef GL_ES
precision lowp float;
#endif

uniform sampler2D source;
uniform float qt_Opacity;
varying highp vec2 qt_TexCoord0;

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

void main() {
    vec2 st = qt_TexCoord0;

    vec2 uv = st; // modify UV here

    gl_FragColor = texture2D(source, uv);
}"

    readonly property string greyscaleShader: "\
#ifdef GL_ES
precision lowp float;
#endif

uniform sampler2D source;
uniform float qt_Opacity;
varying highp vec2 qt_TexCoord0;

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

void main() {
    vec4 p = texture2D(source, qt_TexCoord0);
    float g = dot(p.xyz, vec3(0.344, 0.5, 0.156));
    gl_FragColor = vec4(g, g, g, p.a) * qt_Opacity;
}"

    readonly property string simpleShader: "\
#ifdef GL_ES
precision lowp float;
#endif

uniform sampler2D source;
uniform float qt_Opacity;
varying highp vec2 qt_TexCoord0;

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

void main() {
    vec2 st = gl_FragCoord.xy / u_resolution;
    //vec2 st = qt_TexCoord0;

    gl_FragColor = vec4(st.x, st.y, 0.0, 1.0);
}"

    readonly property string linearDemoShader: "\
#ifdef GL_ES
precision lowp float;
#endif

uniform sampler2D source;
uniform float qt_Opacity;
varying highp vec2 qt_TexCoord0;

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

// Plot a line on Y using a value between 0.0 - 1.0
float plot(vec2 st) {
    return smoothstep(0.02, 0.0, abs(st.y - st.x));
}

void main() {
    vec2 st = qt_TexCoord0;

    float y = st.x;

    vec3 color = vec3(y);

    // Plot a line
    float pct = plot(st);
    color = (1.0 - pct) * color + pct * vec3(0.0, 1.0, 0.0);

    gl_FragColor = vec4(color, 1.0);
}"

    readonly property string expoDemoShader: "\
#ifdef GL_ES
precision lowp float;
#endif

uniform sampler2D source;
uniform float qt_Opacity;
varying highp vec2 qt_TexCoord0;

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

#define PI 3.14159265359

float plot(vec2 st, float pct) {
  return smoothstep(pct - 0.02, pct, st.y) - smoothstep(pct, pct + 0.02, st.y);
}

void main() {
    vec2 st = qt_TexCoord0;

    float y = pow(st.x, 5.0);

    vec3 color = vec3(y);

    float pct = plot(st, y);
    color = (1.0 - pct) * color + pct * vec3(0.0, 1.0, 0.0);

    gl_FragColor = vec4(color, 1.0);
}"

    readonly property string russiaFlagShader: "\
#ifdef GL_ES
precision lowp float;
#endif

uniform sampler2D source;
uniform float qt_Opacity;
varying highp vec2 qt_TexCoord0;

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

vec3 colorA = vec3(0.97, 0.97, 0.97);
vec3 colorB = vec3(0.1, 0.1, 1.0);
vec3 colorC = vec3(1.0, 0.03, 0.03);

void main() {
    float y = qt_TexCoord0.y;

    //vec3 color = (1.0 - step(0.33, y)) * colorA + step(0.33, y) * (1.0 - step(0.66, y)) * colorB + step(0.66, y) * colorC;

    vec3 color = mix(mix(colorA, colorB, step(0.33, y)), colorC, step(0.66, y));
    gl_FragColor = vec4(color, 1.0);
}"

    readonly property string circleShader: "\
#ifdef GL_ES
precision mediump float;
#endif

uniform sampler2D source;
uniform float qt_Opacity;
varying highp vec2 qt_TexCoord0;

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

void main(){
    vec2 st = qt_TexCoord0;
    st.y *= u_resolution.y / u_resolution.x; // adjust to keep the aspect ratio

    float pct = 0.0;

    // a. The DISTANCE from the pixel to the center
    pct = distance(st, vec2(0.5));

    // b. The LENGTH of the vector
    //    from the pixel to the center
    // vec2 toCenter = vec2(0.5) - st;
    // pct = length(toCenter);

    // c. The SQUARE ROOT of the vector
    //    from the pixel to the center
    // vec2 tC = vec2(0.5) - st;
    // pct = sqrt(tC.x * tC.x + tC.y * tC.y);

    vec3 color = mix(vec3(1.0), vec3(0.0), step(0.35, pct));

    gl_FragColor = vec4(color, 1.0);
}"

    readonly property string distanceFieldShader: "\
#ifdef GL_ES
precision lowp float;
#endif

uniform sampler2D source;
uniform float qt_Opacity;
varying highp vec2 qt_TexCoord0;

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

void main(){
  vec2 st = qt_TexCoord0;
  st.x *= u_resolution.x / u_resolution.y;
  vec3 color = vec3(0.0);
  float d = 0.0;

  // Remap the space to -1. to 1.
  st = st * 2.0 - 1.0;

  // Make the distance field
  d = length(abs(st) - 0.3);
  // d = length(min(abs(st) - 0.3, 0.0));
  // d = length(max(abs(st) - 0.3, 0.0));

  // Visualize the distance field
  gl_FragColor = vec4(vec3(fract(d * 10.0)), 1.0);

  // Drawing with the distance field
  // gl_FragColor = vec4(vec3(step(0.3, d) ),1.0);
  // gl_FragColor = vec4(vec3(step(0.3, d) * step(d, 0.4)), 1.0);
  // gl_FragColor = vec4(vec3(smoothstep(0.3, 0.4, d) * smoothstep(0.6, 0.5, d)), 1.0);
}"

    readonly property string polarCoordinatesShader1: "\
#ifdef GL_ES
precision lowp float;
#endif

uniform sampler2D source;
uniform float qt_Opacity;
varying highp vec2 qt_TexCoord0;

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

#define PI 3.14159265358979323844

void main() {
    vec2 st = qt_TexCoord0;

    vec2 pos = st - vec2(0.5);
    float r = length(pos) * 2.0;
    float a = atan(pos.y, pos.x);

    vec2 uv = vec2(r, a * 0.5 / PI + 0.5);
    gl_FragColor = texture2D(source, uv);
}"

    readonly property string polarCoordinatesShader2: "\
#ifdef GL_ES
precision lowp float;
#endif

uniform sampler2D source;
uniform float qt_Opacity;
varying highp vec2 qt_TexCoord0;

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

#define PI 3.14159265358979323844

void main(){
    vec2 st = qt_TexCoord0;
    vec3 color = vec3(0.0);

    vec2 pos = vec2(0.5) - st;

    float r = length(pos) * 2.0;
    float a = atan(pos.y, pos.x);

    float f = cos(a * 3.0);
    // f = abs(cos(a * 3.0));
    // f = abs(cos(a * 2.5)) * 0.5 + 0.3;
    // f = abs(cos(a * 12.0)*sin(a * 3.0)) * 0.8 + 0.1;
    // f = smoothstep(-0.5, 1.0, cos(a * 10.0)) * 0.2 + 0.5;

    color = vec3(1.0 - smoothstep(f, f + 0.02, r));

    gl_FragColor = vec4(color, 1.0);
}"

    readonly property string rippleEffectShader1: "\
#ifdef GL_ES
precision lowp float;
#endif

#define PI 3.14159265359

uniform sampler2D source;
uniform float qt_Opacity;
varying highp vec2 qt_TexCoord0;

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

void main() {
    vec2 st = qt_TexCoord0;
    vec2 uv = vec2(st.x + 0.015 * sin(10.0 * PI * st.y + 5.0 * u_time), st.y + 0.015 * sin(10.0 * PI * st.x + 5.0 * u_time)); // modify UV here
    gl_FragColor = texture2D(source, uv);
}"

    readonly property string rippleEffectShader2: "\
#ifdef GL_ES
precision lowp float;
#endif

uniform sampler2D source;
uniform float qt_Opacity;
varying highp vec2 qt_TexCoord0;

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

void main(){
    float intensity = 0.06;
    vec2 p = -1.0 + 2.0 * qt_TexCoord0 - vec2(0, -u_mouse.y * 0.001);
    float cLength = length(p);

    vec2 uv = qt_TexCoord0 + (p / cLength) * cos(cLength * 15.0 - u_time * 4.0) * intensity;

    gl_FragColor = texture2D(source, uv);
}"

    readonly property string heatHazeAirShader: "\
#ifdef GL_ES
precision lowp float;
#endif

uniform sampler2D source;
uniform float qt_Opacity;
varying highp vec2 qt_TexCoord0;

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

float noise(float x)
{
    return sin(x * 100.0) * 0.1 + sin((x * 200.0) + 3.0) * 0.05 +
            fract(sin((x * 19.0) + 1.0) * 33.33) * 0.13;
}

void main()
{
    vec2 p_m = qt_TexCoord0;
    vec2 p_d = p_m;

    p_d.xy -= u_time * 0.1;

   vec2 dst_map_val = vec2(noise(p_d.y), noise(p_d.x));

    vec2 dst_offset = dst_map_val.xy;
    dst_offset -= vec2(0.5, 0.5);
    dst_offset *= 2.0;
    dst_offset *= 0.01;

    //reduce effect towards Y top
    dst_offset *= (1.0 - p_m.t);

    vec2 dist_tex_coord = p_m.st + dst_offset;
    gl_FragColor = texture2D(source, dist_tex_coord);
}"

    readonly property string complexFogShader: "\
#ifdef GL_ES
precision lowp float;
#endif

uniform sampler2D source;
uniform float qt_Opacity;
varying highp vec2 qt_TexCoord0;

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

float random (in vec2 _st) {
    return fract(sin(dot(_st.xy, vec2(12.9898, 78.233))) * 43758.5453123);
}

// Based on Morgan McGuire @morgan3d
// https://www.shadertoy.com/view/4dS3Wd
float noise (in vec2 _st) {
    vec2 i = floor(_st);
    vec2 f = fract(_st);

    // Four corners in 2D of a tile
    float a = random(i);
    float b = random(i + vec2(1.0, 0.0));
    float c = random(i + vec2(0.0, 1.0));
    float d = random(i + vec2(1.0, 1.0));

    vec2 u = f * f * (3.0 - 2.0 * f);

    return mix(a, b, u.x) +
            (c - a)* u.y * (1.0 - u.x) +
            (d - b) * u.x * u.y;
}

#define NUM_OCTAVES 5

float fbm(in vec2 _st) {
    float v = 0.0;
    float a = 0.5;
    vec2 shift = vec2(100.0);
    // Rotate to reduce axial bias
    mat2 rot = mat2(cos(0.5), sin(0.5), -sin(0.5), cos(0.50));
    for (int i = 0; i < NUM_OCTAVES; ++i) {
        v += a * noise(_st);
        _st = rot * _st * 2.0 + shift;
        a *= 0.5;
    }
    return v;
}

void main() {
    vec2 st = qt_TexCoord0 * 3.0;
    // st += st * abs(sin(u_time * 0.1) * 3.0);
    vec3 color = vec3(0.0);

    vec2 q = vec2(0.0);
    q.x = fbm(st + 0.00 * u_time);
    q.y = fbm(st + vec2(1.0));

    vec2 r = vec2(0.0);
    r.x = fbm(st + 1.0 * q + vec2(1.7, 9.2) + 0.15 * u_time);
    r.y = fbm(st + 1.0 * q + vec2(8.3, 2.8) + 0.126 * u_time);

    float f = fbm(st + r);

    color = mix(vec3(0.101961, 0.619608, 0.666667),
                vec3(0.666667, 0.666667, 0.498039),
                clamp((f * f) * 4.0, 0.0, 1.0));

    color = mix(color,
                vec3(0.0, 0.0, 0.164706),
                clamp(length(q), 0.0, 1.0));

    color = mix(color,
                vec3(0.666667, 1.0, 1.0),
                clamp(length(r.x), 0.0, 1.0));

    gl_FragColor = vec4((f * f * f + 0.6 * f * f + 0.5 * f) * color, 1.0);
}"


    /////////////////////////////////////////////////////////////////////////////////////////
    //
    // VERTEX SHADERS
    //
    /////////////////////////////////////////////////////////////////////////////////////////

    readonly property string defaultVertexShader: "\
uniform highp mat4 qt_Matrix;
attribute highp vec4 qt_Vertex;
attribute highp vec2 qt_MultiTexCoord0;
varying highp vec2 qt_TexCoord0;

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

void main() {
    qt_TexCoord0 = qt_MultiTexCoord0;
    gl_Position = qt_Matrix * qt_Vertex;
}"
}
