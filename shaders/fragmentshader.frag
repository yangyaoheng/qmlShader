#version 440 core
layout(std140, binding = 0) uniform buf {
    mat4 qt_Matrix;
    float qt_Opacity;
};
in vec2 texCoord;
out vec4 fragColor;

void main() {
    vec4 baseColor = vec4(0.5, 0.0, 1.0, 1.0);
    float gradient = smoothstep(0.2, 0.8, texCoord.x);
    fragColor = mix(baseColor, vec4(1.0, 1.0, 0.0, 1.0), gradient) * qt_Opacity;
}