@echo off

set ROOT=%1

cd /d %ROOT%

echo �ο���ʽ��2022/11/27 22:11:22
set /p COMMIT_DATE=

set GIT_COMMITTER_DATE="%COMMIT_DATE%"
git commit --amend --date "%COMMIT_DATE%"

cmd.exe
