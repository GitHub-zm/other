@echo off
:begin
choice /c:YN /m:"确认发布，按Y继续，N取消！"
if %errorlevel%==2 goto end
if %errorlevel%==1 goto release

:release
md "./temp"
call ant -Dws=./temp -Dwr=hd -Dtg=voucher -Denv.name=海鼎

:end
pause