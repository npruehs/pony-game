#include "stdafx.h"
#include "PonyGameXInput.h"


bool PonyGame::ButtonPressed(const int userIndex, WORD button)
{
	XINPUT_STATE state;
	ZeroMemory(&state, sizeof(XINPUT_STATE));
	DWORD dwResult = XInputGetState(userIndex, &state);
	return dwResult == ERROR_SUCCESS && state.Gamepad.wButtons & button;
}


PONYGAMENATIVE_API bool DPadUpPressed(const int userIndex)
{
	return PonyGame::ButtonPressed(userIndex, XINPUT_GAMEPAD_DPAD_UP);
}

PONYGAMENATIVE_API bool DPadDownPressed(const int userIndex)
{
	return PonyGame::ButtonPressed(userIndex, XINPUT_GAMEPAD_DPAD_DOWN);
}

PONYGAMENATIVE_API bool DPadLeftPressed(const int userIndex)
{
	return PonyGame::ButtonPressed(userIndex, XINPUT_GAMEPAD_DPAD_LEFT);
}

PONYGAMENATIVE_API bool DPadRightPressed(const int userIndex)
{
	return PonyGame::ButtonPressed(userIndex, XINPUT_GAMEPAD_DPAD_RIGHT);
}

PONYGAMENATIVE_API bool StartButtonPressed(const int userIndex)
{
	return PonyGame::ButtonPressed(userIndex, XINPUT_GAMEPAD_START);
}

PONYGAMENATIVE_API bool BackButtonPressed(const int userIndex)
{
	return PonyGame::ButtonPressed(userIndex, XINPUT_GAMEPAD_BACK);
}

PONYGAMENATIVE_API bool LeftThumbPressed(const int userIndex)
{
	return PonyGame::ButtonPressed(userIndex, XINPUT_GAMEPAD_LEFT_THUMB);
}

PONYGAMENATIVE_API bool RightThumbPressed(const int userIndex)
{
	return PonyGame::ButtonPressed(userIndex, XINPUT_GAMEPAD_RIGHT_THUMB);
}

PONYGAMENATIVE_API bool LeftShoulderButtonPressed(const int userIndex)
{
	return PonyGame::ButtonPressed(userIndex, XINPUT_GAMEPAD_LEFT_SHOULDER);
}

PONYGAMENATIVE_API bool RightShoulderButtonPressed(const int userIndex)
{
	return PonyGame::ButtonPressed(userIndex, XINPUT_GAMEPAD_RIGHT_SHOULDER);
}

PONYGAMENATIVE_API bool ButtonAPressed(const int userIndex)
{
	return PonyGame::ButtonPressed(userIndex, XINPUT_GAMEPAD_A);
}

PONYGAMENATIVE_API bool ButtonBPressed(const int userIndex)
{
	return PonyGame::ButtonPressed(userIndex, XINPUT_GAMEPAD_B);
}

PONYGAMENATIVE_API bool ButtonXPressed(const int userIndex)
{
	return PonyGame::ButtonPressed(userIndex, XINPUT_GAMEPAD_X);
}

PONYGAMENATIVE_API bool ButtonYPressed(const int userIndex)
{
	return PonyGame::ButtonPressed(userIndex, XINPUT_GAMEPAD_Y);
}

PONYGAMENATIVE_API float GetLeftTrigger(const int userIndex)
{
	XINPUT_STATE state;
	ZeroMemory(&state, sizeof(XINPUT_STATE));
	DWORD dwResult = XInputGetState(userIndex, &state);
	return dwResult == ERROR_SUCCESS && state.Gamepad.bLeftTrigger > XINPUT_GAMEPAD_TRIGGER_THRESHOLD
		? state.Gamepad.bLeftTrigger / 256.0f
		: 0.0f;
}

PONYGAMENATIVE_API float GetRightTrigger(const int userIndex)
{
	XINPUT_STATE state;
	ZeroMemory(&state, sizeof(XINPUT_STATE));
	DWORD dwResult = XInputGetState(userIndex, &state);
	return dwResult == ERROR_SUCCESS && state.Gamepad.bRightTrigger > XINPUT_GAMEPAD_TRIGGER_THRESHOLD
		? state.Gamepad.bRightTrigger / 256.0f
		: 0.0f;
}

PONYGAMENATIVE_API float GetLeftThumbX(const int userIndex)
{
	XINPUT_STATE state;
	ZeroMemory(&state, sizeof(XINPUT_STATE));
	DWORD dwResult = XInputGetState(userIndex, &state);
	return dwResult == ERROR_SUCCESS && abs(state.Gamepad.sThumbLX) > XINPUT_GAMEPAD_LEFT_THUMB_DEADZONE
		? state.Gamepad.sThumbLX / 32767.0f
		: 0.0f;
}

PONYGAMENATIVE_API float GetLeftThumbY(const int userIndex)
{
	XINPUT_STATE state;
	ZeroMemory(&state, sizeof(XINPUT_STATE));
	DWORD dwResult = XInputGetState(userIndex, &state);
	return dwResult == ERROR_SUCCESS && abs(state.Gamepad.sThumbLY) > XINPUT_GAMEPAD_LEFT_THUMB_DEADZONE
		? state.Gamepad.sThumbLY / 32767.0f
		: 0.0f;
}

PONYGAMENATIVE_API float GetRightThumbX(const int userIndex)
{
	XINPUT_STATE state;
	ZeroMemory(&state, sizeof(XINPUT_STATE));
	DWORD dwResult = XInputGetState(userIndex, &state);
	return dwResult == ERROR_SUCCESS && abs(state.Gamepad.sThumbRX) > XINPUT_GAMEPAD_RIGHT_THUMB_DEADZONE
		? state.Gamepad.sThumbRX / 32767.0f
		: 0.0f;
}

PONYGAMENATIVE_API float GetRightThumbY(const int userIndex)
{
	XINPUT_STATE state;
	ZeroMemory(&state, sizeof(XINPUT_STATE));
	DWORD dwResult = XInputGetState(userIndex, &state);
	return dwResult == ERROR_SUCCESS && abs(state.Gamepad.sThumbRY) > XINPUT_GAMEPAD_RIGHT_THUMB_DEADZONE
		? state.Gamepad.sThumbRY / 32767.0f
		: 0.0f;
}