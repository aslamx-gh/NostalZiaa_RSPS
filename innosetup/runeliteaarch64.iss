[Setup]
AppName=NostalZiaa Launcher
AppPublisher=NostalZiaa
UninstallDisplayName=NostalZiaa
AppVersion=${project.version}
AppSupportURL=https://nostalziaarsps.eu
DefaultDirName={localappdata}\NostalZiaa

; ~30 mb for the repo the launcher downloads
ExtraDiskSpaceRequired=30000000
ArchitecturesAllowed=arm64
PrivilegesRequired=lowest

WizardSmallImageFile=${project.projectDir}/innosetup/runelite_small.bmp
SetupIconFile=${project.projectDir}/innosetup/runelite.ico
UninstallDisplayIcon={app}\NostalZiaa.exe

Compression=lzma2
SolidCompression=yes

OutputDir=${project.projectDir}
OutputBaseFilename=NostalZiaaSetupAArch64

[Tasks]
Name: DesktopIcon; Description: "Create a &desktop icon";

[Files]
Source: "${project.projectDir}\build\win-aarch64\NostalZiaa.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "${project.projectDir}\build\win-aarch64\NostalZiaa.jar"; DestDir: "{app}"
Source: "${project.projectDir}\build\win-aarch64\launcher_aarch64.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "${project.projectDir}\build\win-aarch64\config.json"; DestDir: "{app}"
Source: "${project.projectDir}\build\win-aarch64\jre\*"; DestDir: "{app}\jre"; Flags: recursesubdirs

[Icons]
; start menu
Name: "{userprograms}\NostalZiaa\NostalZiaa"; Filename: "{app}\NostalZiaa.exe"
Name: "{userprograms}\NostalZiaa\NostalZiaa (configure)"; Filename: "{app}\NostalZiaa.exe"; Parameters: "--configure"
Name: "{userprograms}\NostalZiaa\NostalZiaa (safe mode)"; Filename: "{app}\NostalZiaa.exe"; Parameters: "--safe-mode"
Name: "{userdesktop}\NostalZiaa"; Filename: "{app}\NostalZiaa.exe"; Tasks: DesktopIcon

[Run]
Filename: "{app}\NostalZiaa.exe"; Parameters: "--postinstall"; Flags: nowait
Filename: "{app}\NostalZiaa.exe"; Description: "&Open NostalZiaa"; Flags: postinstall skipifsilent nowait

[InstallDelete]
; Delete the old jvm so it doesn't try to load old stuff with the new vm and crash
Type: filesandordirs; Name: "{app}\jre"
; previous shortcut
Type: files; Name: "{userprograms}\NostalZiaa.lnk"

[UninstallDelete]
Type: filesandordirs; Name: "{%USERPROFILE}\.nostalziaa\repository2"
; includes install_id, settings, etc
Type: filesandordirs; Name: "{app}"

[Registry]
Root: HKCU; Subkey: "Software\Classes\runelite-jav"; ValueType: string; ValueName: ""; ValueData: "URL:runelite-jav Protocol"; Flags: uninsdeletekey
Root: HKCU; Subkey: "Software\Classes\runelite-jav"; ValueType: string; ValueName: "URL Protocol"; ValueData: ""; Flags: uninsdeletekey
Root: HKCU; Subkey: "Software\Classes\runelite-jav\shell"; Flags: uninsdeletekey
Root: HKCU; Subkey: "Software\Classes\runelite-jav\shell\open"; Flags: uninsdeletekey
Root: HKCU; Subkey: "Software\Classes\runelite-jav\shell\open\command"; ValueType: string; ValueName: ""; ValueData: """{app}\NostalZiaa.exe"" ""%1"""; Flags: uninsdeletekey

[Code]
#include "upgrade.pas"
#include "usernamecheck.pas"
#include "dircheck.pas"
