 VARYING vec3 pos;
 VARYING vec2 texcoord;

 void MAIN()
 {
     vec4 c = texture(tex, texcoord);
     FRAGCOLOR = vec4(pos.x * 0.02, pos.y * 0.02, pos.z * 0.02, alpha) * c;
 }
