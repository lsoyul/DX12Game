#include "pch.h"
#include "Component.h"

#include "GameObject.h"

Component::Component(COMPONENT_TYPE type) : _type(type)
{
}

Component::~Component()
{
}

shared_ptr<GameObject> Component::GetGameObject()
{
	return _gameObject.lock();
}

shared_ptr<Transform> Component::GetTransfrom()
{
	return _gameObject.lock()->GetTransform();
}
