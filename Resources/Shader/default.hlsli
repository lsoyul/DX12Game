

// cbuffer: constant buffer
// One Constant (그래픽카드 레지스터에 등록되는 Root Table 단위)
// [API Bind slot]
// [root constant / root table / root descriptor]
//  => 데이터를 묘사(참조) 하는 용도. 실제 데이터는 없다.
// [b0(HLSL bind slot)]
cbuffer TRANSFORM_PARAMS : register(b0)
{
	// row_major -> 행렬 접근순서 정의 (DirectX와 쉐이더에서 행렬 값 접근순서가 다르기 때문)
	row_major matrix matWVP;
};

cbuffer MATERIAL_PARAMS : register(b1)
{
	int int_0;
	int int_1;
	int int_2;
	int int_3;
	int int_4;
	float float_0;
	float float_1;
	float float_2;
	float float_3;
	float float_4;
};

Texture2D tex_0 : register(t0);
Texture2D tex_1 : register(t1);
Texture2D tex_2 : register(t2);
Texture2D tex_3 : register(t3);
Texture2D tex_4 : register(t4);

SamplerState sam_0 : register(s0); // Rasterize 단계에서 색상값을 골라주는 방식


struct VS_IN
{
	float3 pos : POSITION;
	float2 uv : TEXCOORD;
};

struct VS_OUT
{
	float4 pos : SV_Position;
	float2 uv : TEXCOORD;
};


VS_OUT VS_Main(VS_IN input)
{
	VS_OUT output = (VS_OUT)0;

	output.pos = mul(float4(input.pos, 1.f), matWVP);
	output.uv = input.uv;

	return output;
}

float4 PS_Main(VS_OUT input) : SV_Target
{
	float4 color = tex_0.Sample(sam_0, input.uv);

	return color;
}