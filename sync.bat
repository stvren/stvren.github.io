@echo off
chcp 65001 >nul
cd /d "%~dp0"
title App Sync Tool
echo === App Sync Tool ===
echo.
echo Scanning app folder...
echo.
powershell -ExecutionPolicy Bypass -NoProfile -File "sync.ps1"
echo.
if %errorlevel% equ 0 (
    echo Done! Refresh index.html to see changes.
) else (
    echo Sync failed.
)
echo.
pause
