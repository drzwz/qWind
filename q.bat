@echo off
cls
echo.
rem %~dp0 Ϊ��ǰ�������ļ���·����
set qhome=%~dp0q\
start "q(5001)"  %~dp0q\w32\q.exe -p 5001 -U %~dp0q/qusers