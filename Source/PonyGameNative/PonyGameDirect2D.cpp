#include "stdafx.h"
#include "PonyGameDirect2D.h"

#include "PonyGameString.h"

HRESULT PonyGame::InitializeWindow(const char* gameName, const int width, const int height)
{
	HRESULT hr;

	// Initialize device-independent resources, such as the Direct2D factory.
	hr = CreateDeviceIndependentResources();

	if (!SUCCEEDED(hr))
	{
		return hr;
	}

	// Register the window class.
	WNDCLASSEX wcex = { sizeof(WNDCLASSEX) };
	wcex.style = CS_HREDRAW | CS_VREDRAW;
	wcex.lpfnWndProc = WndProc;
	wcex.cbClsExtra = 0;
	wcex.cbWndExtra = sizeof(LONG_PTR);
	wcex.hInstance = HINST_THISCOMPONENT;
	wcex.hbrBackground = NULL;
	wcex.lpszMenuName = NULL;
	wcex.hCursor = LoadCursor(NULL, IDI_APPLICATION);
	wcex.lpszClassName = L"PonyGame";

	RegisterClassEx(&wcex);

	// Because the CreateWindow function takes its size in pixels,
	// obtain the system DPI and use it to scale the window size.
	FLOAT dpiX, dpiY;

	// The factory returns the current system DPI.
	// This is also the value it will use to create its own windows.
	direct2dFactory->GetDesktopDpi(&dpiX, &dpiY);

	// Create the window.
	hwnd = CreateWindow(
		L"PonyGame",
		StringToWString(std::string(gameName)).c_str(),
		WS_OVERLAPPEDWINDOW,
		CW_USEDEFAULT,
		CW_USEDEFAULT,
		static_cast<UINT>(ceil(width * dpiX / 96.f)),
		static_cast<UINT>(ceil(height * dpiY / 96.f)),
		NULL,
		NULL,
		HINST_THISCOMPONENT,
		(LPVOID)1
		);

	hr = hwnd ? S_OK : E_FAIL;

	if (!SUCCEEDED(hr))
	{
		return hr;
	}

	ShowWindow(hwnd, SW_SHOWNORMAL);
	UpdateWindow(hwnd);

	// Create window render target.
	CreateDeviceResources();

	return hr;
}

HRESULT PonyGame::CreateDeviceIndependentResources()
{
	HRESULT hr = S_OK;

	// Create a Direct2D factory for creating render targets.
	hr = D2D1CreateFactory(D2D1_FACTORY_TYPE_SINGLE_THREADED, &direct2dFactory);

	if (!SUCCEEDED(hr))
	{
		return hr;
	}

	// Create a DirectWrite factory for creating text formats.
	hr = DWriteCreateFactory(
		DWRITE_FACTORY_TYPE_SHARED,
		__uuidof(directWriteFactory),
		reinterpret_cast<IUnknown **>(&directWriteFactory)
		);

	if (!SUCCEEDED(hr))
	{
		return hr;
	}

	// Create WIC Imaging factory for creating image decoders.
	hr = CoCreateInstance(
		CLSID_WICImagingFactory,
		NULL,
		CLSCTX_INPROC_SERVER,
		IID_IWICImagingFactory,
		(LPVOID*)&imagingFactory
		);

	return hr;
}

HRESULT PonyGame::CreateDeviceResources()
{
	HRESULT hr = S_OK;

	if (renderTarget)
	{
		// Nothing to do.
		return hr;
	}

	RECT rc;
	GetClientRect(hwnd, &rc);

	D2D1_SIZE_U size = D2D1::SizeU(
		rc.right - rc.left,
		rc.bottom - rc.top
		);

	// Create a Direct2D render target for rendering to the window.
	hr = direct2dFactory->CreateHwndRenderTarget(
		D2D1::RenderTargetProperties(),
		D2D1::HwndRenderTargetProperties(hwnd, size),
		&renderTarget
		);

	return hr;
}

void PonyGame::DiscardDeviceResources()
{
	SafeRelease(&renderTarget);
}

LRESULT CALLBACK PonyGame::WndProc(HWND hwnd, UINT message, WPARAM wParam, LPARAM lParam)
{
	LRESULT result = 0;

	if (message == WM_CREATE)
	{
		LPCREATESTRUCT pcs = (LPCREATESTRUCT)lParam;

		::SetWindowLongPtrW(
			hwnd,
			GWLP_USERDATA,
			PtrToUlong(pcs->lpCreateParams)
			);

		result = 1;
	}
	else
	{
		LONG_PTR window = static_cast<LONG_PTR>(
			::GetWindowLongPtrW(
				hwnd,
				GWLP_USERDATA
				));

		bool wasHandled = false;

		if (window)
		{
			switch (message)
			{
			case WM_SIZE:
			{
				UINT width = LOWORD(lParam);
				UINT height = HIWORD(lParam);
				OnResize(width, height);
			}
			result = 0;
			wasHandled = true;
			break;

			case WM_DISPLAYCHANGE:
			{
				InvalidateRect(hwnd, NULL, FALSE);
			}
			result = 0;
			wasHandled = true;
			break;

			case WM_PAINT:
			{
				ValidateRect(hwnd, NULL);
			}
			result = 0;
			wasHandled = true;
			break;

			case WM_DESTROY:
			{
				PostQuitMessage(0);
			}
			result = 1;
			wasHandled = true;
			break;
			}
		}

		if (!wasHandled)
		{
			result = DefWindowProc(hwnd, message, wParam, lParam);
		}
	}

	return result;
}

void PonyGame::OnResize(UINT width, UINT height)
{
	if (!renderTarget)
	{
		return;
	}

	// Note: This method can fail, but it's okay to ignore the
	// error here, because the error will be returned again
	// the next time EndDraw is called.
	renderTarget->Resize(D2D1::SizeU(width, height));
}


PONYGAMENATIVE_API bool Initialize(const char* gameName, const int width, const int height)
{
	using namespace PonyGame;

	if (!SUCCEEDED(CoInitialize(NULL)))
	{
		return false;
	}

	hwnd = NULL;
	direct2dFactory = NULL;
	renderTarget = NULL;
	clearColor = D2D1::ColorF::CornflowerBlue;

	return SUCCEEDED(InitializeWindow(gameName, width, height));
}

PONYGAMENATIVE_API void SetClearColor(const float red, const float green, const float blue, const float alpha)
{
	using namespace PonyGame;

	clearColor = D2D1::ColorF(red, green, blue, alpha);
}

PONYGAMENATIVE_API int CreateTextFormat(const char* fontName, const float fontSize, const int textAlignment, const int paragraphAlignment)
{
	using namespace PonyGame;

	HRESULT hr = S_OK;

	// Create a DirectWrite text format object.
	IDWriteTextFormat* textFormat;

	hr = directWriteFactory->CreateTextFormat(
		StringToWString(std::string(fontName)).c_str(),
		NULL,
		DWRITE_FONT_WEIGHT_NORMAL,
		DWRITE_FONT_STYLE_NORMAL,
		DWRITE_FONT_STRETCH_NORMAL,
		fontSize,
		L"",
		&textFormat
		);

	if (!SUCCEEDED(hr))
	{
		return -1;
	}

	// Set horizontal and vertical text alignment.
	textFormat->SetTextAlignment((DWRITE_TEXT_ALIGNMENT)textAlignment);
	textFormat->SetParagraphAlignment((DWRITE_PARAGRAPH_ALIGNMENT)paragraphAlignment);

	// Cache text format.
	textFormats.push_back(textFormat);
	return (int)textFormats.size() - 1;
}

PONYGAMENATIVE_API int LoadImageResource(const char* fileName)
{
	using namespace PonyGame;

	IWICBitmapDecoder *decoder = NULL;
	IWICBitmapFrameDecode *source = NULL;
	IWICFormatConverter *converter = NULL;
	ID2D1Bitmap *bitmap = NULL;

	// Create decoder.
	HRESULT hr = imagingFactory->CreateDecoderFromFilename(
		StringToWString(std::string(fileName)).c_str(),
		NULL,
		GENERIC_READ,
		WICDecodeMetadataCacheOnLoad,
		&decoder
		);

	if (!SUCCEEDED(hr))
	{
		printf("Failed to load image: %s", fileName);
		return -1;
	}

	// Create the initial frame.
	hr = decoder->GetFrame(0, &source);

	if (!SUCCEEDED(hr))
	{
		return -1;
	}

	// Convert the image format to 32bppPBGRA
	// (DXGI_FORMAT_B8G8R8A8_UNORM + D2D1_ALPHA_MODE_PREMULTIPLIED).
	hr = imagingFactory->CreateFormatConverter(&converter);

	if (!SUCCEEDED(hr))
	{
		printf("Invalid image format: %s", fileName);
		return -1;
	}

	hr = converter->Initialize(
		source,
		GUID_WICPixelFormat32bppPBGRA,
		WICBitmapDitherTypeNone,
		NULL,
		0.0f,
		WICBitmapPaletteTypeMedianCut
		);

	if (!SUCCEEDED(hr))
	{
		return -1;
	}

	// Create a Direct2D bitmap from the WIC bitmap.
	hr = renderTarget->CreateBitmapFromWicBitmap(
		converter,
		NULL,
		&bitmap
		);

	SafeRelease(&decoder);
	SafeRelease(&source);
	SafeRelease(&converter);

	// Cache image.
	images.push_back(bitmap);
	return (int)images.size() - 1;
}

PONYGAMENATIVE_API bool BeginDraw(void)
{
	using namespace PonyGame;

	// Force window update.
	InvalidateRect(hwnd, NULL, FALSE);

	MSG msg;

	if (!GetMessage(&msg, NULL, 0, 0))
	{
		return false;
	}

	TranslateMessage(&msg);
	DispatchMessage(&msg);

	HRESULT hr = CreateDeviceResources();

	if (!SUCCEEDED(hr))
	{
		return false;
	}

	renderTarget->BeginDraw();
	renderTarget->Clear(clearColor);
	renderTarget->SetTransform(D2D1::Matrix3x2F::Identity());

	return true;
}

PONYGAMENATIVE_API bool EndDraw()
{
	using namespace PonyGame;

	HRESULT hr = renderTarget->EndDraw();

	if (hr == D2DERR_RECREATE_TARGET)
	{
		hr = S_OK;
		DiscardDeviceResources();
	}

	return SUCCEEDED(hr);
}

PONYGAMENATIVE_API void RenderText(const char* text, const float x, const float y, const int textFormatId, const float red, const float green, const float blue, const float alpha)
{
	using namespace PonyGame;

	// Create text brush.
	ID2D1SolidColorBrush* brush;
	HRESULT hr = renderTarget->CreateSolidColorBrush(
		D2D1::ColorF(red, green, blue, alpha),
		&brush
		);

	if (!SUCCEEDED(hr))
	{
		return;
	}

	D2D1_SIZE_F renderTargetSize = renderTarget->GetSize();
	std::wstring textString = StringToWString(std::string(text));

	// Draw text.
	renderTarget->SetTransform(D2D1::Matrix3x2F::Translation(x, y));

	renderTarget->DrawText(
		textString.c_str(),
		(int)textString.length(),
		textFormats[textFormatId],
		D2D1::RectF(0, 0, renderTargetSize.width, renderTargetSize.height),
		brush
		);

	SafeRelease(&brush);
}

PONYGAMENATIVE_API void RenderImage(const int imageId, const float x, const float y)
{
	using namespace PonyGame;

	// Get image to draw.
	ID2D1Bitmap* bitmap = images[imageId];

	// Retrieve the size of the image.
	D2D1_SIZE_F size = bitmap->GetSize();

	// Draw image.
	renderTarget->SetTransform(D2D1::Matrix3x2F::Translation(x, y));

	renderTarget->DrawBitmap(
		bitmap,
		D2D1::RectF(
			0,
			0,
			size.width,
			size.height)
		);
}

PONYGAMENATIVE_API void Uninitialize(void)
{
	using namespace PonyGame;

	SafeRelease(&direct2dFactory);
	SafeRelease(&renderTarget);

	CoUninitialize();
}