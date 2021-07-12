#pragma once


// [��༭ / ����]

// CPU [    ]		GPU [    ]
// �ѱ� [    ]		��Ʈ�� [    ]
// => ���� ������ Ȯ���ϰ� ������ �ؼ� ������ ��

class RootSignature
{
public:
	void Init(ComPtr<ID3D12Device> device);

	ComPtr<ID3D12RootSignature> GetSignature() { return _signature; }

private:
	ComPtr<ID3D12RootSignature> _signature;

};
