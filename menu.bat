@ECHO OFF
CLS
COLOR 0a

REM 根据本BAT文件路径确定gvim可执行文件路径
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
ECHO.请为我:
ECHO        1.安装右键菜单
ECHO        2.移除右键菜单
ECHO.
SET Choice=

:MAKECHOICE
SET /P Choice=请输入您的选择：
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
reg add "%DIRECTORY_SHELL%open_dos" %REG_ADD_OPTS% "打开DOS窗口"
reg add "%DIRECTORY_SHELL%open_dos\command" %REG_ADD_OPTS% "%OPEN_DOS%"
REM FOLDER SHELL
reg add "%FOLDER_SHELL%git_bash" %REG_ADD_OPTS% "Git Bash"
reg add "%FOLDER_SHELL%git_bash\command" %REG_ADD_OPTS% %GIT_BASH%
reg add "%FOLDER_SHELL%git_gui" %REG_ADD_OPTS% "Git GUI"
reg add "%FOLDER_SHELL%git_gui\command" %REG_ADD_OPTS% "%GIT_GUI% %GIT_WORKING_DIR%" 
reg add "%FOLDER_SHELL%open_dos" %REG_ADD_OPTS% "打开DOS窗口"
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
ECHO 所选命令已完成
PAUSE
