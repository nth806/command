@echo off

IF "x%1%" == "x" (
  ECHO Please input port number!
  GOTO :EOF
)

SETLOCAL

FOR /F "tokens=*" %%I IN ('netstat -ano ^| FINDSTR ":%1% " ^| FINDSTR /I LISTENING') DO (
  SET "TERM_OUT=%%I"
  GOTO BREAK
)
:BREAK

IF "x%TERM_OUT%" == "x" (
  ECHO "Port %1% is not listened"
  GOTO :EOF
)

FOR /F "tokens=5*" %%a IN ("%TERM_OUT%") DO ECHO %%a

ENDLOCAL
