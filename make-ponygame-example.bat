@ECHO OFF

ECHO Compiling pony-game...
REM Link to Windows Kits and native libraries.
REM http://tutorial.ponylang.org/appendices/compiler-args.html
ponyc -p "C:\Program Files (x86)\Windows Kits\10\Lib\10.0.10240.0\ucrt\x64" -p "Bin\PonyGameNative\x64\Debug" -p "Source" -o Bin\PonyGameExample Source\PonyGameExample

ECHO Copying native libs...
COPY "Bin\PonyGameNative\x64\Debug\PonyGameNative.dll" "Bin\PonyGameExample"

ECHO Copying resources...
COPY "Source\PonyGameExample\*.png" "Bin\PonyGameExample"

PAUSE