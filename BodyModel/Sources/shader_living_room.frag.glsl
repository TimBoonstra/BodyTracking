#version 450

#ifdef GL_ES
precision mediump float;
#endif

uniform sampler2D tex;

in vec2 texCoord;
in vec3 normal;
in vec3 lightDirection;
in vec3 eyeCoord;
in vec3 diffuseCol;
in vec3 specularCol;
in float specularColPow;

out vec4 FragColor;

void kore() {
	const float amb = 0.2;//0.4;
	
	vec4 ambient = vec4(amb, amb, amb, 1.0);
	
	vec3 nor = normalize(normal);
	vec3 lightDir = normalize(lightDirection);
	vec4 diffuse = max(dot(lightDir, nor), 0.0) * vec4(diffuseCol, 1.0);
	
	vec3 halfVector = normalize(lightDir - normalize(eyeCoord));
	vec4 specular = pow(max(0.0, dot(halfVector, nor)), specularColPow) * vec4(specularCol, 1.0);
	
	vec4 light = ambient + diffuse + specular;
	
	FragColor = light * texture(tex, texCoord);
}
