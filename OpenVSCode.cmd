@echo off
set "vscodePath=%LOCALAPPDATA%\Programs\Microsoft VS Code"
set "exe=%vscodePath%\Code.exe"
set "lib=%vscodePath%\resources\app\out\cli.js"

for %%a in ("%exe%" "%lib%") do (
    if not exist "%%a" (
        echo The file is not found: %%a
        pause
        exit /b 1
    )
)

setlocal
set VSCODE_DEV=
set ELECTRON_RUN_AS_NODE=1
start "" "%exe%" "%lib%" %~dp0
IF %ERRORLEVEL% NEQ 0 EXIT /b %ERRORLEVEL%
endlocal
