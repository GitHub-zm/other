@echo off
:begin
choice /c:YN /m:"确认启动，按Y继续，N取消！"
if %errorlevel%==2 goto end
if %errorlevel%==1 goto release

:release
md "./temp-zjlh"
call ant -Dws=./temp-zjlh -Dwr=hd -Dtg=hdposweb -Denv.name=海鼎 -Denv.version=zjlh start

:end
pause