@echo off
REM ����Ŀ¼����

echo ��msys2Ŀ¼ճ��������
set /p msys2_dir=

call :removequotes msys2_dir

set msys2_shell_ex_bat=%~dp0msys2_shell_ex.cmd
set dest_path="%msys2_dir%\msys2_shell_ex.cmd"

@REM �Զ�����config.bat
if not exist "%~dp0config.bat" (
    echo @echo off>> %~dp0config.bat
    echo set msys2_shell_bat="%msys2_dir%\msys2_shell_ex.cmd">> %~dp0config.bat
    echo set msys2_type=-mingw64>> %~dp0config.bat
    echo set pause_cmd=read -p 'Please press any key after'>> %~dp0config.bat
)

REM ����msys2_shell_ex.cmd�ļ�����
if not exist %dest_path% (mklink %dest_path% %msys2_shell_ex_bat%)

:removequotes
FOR /F "delims=" %%A IN ('echo %%%1%%') DO set %1=%%~A
GOTO :eof

GOTO :eof