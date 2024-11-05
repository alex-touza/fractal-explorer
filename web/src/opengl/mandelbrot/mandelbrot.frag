#version 300 es

precision highp float;

uniform vec2 uResolution;

// Control de la posició en el pla complex
uniform float uZoom;
uniform vec2 uOffset;


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

    vec2 c = uZoom * vec2((gl_FragCoord.x - 0.5 * uResolution.x) / uResolution.y, gl_FragCoord.y / uResolution.y - 0.5) + uOffset;


    vec2 z = vec2(0.0);

    int iterations;

    for (iterations = 0; iterations < uMaxIterations; ++iterations) {
       z = vec2(z.x * z.x - z.y * z.y, 2.0 * z.x * z.y) + c;

        if (dot(z, z) > 100.0) {
            outColor = vec4(hsv2rgb(vec3(float(iterations) / 100.0 + 5.0, 1, 0.68)), 1.0);
            return;
        }
    }

    outColor = vec4(0.0, 0.0, 0.0, 1.0);


}