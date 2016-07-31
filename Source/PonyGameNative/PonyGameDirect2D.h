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

	// DirectWrite factory for creating text formats.
	IDWriteFactory* directWriteFactory;

	// Available text formats for rendering text.
	std::vector<IDWriteTextFormat*> textFormats;

	// WIC Imaging factory for creating image decoders.
	IWICImagingFactory *imagingFactory;

	// Loaded image resources.
	std::vector<ID2D1Bitmap*> images;
}


extern "C"
{
	PONYGAMENATIVE_API bool Initialize(const char* gameName, const int width, const int height);
	PONYGAMENATIVE_API void SetClearColor(const float red, const float green, const float blue, const float alpha);
	PONYGAMENATIVE_API int CreateTextFormat(const char* fontName, const float fontSize, const int textAlignment, const int paragraphAlignment);
	PONYGAMENATIVE_API int LoadImageResource(const char* fileName);
	PONYGAMENATIVE_API bool BeginDraw(void);
	PONYGAMENATIVE_API bool EndDraw(void);
	PONYGAMENATIVE_API void RenderText(const char* text, const float x, const float y, const int textFormatId, const float red, const float green, const float blue, const float alpha);
	PONYGAMENATIVE_API void RenderImage(const int imageId, const float x, const float y);
	PONYGAMENATIVE_API void Uninitialize(void);
}