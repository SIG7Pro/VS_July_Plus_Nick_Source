#pragma header
uniform float edgeIntense;
vec3 getRainbowColor(in float val) {
    /*convert to rainbow RGB*/
    float r = 0.;
    float g = 0.;
    float b = 0.;
        r = 1.; g = 1.0; b = 1.;
    return vec3(r, g, b);
}

float d;

float lookup(vec2 p, float dx, float dy, float edgeIntensity)
{
    vec2 uv = (p.xy + vec2(dx * edgeIntensity, dy * edgeIntensity)) / openfl_TextureSize;
    vec4 c = textureCam(bitmap, uv.xy);
	
	// return as luma
    return 0.2126*c.r + 0.7152*c.g + 0.0722*c.b;
}

void main()
{
	vec2 fragCoord = getCamPos(openfl_TextureCoordv)* openfl_TextureSize;
    float timeNorm = 5;
    vec3 glowCol = getRainbowColor(timeNorm);
    float edgeIntensity = edgeIntense;
    vec2 p = fragCoord.xy;
    
	// simple sobel edge detection
    float gx = 0.0;
    gx += -1.0 * lookup(p, -1.0, -1.0, edgeIntensity);
    gx += -2.0 * lookup(p, -1.0,  0.0, edgeIntensity);
    gx += -1.0 * lookup(p, -1.0,  1.0, edgeIntensity);
    gx +=  1.0 * lookup(p,  1.0, -1.0, edgeIntensity);
    gx +=  2.0 * lookup(p,  1.0,  0.0, edgeIntensity);
    gx +=  1.0 * lookup(p,  1.0,  1.0, edgeIntensity);
    
    float gy = 0.0;
    gy += -1.0 * lookup(p, -1.0, -1.0, edgeIntensity);
    gy += -2.0 * lookup(p,  0.0, -1.0, edgeIntensity);
    gy += -1.0 * lookup(p,  1.0, -1.0, edgeIntensity);
    gy +=  1.0 * lookup(p, -1.0,  1.0, edgeIntensity);
    gy +=  2.0 * lookup(p,  0.0,  1.0, edgeIntensity);
    gy +=  1.0 * lookup(p,  1.0,  1.0, edgeIntensity);
    
	// hack: use g^2 to conceal noise in the video
    float g = gx*gx + gy*gy;
    
    vec4 col = textureCam(bitmap, p / openfl_TextureSize.xy);
    col += vec4(g * glowCol, 1.0);
    
    gl_FragColor = col;
}