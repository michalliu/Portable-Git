@ECHO OFF
CLS
COLOR 0a

REM ���ݱ�BAT�ļ�·��ȷ��gvim��ִ���ļ�·��
SET WORKING_DIR=%~dp0
SET GIT_WORKING_DIR=\"--working-dir\" \"%%1\"
SET GIT_BASH=%WORKING_DIR%git-bash.bat
SET GIT_GUI=\"%WORKING_DIR%bin\wish.exe\" \"%WORKING_DIR%libexec\git-core\git-gui\"
SET OPEN_DOS=cmd
SET OPEN_DOS_OPTS= /K cd /d %%L

SET REG_ADD_OPTS=/f /ve /d
SET REG_DELETE_OPTS=/f
SET DIRECTORY_SHELL=HKCR\Directory\Background\shell\
SET FOLDER_SHELL=HKCR\Folder\shell\
ECHO.��Ϊ��:
ECHO        1.��װ�Ҽ��˵�
ECHO        2.�Ƴ��Ҽ��˵�
ECHO.
SET Choice=

:MAKECHOICE
SET /P Choice=����������ѡ��
IF '%Choice%'=='' GOTO MAKECHOICE

IF /I '%Choice%'=='1' GOTO INSTALL
IF /I '%Choice%'=='2' GOTO UNINSTALL
GOTO END

:INSTALL
REM DIRECTORY SHELL
reg add "%DIRECTORY_SHELL%git_bash" %REG_ADD_OPTS% "Git Bash"
reg add "%DIRECTORY_SHELL%git_bash\command" %REG_ADD_OPTS% %GIT_BASH%
reg add "%DIRECTORY_SHELL%git_gui" %REG_ADD_OPTS% "Git GUI"
reg add "%DIRECTORY_SHELL%git_gui\command" %REG_ADD_OPTS% "%GIT_GUI%"
reg add "%DIRECTORY_SHELL%open_dos" %REG_ADD_OPTS% "��DOS����"
reg add "%DIRECTORY_SHELL%open_dos\command" %REG_ADD_OPTS% "%OPEN_DOS%"
REM FOLDER SHELL
reg add "%FOLDER_SHELL%git_bash" %REG_ADD_OPTS% "Git Bash"
reg add "%FOLDER_SHELL%git_bash\command" %REG_ADD_OPTS% %GIT_BASH%
reg add "%FOLDER_SHELL%git_gui" %REG_ADD_OPTS% "Git GUI"
reg add "%FOLDER_SHELL%git_gui\command" %REG_ADD_OPTS% "%GIT_GUI% %GIT_WORKING_DIR%" 
reg add "%FOLDER_SHELL%open_dos" %REG_ADD_OPTS% "��DOS����"
reg add "%FOLDER_SHELL%open_dos\command" %REG_ADD_OPTS% "%OPEN_DOS% %OPEN_DOS_OPTS%" 
GOTO END

:UNINSTALL
reg delete "%DIRECTORY_SHELL%git_bash" %REG_DELETE_OPTS%
reg delete "%DIRECTORY_SHELL%git_gui" %REG_DELETE_OPTS%
reg delete "%DIRECTORY_SHELL%open_dos" %REG_DELETE_OPTS%
reg delete "%FOLDER_SHELL%git_bash" %REG_DELETE_OPTS%
reg delete "%FOLDER_SHELL%git_gui" %REG_DELETE_OPTS%
reg delete "%FOLDER_SHELL%open_dos" %REG_DELETE_OPTS%
GOTO END

:END
ECHO.
ECHO ��ѡ���������
PAUSE
