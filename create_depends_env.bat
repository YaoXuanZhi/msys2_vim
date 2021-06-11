@echo off
REM 创建目录关联

echo 将msys2目录粘贴到这里
set /p msys2_dir=

call :removequotes msys2_dir

set msys2_shell_ex_bat=%~dp0msys2_shell_ex.cmd
set dest_path="%msys2_dir%\msys2_shell_ex.cmd"

@REM 自动生成config.bat
if not exist "%~dp0config.bat" (
    echo @echo off>> %~dp0config.bat
    echo set msys2_shell_bat="%msys2_dir%\msys2_shell_ex.cmd">> %~dp0config.bat
    echo set msys2_type=-mingw64>> %~dp0config.bat
    echo set pause_cmd=read -p 'Please press any key after'>> %~dp0config.bat
)

REM 创建msys2_shell_ex.cmd文件链接
if not exist %dest_path% (mklink %dest_path% %msys2_shell_ex_bat%)

:removequotes
FOR /F "delims=" %%A IN ('echo %%%1%%') DO set %1=%%~A
GOTO :eof

GOTO :eof