@echo off
REM 创建目录关联
set config_path="%~dp0config.bat"

if exist "%~dp0config.bat" (
    GOTO :eof
)

echo 将msys2目录粘贴到这里
set /p msys2_dir=

call :removequotes msys2_dir

@REM 自动生成config.bat
if not exist "%~dp0config.bat" (
    echo @echo off>> %config_path%
    echo set msys2_shell_dir="%msys2_dir%">> %config_path%
    echo set msys2_shell_bat="%msys2_dir%\msys2_shell.cmd">> %config_path%
    echo set msys2_type=-mingw64>> %config_path%
    echo set pause_cmd=read -p 'Please press any key after'>> %config_path%
)

GOTO :eof

:removequotes
FOR /F "delims=" %%A IN ('echo %%%1%%') DO set %1=%%~A
GOTO :eof

GOTO :eof