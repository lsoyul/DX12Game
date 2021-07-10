#pragma once



// [��ȼ�]
// ���ָ� �ñ� �� �̷� ���� �������� ���� �Ѱ���� �ϴµ�,
// �ƹ� ���·� ��û�ϸ� �� �˾Ƶ�´�.
// - ���� ���ҽ��� � �뵵�� ����ϴ��� �԰ݿ� ���� �Ѱ��ִ� �뵵
// (DX11������ View ��� ���� ���Ǿ���)
class DescriptorHeap //(View)
{
public:
	void Init(ComPtr<ID3D12Device> device, shared_ptr<class SwapChain> swapChain);

	D3D12_CPU_DESCRIPTOR_HANDLE GetRTV(int32 idx) { return _rtvHandle[idx]; }

	D3D12_CPU_DESCRIPTOR_HANDLE GetBackBufferView();

private:
	ComPtr<ID3D12DescriptorHeap> _rtvHeap;
	uint32 _rtvHeapSize = 0;
	D3D12_CPU_DESCRIPTOR_HANDLE _rtvHandle[SWAP_CHAIN_BUFFER_COUNT];

	shared_ptr<class SwapChain> _swapChain;


};

