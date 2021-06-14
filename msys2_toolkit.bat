@echo off
rem ----------------------
rem 注意使用GBK编码编辑此文件
rem ----------------------
cd /d %~dp0..

title Msys2工具包

mode con cols=60 lines=20&color 0a

rem --------------------------------------------------------------------------

set ROOT=%cd%

call "%~dp0config.bat"
set msys2_shell_bat="%~dp0msys2_shell_ex.cmd"
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

cd /d %msys2_install_dir%
call %msys2_shell_bat% %msys2_type% -where %~dp0 -outside_exec "bash ./append_extra_mirror_source.sh; ls /etc/pacman.d; %pause_cmd%"

goto do
rem --------------------------------------------------------------------------

REM 更新msys2仓库
:pacman_syu

cls

cd /d %msys2_install_dir%
call %msys2_shell_bat% %command_args% -outside_exec "pacman -Syu; %pause_cmd%"

goto do
rem --------------------------------------------------------------------------

REM 安装开发依赖包
:install_base_dev

cls

cd /d %msys2_install_dir%
call %msys2_shell_bat% %command_args% -outside_exec "pacman -S --needed base-devel mingw-w64-x86_64-toolchain; %pause_cmd%"

goto do
rem --------------------------------------------------------------------------

REM 安装额外依赖包
:install_extra_dev

cls

cd /d %msys2_install_dir%
call %msys2_shell_bat% %command_args% -outside_exec "pacman -S --needed mingw-w64-x86_64-dlfcn; %pause_cmd%"

goto do
rem --------------------------------------------------------------------------

REM 查看包信息
:check_package_info

cls

cd /d %msys2_install_dir%
@REM call %msys2_shell_bat% %msys2_type% -where %~dp0 -outside_exec "echo 'example command: check_package_info git'; bash --rcfile ./example_alias.sh"
call %msys2_shell_bat% %command_args% -outside_exec "alias check_package_info='Check_package_info(){ pacman -Ss $1;};Check_package_info'; echo 'example command: check_package_info git'; bash --rcfile <(alias)"

goto do
rem --------------------------------------------------------------------------

REM 查看已安装包
:show_install_list

cls

cd /d %msys2_install_dir%
call %msys2_shell_bat% %command_args% -outside_exec "pacman -Sl; %pause_cmd%"

goto do
rem --------------------------------------------------------------------------

:end

pause
