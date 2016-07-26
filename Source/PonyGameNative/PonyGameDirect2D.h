#pragma once

#include "stdafx.h"
#include "PonyGameNative.h"


// Register the window class and call methods for instantiating drawing resources
HRESULT InitializeWindow();

// Initialize device-independent resources.
HRESULT CreateDeviceIndependentResources();

// Initialize device-dependent resources.
HRESULT CreateDeviceResources();

// Release device-dependent resource.
void DiscardDeviceResources();

// Draw content.
HRESULT OnRender();

// Resize the render target.
void OnResize(
	UINT width,
	UINT height
	);

// The windows procedure.
static LRESULT CALLBACK WndProc(
	HWND hWnd,
	UINT message,
	WPARAM wParam,
	LPARAM lParam
	);

HWND m_hwnd;
ID2D1Factory* m_pDirect2dFactory;
ID2D1HwndRenderTarget* m_pRenderTarget;
ID2D1SolidColorBrush* m_pLightSlateGrayBrush;
ID2D1SolidColorBrush* m_pCornflowerBlueBrush;


class Test {};

Test* test;


extern "C"
{
	PONYGAMENATIVE_API bool Initialize(void);
	PONYGAMENATIVE_API bool Render(void);
	PONYGAMENATIVE_API void Uninitialize(void);
}