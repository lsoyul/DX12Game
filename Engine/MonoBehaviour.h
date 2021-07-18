#pragma once
#include "Component.h"


class MonoBehaviour : public Component
{
public:
	MonoBehaviour();
	virtual ~MonoBehaviour();

public:
	virtual void FinalUpdate() sealed { }	// MonoBehaviour는 활용 금지(엔진에서만 쓰일 것) => sealed
};

