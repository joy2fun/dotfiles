@echo off

:start
ECHO Type backup or setup
SET /P op=

IF %op%==backup ( GOTO backup ) ELSE ( GOTO start )
IF %op%==setup  ( GOTO setup ) ELSE ( GOTO start )

:backup
ECHO coping .gitconfig
COPY /Y %UserProfile%\.gitconfig %CD%\.gitconfig-win
ECHO done!
GOTO end

:setup
ECHO restoring .gitconfig
COPY /Y %CD%\.gitconfig-win %UserProfile%\.gitconfig
ECHO done!
GOTO end

:end
SET op=
PAUSE
