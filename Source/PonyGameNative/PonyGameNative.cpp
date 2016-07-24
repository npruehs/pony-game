// PonyGameNative.cpp : Defines the exported functions for the DLL application.
//

#include "stdafx.h"
#include "PonyGameNative.h"


// This is an example of an exported variable
PONYGAMENATIVE_API int nPonyGameNative=0;

// This is an example of an exported function.
PONYGAMENATIVE_API int fnPonyGameNative(void)
{
    return 42;
}

// This is the constructor of a class that has been exported.
// see PonyGameNative.h for the class definition
CPonyGameNative::CPonyGameNative()
{
    return;
}
