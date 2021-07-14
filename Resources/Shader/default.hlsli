

// cbuffer: constant buffer
// One Constant (그래픽카드 레지스터에 등록되는 Root Table 단위)
// [API Bind slot]
// [root constant / root table / root descriptor]
//  => 데이터를 묘사(참조) 하는 용도. 실제 데이터는 없다.
// [b0(HLSL bind slot)]
cbuffer TEST_B0 : register(b0)
{
	float4 offset0;
};

cbuffer TEST_B1 : register(b1)
{
	float4 offset1;
};

Texture2D tex_0 : register(t0);
SamplerState sam_0 : register(s0); // Rasterize 단계에서 색상값을 골라주는 방식


struct VS_IN
{
	float3 pos : POSITION;
	float4 color : COLOR;
	float2 uv : TEXCOORD;
};

struct VS_OUT
{
	float4 pos : SV_Position;
	float4 color : COLOR;
	float2 uv : TEXCOORD;
};


VS_OUT VS_Main(VS_IN input)
{
	VS_OUT output = (VS_OUT)0;

	output.pos = float4(input.pos, 1.f);
	output.pos += offset0;
	output.color = input.color;
	output.uv = input.uv;

	return output;
}

float4 PS_Main(VS_OUT input) : SV_Target
{
	float4 color = tex_0.Sample(sam_0, input.uv);

	return color;
}