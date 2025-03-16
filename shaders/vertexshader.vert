 VARYING vec3 pos;
 VARYING vec2 texcoord;

 void MAIN()
 {
     pos = VERTEX;
     pos.x += sin(time * 4.0 + pos.y) * amplitude;
     texcoord = UV0;
     POSITION = MODELVIEWPROJECTION_MATRIX * vec4(pos, 1.0);
 }
