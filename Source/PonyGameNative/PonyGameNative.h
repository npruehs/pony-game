// The following ifdef block is the standard way of creating macros which make exporting 
// from a DLL simpler. All files within this DLL are compiled with the PONYGAMENATIVE_EXPORTS
// symbol defined on the command line. This symbol should not be defined on any project
// that uses this DLL. This way any other project whose source files include this file see 
// PONYGAMENATIVE_API functions as being imported from a DLL, whereas this DLL sees symbols
// defined with this macro as being exported.
#ifdef PONYGAMENATIVE_EXPORTS
#define PONYGAMENATIVE_API __declspec(dllexport)
#else
#define PONYGAMENATIVE_API __declspec(dllimport)
#endif

// Windows Header Files:
#include <windows.h>

// C RunTime Header Files:
#include <stdlib.h>
#include <malloc.h>
#include <memory.h>
#include <wchar.h>
#include <math.h>

#include <d2d1.h>
#include <d2d1helper.h>
#include <dwrite.h>
#include <wincodec.h>


template<class Interface>
inline void SafeRelease(
	Interface **ppInterfaceToRelease
	)
{
	if (*ppInterfaceToRelease != NULL)
	{
		(*ppInterfaceToRelease)->Release();

		(*ppInterfaceToRelease) = NULL;
	}
}


#ifndef Assert
#if defined( DEBUG ) || defined( _DEBUG )
#define Assert(b) do {if (!(b)) {OutputDebugStringA("Assert: " #b "\n");}} while(0)
#else
#define Assert(b)
#endif //DEBUG || _DEBUG
#endif



#ifndef HINST_THISCOMPONENT
EXTERN_C IMAGE_DOS_HEADER __ImageBase;
#define HINST_THISCOMPONENT ((HINSTANCE)&__ImageBase)
#endif


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