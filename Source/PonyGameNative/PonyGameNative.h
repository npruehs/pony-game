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

// This class is exported from the PonyGameNative.dll
class PONYGAMENATIVE_API CPonyGameNative {
public:
	CPonyGameNative(void);
	// TODO: add your methods here.
};

extern PONYGAMENATIVE_API int nPonyGameNative;

PONYGAMENATIVE_API int fnPonyGameNative(void);
