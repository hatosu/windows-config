# navigate to userdir
cd "$env:USERPROFILE\"

# check if winget exists & deal with it
if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
    Write-Host "winget not installed, attempting to install"
    $installerUrl = "https://aka.ms/getwinget"
    $installerPath = "$env:TEMP\AppInstaller.msixbundle"
    try {
        Invoke-WebRequest -Uri $installerUrl -OutFile $installerPath
        Write-Host "winget has been downloaded"
        Add-AppxPackage -Path $installerPath
        Write-Host "installation complete"
    } catch {
        Write-Host "failed to install winget, maybe try again?"
        Write-Host $_.Exception.Message
    }
} else {
    Write-Host "winget is already installed"
}

# enable sudo for powershell
PowerShell -Command "Set-ExecutionPolicy RemoteSigned -scope Process; [Net.ServicePointManager]::SecurityProtocol = 'Tls12'; iwr -useb https://raw.githubusercontent.com/gerardog/gsudo/master/installgsudo.ps1 | iex"
Write-Output "`nImport-Module 'gsudoModule'" | Add-Content $PROFILE

# setup nixos virtual machine for windows
wsl --install --no-distribution
Invoke-WebRequest 'github.com/nix-community/NixOS-WSL/releases/latest' -OutFile ./nixos-wsl.tar.gz
wsl --import NixOS $env:USERPROFILE\NixOS\ nixos-wsl.tar.gz --version 2

# prepare symlinks folder (located in C:\Users\SOMEUSER\symlinks)
winget install --id=Git.Git -e
git clone https://github.com/hatosu/windows-config
mv ".\windows-config\symlinks\" ".\symlinks\"
mv ".\windows-config\" ".\DELETE_THIS_FOLDER\"

# make symlinks
cmd /c mklink /d "$env:USERPROFILE\.glzr\glazewm" "$env:USERPROFILE\symlinks\glazewm"
cmd /c mklink /d "$env:USERPROFILE\.glzr\zebar" "$env:USERPROFILE\symlinks\zebar"
cmd /c mklink /d "$env:USERPROFILE\AppData\Roaming\alacritty" "$env:USERPROFILE\symlinks\alacritty"
cmd /c mklink /d "$env:USERPROFILE\AppData\Roaming\FlowLauncher" "$env:USERPROFILE\symlinks\FlowLauncher"
cmd /c mklink /d "$env:USERPROFILE\AppData\Roaming\Hyper" "$env:USERPROFILE\symlinks\Hyper"
cmd /c mklink /d "$env:USERPROFILE\AppData\Roaming\Vencord" "$env:USERPROFILE\symlinks\Vencord"

# install remaining applications
winget install --id=MullvadVPN.MullvadVPN -e
winget install --id=Zimwiki.Zim -e
winget install --id=ShareX.ShareX -e
winget install --id=Audacity.Audacity -e
winget install --id=AutoHotkey.AutoHotkey -e
winget install --id=KDE.Krita -e
winget install --id=Mozilla.Firefox -e
winget install --id=glzr-io.zebar -e
winget install --id=voidtools.Everything -e
winget install --id=Zoom.Zoom -e
winget install --id=Microsoft.PowerShell -e
winget install --id=Nvidia.PhysX -e
winget install --id=Nvidia.Broadcast -e
winget install --id=glzr-io.glazewm -e
winget install --id=Alacritty.Alacritty -e
winget install --id=BlenderFoundation.Blender -e
winget install --id=TheDocumentFoundation.LibreOffice -e
winget install --id=Flameshot.Flameshot -e
winget install --id=Klocman.BulkCrapUninstaller -e
winget install --id=OBSProject.OBSStudio -e
winget install --id=Parsec.Parsec -e
winget install --id=Valve.Steam -e
winget install --id=qBittorrent.qBittorrent -e
winget install --id=EpicGames.EpicGamesLauncher -e
winget install --id=Toinane.Colorpicker -e
winget install --id=Anki.Anki -e
winget install --id=Cemu.Cemu -e
winget install --id=Discord.Discord -e
winget install --id=Fastfetch-cli.Fastfetch -e
winget install --id=Flow-Launcher.Flow-Launcher -e
winget install --id=FreeCAD.FreeCAD -e
winget install --id=GodotEngine.GodotEngine -e
winget install --id=Rufus.Rufus -e
winget install --id=Spotify.Spotify -e
winget install --id=Vercel.Hyper -e
winget install --id=Obsidian.Obsidian -e
winget install --id=VSCodium.VSCodium -e
winget install --id=CharlesMilette.TranslucentTB -e
