@echo off
cls
echo.
rem %~dp0 为当前批处理文件的路径。
set qhome=%~dp0q\
start "q(5001)"  %~dp0q\w32\q.exe -p 5001 -U %~dp0q/qusers