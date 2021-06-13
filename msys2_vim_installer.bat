@echo off
::判断是否已经获取了管理员身份
Md "%WinDir%\System32\test_permissions" 2>NUL||(Echo 请使用右键管理员身份运行&&Pause >NUL&&Exit)
Rd "%WinDir%\System32\test_permissions" 2>NUL
SetLocal EnableDelayedExpansion

call "%~dp0create_depends_env.bat"

::设置右键菜单项的名称
set desc="Msys2-Vim"
::设置执行脚本
set runbat="run_msys2_vim.bat"
::设置子路径名称
set subname="msys2_vim"
::去掉双引号，主要是为了兼容包含了空格的文件名或路径
call :removequotes runbat
call :removequotes subname

::添加注册表信息
reg add "HKEY_CLASSES_ROOT\Directory\background\shell\%subname%" /v "" /t REG_SZ /d %desc%
reg add "HKEY_CLASSES_ROOT\Directory\background\shell\%subname%\command" /v ""  /t REG_EXPAND_SZ /d "\"%~dp0%runbat%\" \"%%V\"

reg add "HKEY_CURRENT_USER\Software\Classes\*\shell\%subname%" /v "" /t REG_SZ /d %desc%
reg add "HKEY_CURRENT_USER\Software\Classes\*\shell\%subname%\command" /v "" /t REG_EXPAND_SZ /d "\"%~dp0%runbat%\" \"%%V\"

reg add "HKEY_CLASSES_ROOT\Directory\shell\%subname%" /v "" /t REG_SZ /d %desc%
reg add "HKEY_CLASSES_ROOT\Directory\shell\%subname%\command" /v "" /t REG_EXPAND_SZ /d "\"%~dp0%runbat%\" \"%%V\"

:removequotes
FOR /F "delims=" %%A IN ('echo %%%1%%') DO set %1=%%~A
GOTO :eof