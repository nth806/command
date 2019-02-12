DOSKEY lsPort=netstat -ano $B FINDSTR ":$1 " $B FINDSTR /I LISTENING

DOSKEY cd_pj=cd /d %DOCS_DIR%\workspace\%PROJECT_DEFAULT%
SETLOCAL enabledelayedexpansion
SET /A i=0
FOR %%f IN (%PROJECT_LIST%) DO (
  SET /A i+=1
  DOSKEY cd_pj!i!=cd /d %DOCS_DIR%\workspace\%%f
)
ENDLOCAL
SET "i="
