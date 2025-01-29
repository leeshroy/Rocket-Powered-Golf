shader_type spatial;
render_mode unshaded, cull_front;

uniform vec3 outline_color;
uniform float outline_size;

void vertex() {
	// Called for every vertex the material is visible on.
	VERTEX += NORMAL* outline_size;
}

void fragment() {
	// Called for every pixel the material is visible on.
	ALBEDO = outline_color;
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
