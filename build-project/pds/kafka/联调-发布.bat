@echo off
:begin
choice /c:YN /m:"确认发布，按Y继续，N取消？"
if %errorlevel%==2 goto end
if %errorlevel%==1 goto release

:release
md "./temp"
call ant -Dws=./temp -Denv.name=联调

:end
pause