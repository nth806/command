@ECHO OFF

REM Personal configuration
SET DOCS_DIR=%UserProfile%\Documents
SET COMMAND_DIR=%DOCS_DIR%\command

DOSKEY cd_c=cd /d %COMMAND_DIR%
DOSKEY cd_d=cd /d %UserProfile%\Downloads
DOSKEY cd_doc=cd /d %DOCS_DIR%
DOSKEY cd_u=cd /d %UserProfile%

:: Include common function
call %COMMAND_DIR%\.env.cmd

:: Include __.cmd aliases.cmd cd.cmd functions.cmd paths.cmd
FOR %%G IN (%COMMAND_DIR%\profile\bat\*.cmd) DO call %%G

:: Include common function
call %COMMAND_DIR%\profile\bat.cmd

SET PATH=%COMMAND_DIR%\cmd\bat;%COMMAND_DIR%\profile\bat;%UserProfile%\bat;%PATH%
