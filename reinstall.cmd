@echo off

rem Todo: Migrate this to PowerShell.

rem Preliminary steps..
rem Set up network shares
set /p "user=Enter NAS account username: "
set /p "pass=Enter NAS account password: " 
net use /delete h:
net use /delete i:
net use /delete k:
net use /delete m:
net use /delete p:
net use /delete v:
net use /delete w:
net use /delete k:

net use h: \\filebox\emumedia /user:%user% %pass% /PERSISTENT:YES
net use i: \\filebox\Emu-FH /user:%user% %pass% /PERSISTENT:YES
net use k: \\filebox\plexripper /user:%user% %pass% /PERSISTENT:YES
net use m: \\filebox\mister /user:%user% %pass% /PERSISTENT:YES
net use p: \\filebox\fhstuff /user:%user% %pass% /PERSISTENT:YES
net use r: \\filebox\Resolve /user:%user% %pass% /PERSISTENT:YES
net use v: \\filebox\avmedia /user:%user% %pass% /PERSISTENT:YES
net use w: \\filebox\public /user:%user% %pass% /PERSISTENT:YES
net use k: \\filebox\plexripper /user:%user% %pass% /PERSISTENT:YES
set pass=
set user=

rem Install gsudo first..
winget install gerardog.gsudo 
rem Update the path..
path C:\Program Files\gsudo\Current\;%path%
rem Configure gsudo cache mode..
gsudo config cachemode auto

rem Installing the installers: Chocolatey..
gsudo winget install Chocolatey.Chocolatey

rem Installing the installers: Scoop..
pwsh /c "iwr -useb get.scoop.sh | iex"

rem Refresh environment...
refreshenv

rem Now we can install the rest of the packages!

rem Winget first..
gsudo winget install Doist.Todoist HeroicGamesLauncher.HeroicGamesLauncher 7zip.7zip OpenWhisperSystems.Signal Amazon.Kindle Audacity.Audacity AutoHotkey.AutoHotkey Codeusa.BorderlessGaming BurntSushi.ripgrep.GNU Discord.Discord voidtools.Everything AndreWiethoff.ExactAudioCopy GNU.Wget2 Git.Git GnuPG.GnuPG GnuPG.Gpg4win Gyan.FFmpeg HermannSchinagl.LinkShellExtension IrfanSkiljan.IrfanView rcmaehl.MSEdgeRedirect Microsoft.DevHome Microsoft.WindowsTerminal.Preview Mozilla.Firefox Mozilla.Thunderbird Insecure.Nmap Notepad++.Notepad++ OBSProject.OBSStudio Meta.Oculus JanDeDobbeleer.OhMyPosh Playnite.Playnite Plex.Plex SoftwareFreedomConservancy.QEMU Libretro.RetroArch Rufus.Rufus ScummVM.ScummVM Meltytech.Shotcut zyedidia.micro
gsudo winget install Valve.Steam Ubisoft.Connect RARLab.WinRAR Ferdium.Ferdium Balena.Etcher DupeGuru.DupeGuru Element.Element mIRC.mIRC WinSCP.WinSCP yt-dlp.yt-dlp Synology.DriveClient Microsoft.PowerShell KeePassXCTeam.KeePassXC Microsoft.DotNet.DesktopRuntime.7 Python.Launcher GitHub.cli Elgato.StreamDeck Foxit.FoxitReader Amazon.Games Logitech.GHUB Telegram.TelegramDesktop Microsoft.WindowsADK Microsoft.PowerToys Kitware.CMake Microsoft.ADKPEAddon Microsoft.OpenSSH.Beta calibre.calibre Google.Chrome tailscale.tailscale Oracle.VirtualBox Splashtop.SplashtopPersonal PlayStation.DualSenseFWUpdater VideoLAN.VLC JohnMacFarlane.Pandoc Microsoft.PowerShell Nvidia.PhysX namazso.OpenHashTab SteamGridDB.RomManager Microsoft.XNARedist 
gsudo winget install CodeSector.TeraCopy Microsoft.OpenJDK.11 dorssel.usbipd-win Microsoft.VisualStudioCode Python.Python.3.12 Microsoft.DotNet.DesktopRuntime.6 ElectronicArts.EADesktop Microsoft.DotNet.DesktopRuntime.8 CloudImperiumGames.RSILauncher KDE.Krita Logseq.Logseq WinDirStat.WinDirStat DigitalScholar.Zotero Twilio.Authy SyncTrayzor.SyncTrayzor mikf.gallery-dl GNU.Nano jftuga.less
gsudo winget install Nethack.Nethack GNU.Wget2 GNU.MidnightCommander sirredbeard.wslinternals Hugo.Hugo.Extended QmmpDevelopmentTeam.qmmp

rem Refresh environment...
refreshenv

rem Scoop next..
rem Since we used scoop export -c > scoopfile.json
rem This part is really easy!
pwsh -c scoop import scoopfile.json

rem Refresh environment...
refreshenv

rem Chocolatey after that..
gsudo choco install -y sphinx bind-toolsonly winevdm

rem Refresh environment...
refreshenv

rem Python modules
gsudo pip install internetarchive
gsudo pip install pyfiglet

rem Refresh environment...
refreshenv

rem Install Ruby gems..
~\scoop\apps\ruby\current\bin\gem.bat install lolcat

rem Refresh environment...
refreshenv

rem Set up wsl...
wsl --install
wsl -t Ubuntu
wsl --unregister Ubuntu
mkdir c:\Linux
mkdir c:\Linux\Ubuntu
wsl --import Ubuntu c:\Linux\Ubuntu "P:\WSL Backup\Ubuntu.vhdx" --vhd
ubuntu config --default-user firehawke
rem This next line commented out until I have more RAM on my desktop machine.
rem wslctl enable Ubuntu

rem Install additional fonts...
mkdir \tempinstall\
pushd
cd \tempinstall\
gh repo clone firehawke/fonts
cd fonts
pwsh /c "./install.ps1"
popd
rd /s /q \tempinstall

rem Disable the damned Zone.Identifier..
rem This won't take effect until next reboot.
gsudo .\LGPO.exe /u turn_off_zone_identifier.pol

rem Set up GHCLI authentication and helper..
gh auth login -h github.com 
