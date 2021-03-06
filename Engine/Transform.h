#pragma once
#include "Component.h"


class Transform : public Component
{
public:
	Transform();
	virtual ~Transform();

	virtual void FinalUpdate() override;
	void PushData();

public:
	// Parent 기준으로의 값
	const Vec3& GetLocalPosition() { return _localPosition; }
	const Vec3& GetLocalRotation() { return _localRotation; }
	const Vec3& GetLocalScale() { return _localScale; }

	// TEMP
	float GetBoundingSphereRadius() { return max(max(_localScale.x, _localScale.y), _localScale.z); }

	// 실제 World에서의 Matrix (parent->world)
	const Matrix& GetLocalToWorldMatrix() { return _matWorld; }
	Vec3 GetWorldPosition() { return _matWorld.Translation(); }

	// Right, Up, Look 은 World Space 기준!
	Vec3 GetRight() { return _matWorld.Right(); }
	Vec3 GetUp() { return _matWorld.Up(); }
	Vec3 GetLook() { return _matWorld.Backward(); }	// Library가 오른손 좌표계로 구현되어 있기 때문

	void SetLocalPosition(const Vec3& position) { _localPosition = position; }
	void SetLocalRotation(const Vec3& rotation) { _localRotation = rotation; }
	void SetLocalScale(const Vec3& scale) { _localScale = scale; }

public:
	void SetParent(shared_ptr<Transform> parent) { _parent = parent; }
	weak_ptr<Transform> GetParent() { return _parent; }

private:
	// Parent 기준 좌표
	Vec3 _localPosition = {};
	Vec3 _localRotation = {};
	Vec3 _localScale = {1.f, 1.f, 1.f};

	Matrix _matLocal = {};
	Matrix _matWorld = {};

	weak_ptr<Transform> _parent;

};

