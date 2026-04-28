@echo off
setlocal enabledelayedexpansion

set SCRIPT_DIR=%~dp0
set ROOT_DIR=%SCRIPT_DIR%..
set LOG_DIR=%ROOT_DIR%\logs
set GEN_DIR=%ROOT_DIR%\generated

if not exist "%LOG_DIR%" mkdir "%LOG_DIR%"

python "%ROOT_DIR%\scripts\generate_scenarios.py"
if errorlevel 1 (
  echo [ERROR] scenario generation failed.
  exit /b 1
)

REM TODO: Set SCONE_CMD to your actual SCONE executable path.
REM Example (to be verified):
REM set SCONE_CMD=C:\\Program Files\\SCONE\\bin\\sconecmd.exe
if "%SCONE_CMD%"=="" (
  echo [TODO] SCONE_CMD is not set.
  echo [TODO] set SCONE_CMD=^<path_to_scone_executable^>
  exit /b 1
)

for %%F in ("%GEN_DIR%\*.scone") do (
  set BASENAME=%%~nF
  echo [RUN] !BASENAME!
  "%SCONE_CMD%" "%%~fF" > "%LOG_DIR%\!BASENAME!.log" 2>&1
  if errorlevel 1 (
    echo [ERROR] !BASENAME! failed. Check log.
    exit /b 1
  )
  echo [DONE] !BASENAME! ^> "%LOG_DIR%\!BASENAME!.log"
)

endlocal
