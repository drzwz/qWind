@echo off
cls
echo.
rem %~dp0 Ϊ��ǰ�������ļ���·����
set qhome=%~dp0q\
start "windwsq"  %~dp0q\w32\q.exe wsqsub_sample.q -p 5003 -U %~dp0q/qusers