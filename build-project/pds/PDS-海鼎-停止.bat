@echo off
:begin
choice /c:YN /m:"确认停止服务，按Y继续，N取消！"
if %errorlevel%==2 goto end
if %errorlevel%==1 goto release

:release
md "./temp"
call ant -Dws=./temp -Denv.name=海鼎 -f build-pds.xml stop

:end
pause