// Include file for standard system include files,
// or project specific include files that are used frequently, but
// are changed infrequently.

#pragma once

#include "targetver.h"

// Exclude rarely-used stuff from Windows headers.
#define WIN32_LEAN_AND_MEAN

// Windows Header Files
#include <windows.h>

// C RunTime Header Files
#include <stdlib.h>
#include <malloc.h>
#include <memory.h>
#include <tchar.h>
#include <wchar.h>
#include <math.h>

// DirectX Header Files
#include <d2d1.h>
#include <d2d1helper.h>
#include <dwrite.h>
#include <wincodec.h>