uniform mat4 projection_matrix;
attribute vec4 position;
varying vec2 fractal_position;

void main() {
    gl_Position = projection_matrix * position;
    fractal_position = vec2(-position.y, position.x);
    fractal_position -= vec2(0.50, 0);
    fractal_position *= 1.5;
}