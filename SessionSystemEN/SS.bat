@ECHO OFF
REM BFCPEOPTIONSTART
REM Advanced BAT to EXE Converter www.BatToExeConverter.com
REM BFCPEEXE=
REM BFCPEICON=
REM BFCPEICONINDEX=0
REM BFCPEEMBEDDISPLAY=0
REM BFCPEEMBEDDELETE=1
REM BFCPEADMINEXE=0
REM BFCPEINVISEXE=0
REM BFCPEVERINCLUDE=0
REM BFCPEVERVERSION=1.0.0.0
REM BFCPEVERPRODUCT=Product Name
REM BFCPEVERDESC=Product Description
REM BFCPEVERCOMPANY=Your Company
REM BFCPEVERCOPYRIGHT=Copyright Info
REM BFCPEOPTIONEND
@ECHO ON
@echo off
title Session System - OMDE_EnGamer
chcp 65001 > nul

set "PsExec=PsExec.exe"
set "PsExec64=PsExec64.exe"
set "Gecho=GechoFolder\Gecho.exe"

call "%Gecho%" Session System - Made By "<B>OMDE_<DGN>EnGamer"
echo.
call "%Gecho%" "<y>=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-="
echo Waiting for Administrator Elevate...
call "%Gecho%" "<y>=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-="
timeout 1 > nul

:init
setlocal DisableDelayedExpansion
set "batchPath=%~0"
for %%k in (%0) do set batchName=%%~nk
set "vbsGetPrivileges=%temp%\OEgetPriv_%batchName%.vbs"
setlocal EnableDelayedExpansion

:checkPrivileges
NET FILE 1>NUL 2>NUL
if '%errorlevel%' == '0' ( goto gotPrivileges ) else ( goto getPrivileges )

:getPrivileges
if '%1'=='ELEV' (echo ELEV & shift /1 & goto gotPrivileges)
echo Set UAC = CreateObject^("Shell.Application"^) > "%vbsGetPrivileges%"
echo args = "ELEV " >> "%vbsGetPrivileges%"
echo For Each strArg in WScript.Arguments >> "%vbsGetPrivileges%"
echo args = args ^& strArg ^& " "  >> "%vbsGetPrivileges%"
echo Next >> "%vbsGetPrivileges%"
echo UAC.ShellExecute "!batchPath!", args, "", "runas", 1 >> "%vbsGetPrivileges%"
"%SystemRoot%\System32\WScript.exe" "%vbsGetPrivileges%" %*
exit /B

:gotPrivileges
setlocal & pushd .
cd /d %~dp0
if '%1'=='ELEV' (del "%vbsGetPrivileges%" 1>nul 2>nul  &  shift /1)

echo.
call "%Gecho%" "<y>=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-="
echo Making Files Verification...
call "%Gecho%" "<y>=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-="

dir /s

if exist %PsExec% (
	echo PsExec.exe Exist.
) else (
	call "%Gecho%" "<Y>ALERT": "<B>PsExec".exe don't exist. This file is necessary for SessionSystem Works.
	pause
	exit /b
)

if exist %PsExec64% (
	echo PsExec64.exe Exist.
) else (
	call "%Gecho%" "<Y>ALERT": "<B>PsExec64".exe don't exist. This file is necessary for SessionSystem Works in 64 bits version
	pause
	exit /b
)


if %PROCESSOR_ARCHITECTURE%==AMD64 (
set "use64bit=0"
	call "%Gecho%" "<Y>x64" "<w>Processor Architecture Detected. Do you want to Execute SessionSystem as 64 Bits version?" (Y/N)
	call "%Gecho%" "<B>Info:" "<Y>x64" "<W> Don't need to Execute 64 Bits version Always" 
	set /p input=
	if /i "%input%" == "Y" set "use64bit=1"
	if /i "%input%" == "N" set "use64bit=0"
)

if %use64bit% == 1 (
	call "%Gecho%" "<y>=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-="
	echo Opening Command Prompt in winlogon.exe as System..
	call "%Gecho%" "<y>=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-="
	"%PsExec64%" -d -s -i -x cmd.exe /k echo Info: The System runs on System Account in winlogon.exe
	call :restoreCmdWindow
	echo =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
	echo Operation Done
	echo =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
	powershell -Command "& {Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show('Command Prompt is Open on Login By Default. to Open it, Press Alt+tab and Find Command Prompt.', 'Info', 'OK', [System.Windows.Forms.MessageBoxIcon]::Information);}"
	echo Done.
	echo Opening Session...
	nircmd lockws
	exit /b
)

if %use64bit% == 0 (
	call "%Gecho%" "<y>=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-="
	echo Opening Command Prompt in winlogon.exe as System..
	call "%Gecho%" "<y>=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-="
	"%PsExec%" -d -s -i -x cmd.exe /k echo Info: The System runs on System Account in winlogon.exe
	call :restoreCmdWindow
	echo =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
	echo Operation Done
	echo =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
	powershell -Command "& {Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show('Command Prompt is Open on Login By Default. to Open it, Press Alt+tab and Find Command Prompt.', 'Info', 'OK', [System.Windows.Forms.MessageBoxIcon]::Information);}"
	echo Done.
	echo Opening Session...
	nircmd lockws
	exit /b
)

:restoreCmdWindow
REM Aguarda alguns segundos até a janela ser criada
timeout /t 2 > nul

REM Tenta ativar e restaurar a janela do CMD usando NirCmd
nircmd win activate process "cmd.exe"
nircmd win show process "cmd.exe"
nircmd win settopmost process "cmd.exe" 1
goto :eof






