#version 300 es

precision highp float;

uniform vec2 uResolution;

// Control de la posició en el pla complex
uniform float uZoom;
uniform vec2 uOffset;


uniform int uMaxIterations;

out vec4 outColor;

void main() {
    vec2 c = (gl_FragCoord.xy / uResolution - vec2(0.5)) * uZoom + uOffset;

    vec2 z = vec2(0.0);

    int iterations;

    for (iterations = 0; iterations < uMaxIterations; ++iterations) {
       z = vec2(z.x * z.x - z.y * z.y, 2.0 * z.x * z.y) + c;

        if (dot(z, z) > 4.0) break;
    }

    float colorValue = float(iterations) / float(uMaxIterations);

    outColor = vec4(vec3(1, 1, 0.8) - vec3(colorValue), 1.0);
}