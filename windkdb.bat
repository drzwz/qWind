@echo off
cls
echo.
rem %~dp0 Ϊ��ǰ�������ļ���·����
set qhome=%~dp0q\
start "windkdb(5002)"  %~dp0q\w32\q.exe wapi.q -p 5002 -U %~dp0q/qusers