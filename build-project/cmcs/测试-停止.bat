@echo off
:begin
choice /c:YN /m:"确认停止，按Y继续，N取消！"
if %errorlevel%==2 goto end
if %errorlevel%==1 goto release

:release
call ant -f docker-deploy.xml -Denv_name=测试 stop

:end
pause