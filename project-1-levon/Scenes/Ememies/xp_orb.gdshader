shader_type canvas_item;

// Number of color levels per channel
uniform float levels : hint_range(1.0, 255.0) = 4.0; 
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

void fragment() {
    vec4 color = texture(SCREEN_TEXTURE, SCREEN_UV);
    
    // Posterize: Multiply by levels, round, then divide back
    color.rgb = floor(color.rgb * levels) / levels;
    
    COLOR = color;
}