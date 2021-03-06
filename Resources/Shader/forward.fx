#ifndef _DEFAULT_FX_
#define _DEFAULT_FX_

#include "params.fx"
#include "utils.fx"

// cbuffer: constant buffer
// One Constant (그래픽카드 레지스터에 등록되는 Root Table 단위)
// [API Bind slot]
// [root constant / root table / root descriptor]
//  => 데이터를 묘사(참조) 하는 용도. 실제 데이터는 없다.

struct VS_IN
{
	float3 pos : POSITION;
	float2 uv : TEXCOORD;
	float3 normal : NORMAL;
	float3 tangent : TANGENT;
};

struct VS_OUT
{
	float4 pos : SV_Position;
	float2 uv : TEXCOORD;
	float3 viewPos : POSITION;
	float3 viewNormal : NORMAL;
	float3 viewTangent : TANGENT;
	float3 viewBinormal : BINORMAL;
};


VS_OUT VS_Main(VS_IN input)
{
	VS_OUT output = (VS_OUT)0;

	output.pos = mul(float4(input.pos, 1.f), g_matWVP);
	output.uv = input.uv;

	output.viewPos = mul(float4(input.pos, 1.f), g_matWV).xyz;

	// Tangent Normal Binormal => to View Matrix
	output.viewNormal = normalize(mul(float4(input.normal, 0.f), g_matWV).xyz);
	output.viewTangent = normalize(mul(float4(input.tangent, 0.f), g_matWV).xyz);
	output.viewBinormal = normalize(cross(output.viewTangent, output.viewNormal)); 

	return output;
}

float4 PS_Main(VS_OUT input) : SV_Target
{
	float4 color = float4(1.f, 1.f, 1.f, 1.f);
	if(g_tex_on_0)
		color = g_tex_0.Sample(g_sam_0, input.uv);

	float3 viewNormal = input.viewNormal;
	if (g_tex_on_1)
	{
		// [0, 255] 범위에서 [0, 1] 로 변환 (Sampler 특징)
		float3 tangentSpaceNormal = g_tex_1.Sample(g_sam_0, input.uv).xyz;
		// [0, 1] 범위에서 [-1, 1] 로 변환
		tangentSpaceNormal = (tangentSpaceNormal - 0.5f) * 2.f;
		float3x3 matTBN = { input.viewTangent, input.viewBinormal, input.viewNormal };
		viewNormal = normalize(mul(tangentSpaceNormal, matTBN));
	}
	//float4 color = float4(1.f, 1.f, 1.f, 1.f);

	LightColor totalColor = (LightColor)0.f;

	for (int i = 0; i < g_lightCount; ++i)
	{
		 LightColor color = CalculateLightColor(i, viewNormal, input.viewPos);
		 totalColor.diffuse += color.diffuse;
		 totalColor.ambient += color.ambient;
		 totalColor.specular += color.specular;
	}

	color.xyz = (totalColor.diffuse.xyz * color.xyz)	// 색상 기준
		+ totalColor.ambient.xyz * color.xyz			// 색상 기준
		+ totalColor.specular.xyz;						// 광택

	 return color;
}


// [Texture Shader]
// g_tex_0 : Output Texture
// AlphaBlend : true
struct VS_TEX_IN
{
	float3 pos : POSITION;
	float2 uv : TEXCOORD;
};

struct VS_TEX_OUT
{
	float4 pos : SV_Position;
	float2 uv : TEXCOORD;
};

VS_TEX_OUT VS_Tex(VS_TEX_IN input)
{
	VS_TEX_OUT output = (VS_TEX_OUT)0;

	output.pos = mul(float4(input.pos, 1.f), g_matWVP);
	output.uv = input.uv;

	return output;
}

float4 PS_Tex(VS_TEX_OUT input) : SV_Target
{
	float4 color = float4(1.f, 1.f, 1.f, 1.f);
	if (g_tex_on_0)
		color = g_tex_0.Sample(g_sam_0, input.uv);

	return color;
}


#endif