#pragma once


// [계약서 / 결재]

// CPU [    ]		GPU [    ]
// 한국 [    ]		베트남 [    ]
// => 외주 보낼때 확실하게 서명을 해서 보내는 것

class RootSignature
{
public:
	void Init(ComPtr<ID3D12Device> device);

	ComPtr<ID3D12RootSignature> GetSignature() { return _signature; }

private:
	ComPtr<ID3D12RootSignature> _signature;

};

