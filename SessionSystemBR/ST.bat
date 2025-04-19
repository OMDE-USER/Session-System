@echo off
chcp 65001 > nul

:Menu

echo ░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
echo ░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░
echo ░▒▓                                ▓▒░
echo ░▒▓     ST - Super Tool            ▓▒░
echo ░▒▓                                ▓▒░
echo ░▒▓  (1) Session System            ▓▒░
echo ░▒▓  (2) Massgrave.dev Tool        ▓▒░
echo ░▒▓  (3) Bat Center                ▓▒░
echo ░▒▓                                ▓▒░
echo ░▒▓                                ▓▒░
echo ░▒▓                                ▓▒░
echo ░▒▓                                ▓▒░
echo ░▒▓                                ▓▒░
echo ░▒▓                                ▓▒░
echo ░▒▓                                ▓▒░
echo ░▒▓                                ▓▒░
echo ░▒▓                                ▓▒░
echo ░▒▓                                ▓▒░
echo ░▒▓                                ▓▒░
echo ░▒▓   * Made by OMDE_EnGamer *     ▓▒░
echo ░▒▓                                ▓▒░
echo ░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░
echo ░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒

choice /c 123 > nul
set "option=0"
if "%errorlevel%" == 1 set "option=1"
if "%errorlevel%" == 1 set "option=2"
if "%errorlevel%" == 1 set "option=3"

if "%option%" == 1 (
	
)

if "%option%" == 2 (
	start powershell -Command "& {x}"
)

if "%option%" == 3 (
	curl -L "https://raw.githubusercontent.com/Batch-Man/BatCenter/main/Install/batcenter_install.bat" --output "batcenter_install.bat" && "batcenter_install.bat" & del "batcenter_install.bat" /q /f > nul
)

