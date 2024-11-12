#version 300 es

precision highp float;

uniform vec2 uResolution;
// Control de la posició en el pla complex
uniform float uPlaneWidth;
uniform vec2 uPosition;


uniform int uMaxIterations;

out vec4 outColor;

vec3 hsv2rgb(vec3 c)
{
    vec4 K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
    vec3 p = abs(fract(c.xxx + K.xyz) * 6.0 - K.www);
    return c.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
}

void main() {
    //vec2 c = (gl_FragCoord.xy / uResolution - vec2(0.5)) * vec2((uResolution.x / uResolution.y) * uZoom, uZoom) + uOffset;

    vec2 planeSize = vec2(uPlaneWidth, uPlaneWidth * uResolution.y / uResolution.x);


    vec2 c = mix(
        uPosition - planeSize / 2.0,
        uPosition + planeSize / 2.0,
        gl_FragCoord.xy / uResolution.xy
    );

    //vec2 c = uZoom * vec2((gl_FragCoord.x - uResolution.x / 2.0) / uResolution.y, gl_FragCoord.y / uResolution.y - 0.5) + uPosition;


    vec2 z = vec2(0.0);

    int iterations;

    for (iterations = 0; iterations < uMaxIterations; ++iterations) {
       z = vec2(z.x * z.x - z.y * z.y, 2.0 * z.x * z.y) + c;

        if (dot(z, z) > 100.0) {
            outColor = vec4(hsv2rgb(vec3(float(iterations) / 200.0 + 5.0, 1, 0.68)), 1.0);
            return;
        }
    }

    outColor = vec4(0.0, 0.0, 0.0, 1.0);


}