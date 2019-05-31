@echo off
:begin
choice /c:YN /m:"确认发布，按Y继续，N取消？"
if %errorlevel%==2 goto end
if %errorlevel%==1 goto release

:release

md "./temp-stos"
call ant -Dws=./temp-stos -Denv.name=联调 -f build-stos.xml

:end
pause