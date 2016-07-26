#pragma once

#include "stdafx.h"
#include "PonyGameNative.h"

namespace PonyGame
{
	// Register the window class and call methods for instantiating drawing resources.
	HRESULT InitializeWindow(const char* gameName, const int width, const int height);

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

	// Handle window events.
	static LRESULT CALLBACK WndProc(
		HWND hWnd,
		UINT message,
		WPARAM wParam,
		LPARAM lParam
		);

	// Render target window.
	HWND hwnd;

	// Direct2D factory for creating render targets.
	ID2D1Factory* direct2dFactory;

	// Direct2D render target for rendering to the window.
	ID2D1HwndRenderTarget* renderTarget;

	// Render target clear color.
	D2D1::ColorF clearColor = D2D1::ColorF::Black;

	ID2D1SolidColorBrush* lightSlateGrayBrush;
	ID2D1SolidColorBrush* cornflowerBlueBrush;
}


extern "C"
{
	PONYGAMENATIVE_API bool Initialize(const char* gameName, const int width, const int height);
	PONYGAMENATIVE_API void SetClearColor(float red, float green, float blue, float alpha);
	PONYGAMENATIVE_API bool Render(void);
	PONYGAMENATIVE_API void Uninitialize(void);
}