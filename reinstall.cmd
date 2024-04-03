@echo off
rem Preliminary steps..
rem Set up network shares
net use h: \\filebox\emumedia /user:firehawke * /PERSISTENT:YES
net use i: \\filebox\Emu-FH /user:firehawke * /PERSISTENT:YES
net use p: \\filebox\fhstuff /user:firehawke * /PERSISTENT:YES
net use v: \\filebox\avmedia /user:firehawke * /PERSISTENT:YES
net use w: \\filebox\public /user:firehawke * /PERSISTENT:YES

rem Install gsudo first..
winget install gerardog.gsudo 
rem Since the path hasn't been updated yet, we'll have to manually hit up the gsudo.exe file..
rem Configure "C:\Program Files\gsudo\Current\gsudo.exe" cache mode..
"C:\Program Files\gsudo\Current\gsudo.exe" config cachemode auto

rem Installing the installers: Chocolatey..
"C:\Program Files\gsudo\Current\gsudo.exe" winget install Chocolatey.Chocolatey

rem Installing the installers: Scoop..
pwsh /c "iwr -useb get.scoop.sh | iex"

rem Now we can install the rest of the packages!

rem Winget first..
"C:\Program Files\gsudo\Current\gsudo.exe" winget install Doist.Todoist HeroicGamesLauncher.HeroicGamesLauncher 7zip.7zip OpenWhisperSystems.Signal Amazon.Kindle Audacity.Audacity AutoHotkey.AutoHotkey Codeusa.BorderlessGaming BurntSushi.ripgrep.GNU Discord.Discord voidtools.Everything AndreWiethoff.ExactAudioCopy GNU.Wget2 Git.Git GnuPG.GnuPG GnuPG.Gpg4win Gyan.FFmpeg HermannSchinagl.LinkShellExtension IrfanSkiljan.IrfanView rcmaehl.MSEdgeRedirect Microsoft.DevHome Microsoft.WindowsTerminal.Preview Mozilla.Firefox Mozilla.Thunderbird Insecure.Nmap Notepad++.Notepad++ OBSProject.OBSStudio Meta.Oculus JanDeDobbeleer.OhMyPosh Playnite.Playnite Plex.Plex SoftwareFreedomConservancy.QEMU Libretro.RetroArch Rufus.Rufus ScummVM.ScummVM Meltytech.Shotcut
"C:\Program Files\gsudo\Current\gsudo.exe" winget install Valve.Steam Ubisoft.Connect RARLab.WinRAR Ferdium.Ferdium Balena.Etcher DupeGuru.DupeGuru Element.Element mIRC.mIRC WinSCP.WinSCP yt-dlp.yt-dlp Synology.DriveClient Microsoft.PowerShell KeePassXCTeam.KeePassXC Microsoft.DotNet.DesktopRuntime.7 Python.Launcher GitHub.cli Elgato.StreamDeck Foxit.FoxitReader Amazon.Games Logitech.GHUB Telegram.TelegramDesktop Microsoft.WindowsADK Microsoft.PowerToys Kitware.CMake Microsoft.ADKPEAddon Microsoft.OpenSSH.Beta calibre.calibre Google.Chrome tailscale.tailscale Oracle.VirtualBox Splashtop.SplashtopPersonal PlayStation.DualSenseFWUpdater VideoLAN.VLC JohnMacFarlane.Pandoc Microsoft.PowerShell Nvidia.PhysX namazso.OpenHashTab SteamGridDB.RomManager Microsoft.XNARedist 
"C:\Program Files\gsudo\Current\gsudo.exe" winget install CodeSector.TeraCopy Microsoft.OpenJDK.11 dorssel.usbipd-win Microsoft.VisualStudioCode Python.Python.3.12 Microsoft.DotNet.DesktopRuntime.6 ElectronicArts.EADesktop Microsoft.DotNet.DesktopRuntime.8 CloudImperiumGames.RSILauncher KDE.Krita Logseq.Logseq WinDirStat.WinDirStat DigitalScholar.Zotero Twilio.Authy SyncTrayzor.SyncTrayzor mikf.gallery-dl GNU.Nano jftuga.less
"C:\Program Files\gsudo\Current\gsudo.exe" winget install Nethack.Nethack GNU.Wget2 GNU.MidnightCommander sirredbeard.wslinternals Hugo.Hugo.Extended

rem Scoop next..
rem Since we used scoop export -c > scoopfile.json
rem This part is really easy!
scoop import scoopfile.json

rem Chocolatey after that..
"C:\Program Files\gsudo\Current\gsudo.exe" choco install -y sphinx bind-toolsonly winevdm

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

rem Set up GHCLI authentication and helper..
gh auth login -h github.com 

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
"C:\Program Files\gsudo\Current\gsudo.exe" .\LGPO.exe /u turn_off_zone_identifier.pol
