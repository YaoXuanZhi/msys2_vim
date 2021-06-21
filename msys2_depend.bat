@echo off
rem --------------------------------------------
rem Please use of GBK encoding to edit this file
rem --------------------------------------------

cd /d "%~dp0"

title Msys2���߰�

mode con cols=60 lines=20&color 0a

rem --------------------------------------------------------------------------

set ROOT="%cd%"

call "%~dp0config.bat"
set command_args=%msys2_type% -where %ROOT%

:do

cls

cd /d %ROOT%

echo 0: ׷�ӹ��ھ���Դ

echo 1: ����msys2�ֿ�-Syu

echo 2: ����msys2�ֿ�-Sy

echo 3: ��װ����������

echo 4: ��װ����������

set /p o=

if %o%==0 goto pacman_append_mirror

if %o%==1 goto pacman_syu

if %o%==2 goto pacman_sy

if %o%==3 goto install_base_dev

if %o%==4 goto install_extra_dev

goto end

rem --------------------------------------------------------------------------

REM ��ӹ��ھ���Դ
:pacman_append_mirror

cls

call %msys2_shell_bat% %command_args% -c "bash ./append_extra_mirror_source.sh; ls /etc/pacman.d; %pause_cmd%"

goto do
rem --------------------------------------------------------------------------

REM ����msys2�ֿ�-Syu
:pacman_syu

cls

call %msys2_shell_bat% %command_args% -c "pacman -Syu; %pause_cmd%"

goto do
rem --------------------------------------------------------------------------

REM ����msys2�ֿ�-Sy
:pacman_sy

cls

call %msys2_shell_bat% %command_args% -c "pacman -Sy; %pause_cmd%"

goto do
rem --------------------------------------------------------------------------

REM ��װ����������
:install_base_dev

cls

call %msys2_shell_bat% %command_args% -c "pacman -S --needed base-devel mingw-w64-x86_64-toolchain; %pause_cmd%"

goto do
rem --------------------------------------------------------------------------

REM ��װ����������
:install_extra_dev

cls

call %msys2_shell_bat% %command_args% -c "pacman -S --needed mingw-w64-x86_64-dlfcn; %pause_cmd%"

goto do
rem --------------------------------------------------------------------------

:end

pause

GOTO :eof