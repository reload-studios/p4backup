@echo off

::::: p4backup.bat :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::
:: A tiny Windows Batch Script to backup a Perforce Server 
:: 
:: arguments:
:: 		(none)
::
:: usage:
:: 		set it up with Windows Scheduler, or run it manually from console
::
:: requires:
:: 		7zip, like winzip or winrar, except that it's free and open source. get it here: http://www.7-zip.org/
::		make sure 7z is in your PATH.
::
:: On Github: https://github.com/lautarodragan/p4backup
:: On Build Failure: http://buildfailure.co/batch-script-to-backup-a-perforce-server
::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::


:: Settings
set P4ROOT=C:\Program Files\Perforce\Server
set output="%P4ROOT%\%date:~0,2%-%date:~3,2%-%date:~6,4%.7z"
set ouput_dir=D:\Google Drive\Perforce Backup\

:: The Magic
cd "%P4ROOT%"
p4d -r "%P4ROOT%" -jc "%P4ROOT%\jc\p

:: Optionally, you can also backup your databases
REM mysqldump dbname --user=root --password=123456 > dbname_db_dump.sql
REM if not %ERRORLEVEL%==0 exit /b 1

:: Compress everything into a .7z file.
7z a -t7z %output% "%P4ROOT%\*" -x!p4*.exe -x!svcinst.exe -mmt

:: Copy the output file to your google drive folder. 
move %output% "%ouput_dir%"