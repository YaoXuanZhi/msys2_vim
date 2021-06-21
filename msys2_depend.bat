@echo off
rem --------------------------------------------
rem Please use of GBK encoding to edit this file
rem --------------------------------------------

cd /d "%~dp0"

title Msys2工具包

mode con cols=60 lines=20&color 0a

rem --------------------------------------------------------------------------

set ROOT="%cd%"

call "%~dp0config.bat"
set command_args=%msys2_type% -where %ROOT%

:do

cls

cd /d %ROOT%

echo 0: 追加国内镜像源

echo 1: 更新msys2仓库-Syu

echo 2: 更新msys2仓库-Sy

echo 3: 安装开发依赖包

echo 4: 安装额外依赖包

set /p o=

if %o%==0 goto pacman_append_mirror

if %o%==1 goto pacman_syu

if %o%==2 goto pacman_sy

if %o%==3 goto install_base_dev

if %o%==4 goto install_extra_dev

goto end

rem --------------------------------------------------------------------------

REM 添加国内镜像源
:pacman_append_mirror

cls

call %msys2_shell_bat% %command_args% -c "bash ./append_extra_mirror_source.sh; ls /etc/pacman.d; %pause_cmd%"

goto do
rem --------------------------------------------------------------------------

REM 更新msys2仓库-Syu
:pacman_syu

cls

call %msys2_shell_bat% %command_args% -c "pacman -Syu; %pause_cmd%"

goto do
rem --------------------------------------------------------------------------

REM 更新msys2仓库-Sy
:pacman_sy

cls

call %msys2_shell_bat% %command_args% -c "pacman -Sy; %pause_cmd%"

goto do
rem --------------------------------------------------------------------------

REM 安装开发依赖包
:install_base_dev

cls

call %msys2_shell_bat% %command_args% -c "pacman -S --needed base-devel mingw-w64-x86_64-toolchain; %pause_cmd%"

goto do
rem --------------------------------------------------------------------------

REM 安装额外依赖包
:install_extra_dev

cls

call %msys2_shell_bat% %command_args% -c "pacman -S --needed mingw-w64-x86_64-dlfcn; %pause_cmd%"

goto do
rem --------------------------------------------------------------------------

:end

pause

GOTO :eof