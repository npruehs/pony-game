#pragma once

#include "stdafx.h"
#include "PonyGameNative.h"

namespace PonyGame
{
	// Checks whether the specified button is pressed for the controller of the specified player.
	bool ButtonPressed(const int userIndex, WORD button);
}


extern "C"
{
	PONYGAMENATIVE_API bool DPadUpPressed(const int userIndex);
	PONYGAMENATIVE_API bool DPadDownPressed(const int userIndex);
	PONYGAMENATIVE_API bool DPadLeftPressed(const int userIndex);
	PONYGAMENATIVE_API bool DPadRightPressed(const int userIndex);
	PONYGAMENATIVE_API bool StartButtonPressed(const int userIndex);
	PONYGAMENATIVE_API bool BackButtonPressed(const int userIndex);
	PONYGAMENATIVE_API bool LeftThumbPressed(const int userIndex);
	PONYGAMENATIVE_API bool RightThumbPressed(const int userIndex);
	PONYGAMENATIVE_API bool LeftShoulderButtonPressed(const int userIndex);
	PONYGAMENATIVE_API bool RightShoulderButtonPressed(const int userIndex);
	PONYGAMENATIVE_API bool ButtonAPressed(const int userIndex);
	PONYGAMENATIVE_API bool ButtonBPressed(const int userIndex);
	PONYGAMENATIVE_API bool ButtonXPressed(const int userIndex);
	PONYGAMENATIVE_API bool ButtonYPressed(const int userIndex);
}