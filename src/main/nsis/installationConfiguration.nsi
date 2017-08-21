;MyApp

;--------------------------------
;Include Modern UI

  !include "MUI2.nsh"
  !include ..\..\..\target\project.nsh

;--------------------------------
;General

  ;Name and file
  Name "${PROJECT_NAME}"
  
  ; Handled by plugin
  ;OutFile "${PROJECT_BUILD_DIR}\Setup${PROJECT_NAME}.exe"

  ;Default installation folder
  InstallDir "$LOCALAPPDATA\${PROJECT_NAME}"
  
  ;Get installation folder from registry if available
  InstallDirRegKey HKCU "Software\${PROJECT_NAME}" ""

  ;Request application privileges for Windows Vista
  RequestExecutionLevel user


;--------------------------------
;Variables

  Var StartMenuFolder
;--------------------------------
;Interface Settings

  !define MUI_ABORTWARNING
  !define MUI_HEADERIMAGE
  !define MUI_HEADERIMAGE_BITMAP "myappbanner.bmp"

;--------------------------------
;Pages

  !insertmacro MUI_PAGE_WELCOME
  !define MUI_PAGE_CUSTOMFUNCTION_SHOW licpageshow
  !insertmacro MUI_PAGE_LICENSE "License.txt"
  !insertmacro MUI_PAGE_COMPONENTS
  !insertmacro MUI_PAGE_DIRECTORY

;Start Menu Folder Page Configuration
  !define MUI_STARTMENUPAGE_REGISTRY_ROOT "HKCU" 
  !define MUI_STARTMENUPAGE_REGISTRY_KEY "Software\${PROJECT_NAME}"
  !define MUI_STARTMENUPAGE_REGISTRY_VALUENAME "${PROJECT_NAME}"
  
  !insertmacro MUI_PAGE_STARTMENU Application $StartMenuFolder

  !insertmacro MUI_PAGE_INSTFILES
  !define MUI_FINISHPAGE_NOAUTOCLOSE
  !define MUI_FINISHPAGE_RUN
  !define MUI_FINISHPAGE_RUN_NOTCHECKED
  !define MUI_FINISHPAGE_RUN_TEXT "Start ${PROJECT_NAME} Now"
  !define MUI_FINISHPAGE_RUN_FUNCTION "LaunchLink"
  !define MUI_FINISHPAGE_SHOWREADME_NOTCHECKED
  !define MUI_FINISHPAGE_SHOWREADME $INSTDIR\readme.txt
  !insertmacro MUI_PAGE_FINISH
  
  !insertmacro MUI_UNPAGE_CONFIRM
  !insertmacro MUI_UNPAGE_INSTFILES
  !insertmacro MUI_UNPAGE_FINISH
  
;--------------------------------
;Languages
 
  !insertmacro MUI_LANGUAGE "English"

;--------------------------------
;Installer Sections

Section "${PROJECT_NAME}" MyApp

  SetOutPath "$INSTDIR"
  
  ;ADD YOUR OWN FILES HERE...
  File /r ..\..\..\target\getdown-stub\*.*
  File myapp.ico
  File myappsmall.ico
  File myappbanner.bmp
  File Readme.txt
  
  ;Store installation folder
  WriteRegStr HKCU "Software\${PROJECT_NAME}" "" $INSTDIR
  
  ;Create uninstaller
  WriteUninstaller "$INSTDIR\Uninstall.exe"

  ;Create shortcuts

  ;Start Menu Shortcut
  CreateDirectory "$SMPROGRAMS\$StartMenuFolder"
  CreateShortCut "$SMPROGRAMS\$StartMenuFolder\${PROJECT_NAME}.lnk" "$INSTDIR\getdown.jar" \
	"." \
	$INSTDIR\myapp.ico 0 SW_SHOWNORMAL ALT|CONTROL|SHIFT|U "${PROJECT_NAME}"
  CreateShortCut "$SMPROGRAMS\$StartMenuFolder\Uninstall.lnk" "$INSTDIR\Uninstall.exe"

  ;Desktop Shortcut
  CreateShortCut "$DESKTOP\${PROJECT_NAME}.lnk" "$INSTDIR\getdown.jar" \
	"." \
	$INSTDIR\myapp.ico 0 SW_SHOWNORMAL ALT|CONTROL|SHIFT|U "${PROJECT_NAME}"
SectionEnd

;--------------------------------
;Descriptions

  ;Language strings
  LangString DESC_MyApp ${LANG_ENGLISH} "${PROJECT_NAME}"

  ;Assign language strings to sections
  !insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
    !insertmacro MUI_DESCRIPTION_TEXT ${MyApp} $(DESC_MyApp)
  !insertmacro MUI_FUNCTION_DESCRIPTION_END

;--------------------------------
;Uninstaller Section

Section "Uninstall"

  ;ADD YOUR OWN FILES HERE...

  Delete "$INSTDIR\Uninstall.exe" ; delete self
  Delete "$INSTDIR\*"
  RMDir /r "$INSTDIR\lib"
  RMDir /r "$INSTDIR\assets"

  RMDir /REBOOTOK "$INSTDIR"

  !insertmacro MUI_STARTMENU_GETFOLDER Application $StartMenuFolder
    
  Delete "$SMPROGRAMS\$StartMenuFolder\Uninstall.lnk"
  Delete "$SMPROGRAMS\$StartMenuFolder\${PROJECT_NAME}.lnk"
  RMDir "$SMPROGRAMS\$StartMenuFolder"

  DeleteRegKey /ifempty HKCU "Software\${PROJECT_NAME}"

SectionEnd

Function licpageshow
    FindWindow $0 "#32770" "" $HWNDPARENT
    CreateFont $1 "Courier New" "$(^FontSize)"
    GetDlgItem $0 $0 1000
    SendMessage $0 ${WM_SETFONT} $1 1
FunctionEnd

Function LaunchLink
  ExecShell "" "$SMPROGRAMS\$StartMenuFolder\${PROJECT_NAME}.lnk"
FunctionEnd