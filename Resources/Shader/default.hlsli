

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


struct VS_IN
{
	float3 pos : POSITION;
	float4 color : COLOR;
};

struct VS_OUT
{
	float4 pos : SV_Position;
	float4 color : COLOR;
};


VS_OUT VS_Main(VS_IN input)
{
	VS_OUT output = (VS_OUT)0;

	output.pos = float4(input.pos, 1.f);
	output.pos += offset0;
	output.color = input.color;
	output.color += offset1;

	return output;
}

float4 PS_Main(VS_OUT input) : SV_Target
{
	return input.color;
}