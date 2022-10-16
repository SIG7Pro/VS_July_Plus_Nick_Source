#pragma header
uniform float chromatic;
vec3 sampleSplit(sampler2D tex, vec2 coord)
{
	vec3 frag;
	frag.r = textureCam(tex, vec2(coord.x - chromatic, coord.y)).r;
	frag.g = textureCam(tex, vec2(coord.x       , coord.y)).g;
	frag.b = textureCam(tex, vec2(coord.x + chromatic, coord.y)).b;
	return frag;
}

void main()
{
	vec3 tempRGB = sampleSplit(bitmap, getCamPos(openfl_TextureCoordv));
	gl_FragColor = textureCam(bitmap, getCamPos(openfl_TextureCoordv)) * 1.5;
	gl_FragColor.rgb -= tempRGB.rgb;
}