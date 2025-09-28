shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture; // 明確聲明螢幕紋理
uniform float blur_amount : hint_range(0.0, 10.0) = 0.0;

void fragment() {
    vec4 color = texture(SCREEN_TEXTURE, SCREEN_UV, 0.0);
    vec4 blurred_color = vec4(0.0);
    float total = 0.0;
    for (float x = -4.0; x <= 4.0; x += 1.0) {
        for (float y = -4.0; y <= 4.0; y += 1.0) {
            vec2 offset = vec2(x, y) * blur_amount * 0.001;
            blurred_color += texture(SCREEN_TEXTURE, SCREEN_UV + offset, 0.0);
            total += 1.0;
        }
    }
    blurred_color /= total;
    COLOR = blurred_color;
}