@echo off

call "%~dp0config.bat"

cd /d %msys2_install_dir%

set ROOT=%1
call :removequotes ROOT

pushd "%ROOT%" 2>nul && (call :folder "%ROOT%" & popd) || call :file "%ROOT%"
GOTO :eof

:file
call :filename ROOT file_name
call :dirname ROOT dir_name

set command_args=%msys2_type% -where "%dir_name%"
call %msys2_shell_bat% %command_args% -c "vim '%file_name%'"
GOTO :eof

:folder
set command_args=%msys2_type% -where "%ROOT%"
call %msys2_shell_bat% %command_args%
GOTO :eof

:removequotes
FOR /F "delims=" %%A IN ('echo %%%1%%') DO set %1=%%~A
GOTO :eof

:dirname
FOR /F "delims=" %%A IN ('echo %%%1%%') DO set %2=%%~dpA
GOTO :eof

:filename
FOR /F "delims=" %%A IN ('echo %%%1%%') DO set %2=%%~nxA
GOTO :eof