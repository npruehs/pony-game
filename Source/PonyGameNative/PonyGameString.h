#pragma once

#include <string>

namespace PonyGame
{
	inline std::wstring StringToWString(std::string s)
	{
		std::wstring ws;
		ws.assign(s.begin(), s.end());
		return ws;
	}

	inline std::string WStringToString(std::wstring ws)
	{
		std::string s;
		s.assign(ws.begin(), ws.end());
		return s;
	}
}