@echo off
setlocal enabledelayedexpansion
rem ----------------------
rem 注意使用GBK编码编辑此文件
rem ----------------------
cd /d %~dp0..

title Msys2工具包

mode con cols=60 lines=20&color 0a

rem --------------------------------------------------------------------------

cd /d %msys2_install_dir%

set ROOT=%cd%

call "%~dp0config.bat"
set command_args=%msys2_type% -where %ROOT%

:do

cls

cd /d %ROOT%

echo 0: 更新msys2仓库

echo 1: 安装开发依赖包

echo 2: 安装额外依赖包

echo 3: 查看已安装包

echo 4: 查看包信息

echo 5: 追加国内镜像源

set /p o=

if %o%==0 goto pacman_syu

if %o%==1 goto install_base_dev

if %o%==2 goto install_extra_dev

if %o%==3 goto show_install_list

if %o%==4 goto check_package_info

if %o%==5 goto pacman_append_mirror

goto end

rem --------------------------------------------------------------------------

REM 添加国内镜像源
:pacman_append_mirror

cls

call %msys2_shell_bat% %msys2_type% -where %~dp0 -c "bash ./append_extra_mirror_source.sh; ls /etc/pacman.d; %pause_cmd%"

goto do
rem --------------------------------------------------------------------------

REM 更新msys2仓库
:pacman_syu

cls

call %msys2_shell_bat% %command_args% -c "pacman -Syu; %pause_cmd%"

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

REM 查看包信息
:check_package_info

cls

@REM call %msys2_shell_bat% %msys2_type% -where %~dp0 -c "echo 'example command: check_package_info git'; bash --rcfile ./example_alias.sh"
call %msys2_shell_bat% %command_args% -c "alias check_package_info='Check_package_info(){ pacman -Ss $1;};Check_package_info'; echo 'example command: check_package_info git'; bash --rcfile <(alias)"

goto do
rem --------------------------------------------------------------------------

REM 查看已安装包
:show_install_list

cls

call %msys2_shell_bat% %command_args% -c "pacman -Sl; %pause_cmd%"

goto do
rem --------------------------------------------------------------------------

:end

pause

GOTO :eof

:convertpath
FOR /F "delims=" %%A IN ('echo %%%1%%') DO (
  set _path=%%~A
  set _path=!_path:\=/!
  set _path=!_path::=!
  set %1=/!_path!
)
GOTO :eof
