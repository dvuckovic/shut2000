# shut2ooo NSIS Configuration Script
# (d) [dUcA] 2oo2.

SetCompressor lzma
Name "shut2ooo"
InstallColors 000000 FFFFFF
OutFile "setup\shut2000.exe"

BrandingText " "
InstProgressFlags smooth
ShowInstDetails show
AutoCloseWindow true

InstallDir "$PROGRAMFILES\shut2ooo"
InstallDirRegKey HKLM "SOFTWARE\iDeFiX\NSIS_shut2ooo" "Install_Dir"

LicenseText "Click I Agree if you accept the agreement."
LicenseData "license.txt"

ComponentText "This will install shut2ooo on your computer. Select which type of install do you want. Start menu shortcuts come with keyboard shortcuts too. More in readme file."
DirText "Choose a directory to install in to:"

InstType "Standard"
InstType /COMPONENTSONLYONCUSTOM

Section "shut2ooo program files (required)"
SectionIn 1 2
  SetOutPath $INSTDIR
  File "shut2ooo.exe"
  File "readme.txt"
  WriteRegStr HKLM "SOFTWARE\iDeFiX\shut2ooo" "Install_Dir" "$INSTDIR"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\shut2ooo" "DisplayName" "shut2ooo"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\shut2ooo" "UninstallString" '"$INSTDIR\uninstall.exe"'
  WriteUninstaller "uninstall.exe"
  CreateDirectory "$SMPROGRAMS\shut2ooo"
  CreateShortCut "$SMPROGRAMS\shut2ooo\shut2ooo.lnk" "$INSTDIR\shut2ooo.exe" '' "$INSTDIR\shut2ooo.exe" 0 "SW_SHOWNORMAL" "ALT|CONTROL|SHIFT|X"
  CreateShortCut "$SMPROGRAMS\shut2ooo\Uninstall shut2ooo.lnk" "$INSTDIR\uninstall.exe"
SectionEnd

Section "Create Log off Start Menu shortcut"
SectionIn 1 2
  CreateShortCut "$SMPROGRAMS\shut2ooo\Log off.lnk" "$INSTDIR\shut2ooo.exe" '-l' "$INSTDIR\shut2ooo.exe" 2 "SW_SHOWNORMAL" "ALT|CONTROL|SHIFT|L"
SectionEnd

Section "Create Restart Start Menu shortcut"
SectionIn 1 2
  CreateShortCut "$SMPROGRAMS\shut2ooo\Restart.lnk" "$INSTDIR\shut2ooo.exe" '-r' "$INSTDIR\shut2ooo.exe" 1 "SW_SHOWNORMAL" "ALT|CONTROL|SHIFT|R"
SectionEnd

Section "Create Shut down Start Menu shortcut"
SectionIn 1 2
  CreateShortCut "$SMPROGRAMS\shut2ooo\Shut down.lnk" "$INSTDIR\shut2ooo.exe" '-s' "$INSTDIR\shut2ooo.exe" 0 "SW_SHOWNORMAL" "ALT|CONTROL|SHIFT|S"
SectionEnd

Function .onInstSuccess
  MessageBox MB_YESNO|MB_ICONQUESTION "Do you want to view readme file?" IDNO NoReadme
  Exec "$WINDIR\notepad.exe $INSTDIR\readme.txt"
  NoReadme:
  Reboot:
  MessageBox MB_YESNO|MB_ICONQUESTION "You must restart your computer in order$\n \
					the keyboard shortcuts to work. Would you$\n \
					like to restart your computer now?" IDNO NoReboot
  Reboot

  NoReboot:
FunctionEnd

CompletedText "Powered by Nullsoft SuperPiMP Install System"

UninstallText "This will uninstall shut2ooo. Click Next to continue."

Section "Uninstall"
  DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\shut2ooo"
  DeleteRegKey HKLM "Software\iDeFiX\shut2ooo"
  Delete $INSTDIR\*.*
  RMDir /r $INSTDIR
  Delete "$SMPROGRAMS\shut2ooo\*.*"
  RMDir "$SMPROGRAMS\shut2ooo"
  MessageBox MB_OK "Uninstall completed successfully!"
SetAutoClose True
SectionEnd

Function .onInit
  IfFileExists "$SYSDIR\msvbvm60.dll" 0 Abort
  Return
  Abort:
    MessageBox MB_OK|MB_ICONSTOP "Your system do not have Visual Basic 6 Runtime installed.$\n \
      $\n \
      Try to find installation file [vbrun60.exe] along with this$\n \
      distribution or from the place you got it in first place.$\n \
      $\n \
      - or -$\n \
      $\n \
      Try to download VB 6 Runtime from the Microsoft site:$\n \
      http://msdn.microsoft.com/downloads/$\n \
      $\n \
      This installer will now quit."
    Quit
FunctionEnd