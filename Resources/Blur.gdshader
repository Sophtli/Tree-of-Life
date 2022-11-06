shader_type canvas_item;

void fragment() {
	COLOR = textureLod(SCREEN_TEXTURE, SCREEN_UV, 2.5);
	COLOR.rgb *= 1.0;
}
