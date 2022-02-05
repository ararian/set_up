Disable-MicrosoftUpdate
Disable-UAC

# windowsにおけるソフトウェアインストールの自動化を行う

# powershellの実行権限を一時的に強化
Set-ExecutionPolicy Bypass -Scope Process -Force

# Install boxstarter and chocolatey simultaneously
. { Invoke-WebRequest -useb https://boxstarter.org/bootstrapper.ps1 } | Invoke-Expression; Get-Boxstarter -Force



# 拡張子表示
Set-WindowsExplorerOptions -EnableShowFileExtensions
# 隠しフォルダ表示
Set-WindowsExplorerOptions -EnableShowHiddenFilesFoldersDrives
# フォルダオプション「保護されたオペレーティング システム ファイルを表示しない（推奨）」
Set-WindowsExplorerOptions -EnableShowProtectedOSFiles

# リボン（上部メニュー内容）を常に表示
Set-WindowsExplorerOptions -EnableShowRibbon
# ナビゲーションウィンドウを「開いているフォルダーまで展開」しない
Set-WindowsExplorerOptions -DisableExpandToOpenFolder
# タイトルバーにフルパス表示
Set-WindowsExplorerOptions -EnableShowFullPathInTitleBar

# 「エクスプローラーで開く」を「クイックアクセス」から「PC」に
Set-WindowsExplorerOptions -DisableOpenFileExplorerToQuickAccess
# クイックアクセスに「最近使用したファイル」を非表示
Set-WindowsExplorerOptions -EnableShowRecentFilesInQuickAccess
# クイックアクセスの「よく使用するフォルダー」にピン留め以外も表示
Set-WindowsExplorerOptions -EnableShowFrequentFoldersInQuickAccess



winget install "Pycharm Community Edition" -h
winget install Miniconda3 -h
winget install --id  Microsoft.WindowsTerminal  -h
winget install "Microsoft Visual Studio Code" -h
code --install-extension hediet.vscode-drawio
winget install gitkraken -h
winget install --id Microsoft.VisualStudio.2019.Community -h
winget install WinSCP -h
winget install --id Discord.Discord -h
winget install --id 7zip.7zip -h
winget install --id Valve.Steam -h
winget install --id Microsoft.Teams -h

# conda installを実行するための準備 conda scriptの環境設定の実施
$path = [Environment]::GetEnvironmentVariable('Path', 'Machine')
$newpath = $path + ';' + $Home + '\miniconda3' + ';' + $Home + '\miniconda3\Library\bin' + ';' + $Home + '\miniconda3\Scripts' + ';' + $Home + '\miniconda3\condabin'
[Environment]::SetEnvironmentVariable("Path", $newpath, 'Machine')

conda init powershell
conda install pytorch torchvision torchaudio cudatoolkit=11.3 -c pytorch -y
conda install tensorflow -y
winget install "NVIDIA CUDA Toolkit" -v 11.3 -h

wsl --install

# 再起動後の実行処理を設定
$regRunOnceKey = "HKLM:\Software\Microsoft\Windows\CurrentVersion\RunOnce"
$powerShell = (Join-Path $env:windir "system32\WindowsPowerShell\v1.0\powershell.exe")
$script = "wsl --set-default-version 2"
$restartKey = "Restart-And-RunOnce"

Set-ItemProperty -path $regRunOnceKey -name $restartKey -value "$powerShell $script"

Restart-Computer -Force


Enable-UAC
Enable-MicrosoftUpdate
# Eula = End-User License Agreement
Install-WindowsUpdate -acceptEula
