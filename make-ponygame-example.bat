@ECHO OFF

ECHO Compiling pony-game...
REM Link to Windows Kits and native libraries.
REM http://tutorial.ponylang.org/appendices/compiler-args.html
Bin\x64\ponyc -p "Bin\x64" -p "Source" -o Bin\PonyGameExample Source\PonyGameExample

ECHO Copying native libs...
COPY "Bin\x64\PonyGameNative.dll" "Bin\PonyGameExample"

ECHO Copying resources...
COPY "Source\PonyGame\*.ini" "Bin\PonyGameExample"
COPY "Source\PonyGameExample\*.png" "Bin\PonyGameExample"
COPY "Source\PonyGameExample\*.ini" "Bin\PonyGameExample"

PAUSE