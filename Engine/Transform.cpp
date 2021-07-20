#include "pch.h"
#include "Transform.h"
#include "Engine.h"
#include "Camera.h"

Transform::Transform() : Component(COMPONENT_TYPE::TRANSFORM)
{

}

Transform::~Transform()
{
}

void Transform::FinalUpdate()
{
	Matrix matScale = Matrix::CreateScale(_localScale);
	// TODO: ���ʹϾ� ������� �ٲ��ֱ�. (������)
	Matrix matRotation = Matrix::CreateRotationX(_localRotation.x);
	matRotation *= Matrix::CreateRotationY(_localRotation.y);
	matRotation *= Matrix::CreateRotationZ(_localRotation.z);

	Matrix matTranslation = Matrix::CreateTranslation(_localPosition);

	// S*R*T
	_matLocal = matScale * matRotation * matTranslation;	// parent������ localMatrix
	_matWorld = _matLocal;

	shared_ptr<Transform> parent = GetParent().lock();
	if (parent != nullptr)
	{
		// �ش� ��ü�� World Matrix�� ���Ϸ��� parent�� SRT�� ������� ��.
		_matWorld *= parent->GetLocalToWorldMatrix();
	}
}

void Transform::PushData()
{
	// [World]
	// View			: Camera
	// Projection	: Camera

	TransformParams transformParams = {};
	transformParams.matWorld = _matWorld;
	transformParams.matView = Camera::S_MatView;
	transformParams.matProjection = Camera::S_MatProjection;
	transformParams.matWV = _matWorld * Camera::S_MatView;
	transformParams.matWVP = _matWorld * Camera::S_MatView * Camera::S_MatProjection;

	CONST_BUFFER(CONSTANT_BUFFER_TYPE::TRANSFORM)->PushData(&transformParams, sizeof(transformParams));
}



