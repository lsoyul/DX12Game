#ifndef _PARAMS_HLSLI_
#define _PARAMS_HLSLI_

struct LightColor
{
	float4 diffuse;
	float4 ambient;
	float4 specular;
};

struct LightInfo
{
	LightColor	color;
	float4		position;
	float4		direction;
	int			lightType;
	float		range;
	float		angle;
	int			padding;
	// 데이터의 사이즈를 16 byte의 배수가 되게 하기위함. (Packing Rule for Constant Variables)
	// * HLSL 쉐이더 룰
};


// [b0(HLSL bind slot)]
cbuffer GLOBAL_PARAMS : register(b0)
{
	int			g_lightCount;
	int			g_lightPadding;
	LightInfo	g_light[50];
}

cbuffer TRANSFORM_PARAMS : register(b1)
{
	// row_major -> 행렬 접근순서 정의 (DirectX와 쉐이더에서 행렬 값 접근순서가 다르기 때문)
	row_major matrix g_matWorld;
	row_major matrix g_matView;
	row_major matrix g_matProjection;
	row_major matrix g_matWV;
	row_major matrix g_matWVP;
};

cbuffer MATERIAL_PARAMS : register(b2)
{
	int		g_int_0;
	int		g_int_1;
	int		g_int_2;
	int		g_int_3;
	int		g_int_4;
	float	g_float_0;
	float	g_float_1;
	float	g_float_2;
	float	g_float_3;
	float	g_float_4;
};

Texture2D g_tex_0 : register(t0);
Texture2D g_tex_1 : register(t1);
Texture2D g_tex_2 : register(t2);
Texture2D g_tex_3 : register(t3);
Texture2D g_tex_4 : register(t4);

SamplerState g_sam_0 : register(s0); // Rasterize 단계에서 색상값을 골라주는 방식

#endif