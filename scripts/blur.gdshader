shader_type canvas_item;

// This captures the screen behind the node
uniform sampler2D screen_texture : hint_screen_texture, filter_linear_mipmap;
uniform int strength: hint_range(1, 100) = 10;

void fragment() {
    vec2 pixel_size = SCREEN_PIXEL_SIZE;
    vec4 color = vec4(0.0);
    float total_weight = 0.0;
    float f_strength = float(strength);

    // Simple box blur using SCREEN_TEXTURE
    for(float x = -f_strength; x <= f_strength; x++) {
        for(float y = -f_strength; y <= f_strength; y++) {
            color += texture(screen_texture, SCREEN_UV + vec2(x, y) * pixel_size);
            total_weight += 1.0;
        }
    }
    
    COLOR = color / total_weight;
}