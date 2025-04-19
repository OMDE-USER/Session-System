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

call "%Gecho%" Session System - Feito por "<B>OMDE_<DGN>EnGamer"
echo.
call "%Gecho%" "<y>=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-="
echo Esperando Elevacao de Administrador...
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
echo Fazendo a Verificação de Arquivos...
call "%Gecho%" "<y>=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-="

dir /s

if exist %PsExec% (
	echo PsExec.exe Existe.
) else (
	call "%Gecho%" "<Y>ALERTA": "<W>PsExec.exe Não existe. este arquivo é necessário para o funcionamento do SessionSystem."
	pause
	exit /b
)

if exist %PsExec64% (
	echo PsExec64.exe Existe.
) else (
	call "%Gecho%" "<Y>ALERTA": "<W>PsExec64.exe Não existe. este arquivo é necessário para o funcionamento do SessionSystem como 64 bits"
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
	echo =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
	echo Abrindo Prompt de Comando em winlogon.exe como System/Sistema...
	echo =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
	"%PsExec%" -d -s -i -x cmd.exe /k echo Info: O Seguinte Usuario no winlogon.exe é o System/Sistema.
	call :restoreCmdWindow
	echo =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
	echo A Operação foi feita com sucesso.
	echo =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
	powershell -Command "& {Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show('o Prompt de Comando é executado na Tela de Login. o CMD é Minimizado Por Padrão. Aperte Alt+Tab Para Desminimizar-lo.', 'Info', 'OK', [System.Windows.Forms.MessageBoxIcon]::Information);}"
	echo Concluido.
	echo Abrindo Sessão...
	nircmd lockws
	exit /b
)

if %use64bit% == 0 (
	echo =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
	echo Abrindo Prompt de Comando em winlogon.exe como System/Sistema...
	echo =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
	"%PsExec%" -d -s -i -x cmd.exe /k echo Info: O Seguinte Usuario no winlogon.exe é o System/Sistema. 
	call :restoreCmdWindow	
	echo =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
	echo A Operação foi feita com sucesso.
	echo =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
	powershell -Command "& {Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show('o Prompt de Comando é executado na Tela de Login. o CMD é Minimizado Por Padrão. Aperte Alt+Tab Para Desminimizar-lo.', 'Info', 'OK', [System.Windows.Forms.MessageBoxIcon]::Information);}"
	echo Concluido.
	echo Abrindo Sessão...
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






