@echo off
:begin
choice /c:YN /m:"确认停止，按Y继续，N取消！"
if %errorlevel%==2 goto end
if %errorlevel%==1 goto release

:release
md "./temp-sdzh"
call ant -Dws=./temp-sdzh -Dwr=hd -Dtg=hdposweb -Denv.name=振华 -Denv.version=sdzh stop

:end
pause