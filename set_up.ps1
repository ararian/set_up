Disable-MicrosoftUpdate
Disable-UAC

# windowsにおけるソフトウェアインストールの自動化を行う

# Windows Exploler等の設定を行うツールのダウンロード
# Install boxstarter and chocolatey simultaneously
. { Invoke-WebRequest -useb https://boxstarter.org/bootstrapper.ps1 } | Invoke-Expression; Get-Boxstarter -Force

# Windows Exploler等の設定を行う
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


# 各種ソフトウェアのダウンロード・インストール

# minicondaのインストール
# conda installを実行するための準備 conda scriptの環境設定の実施
winget install Miniconda3 -h
$path = [Environment]::GetEnvironmentVariable('Path', 'Machine')
$newpath = $path + ';' + $Home + '\miniconda3' + ';' + $Home + '\miniconda3\Library\bin' + ';' + $Home + '\miniconda3\Scripts' + ';' + $Home + '\miniconda3\condabin'
[Environment]::SetEnvironmentVariable("Path", $newpath, 'Machine')

winget install --id  Microsoft.WindowsTerminal  -h
winget install "Microsoft Visual Studio Code" -h
code --install-extension hediet.vscode-drawio
winget install "Pycharm Community Edition" -h
winget install --id Microsoft.VisualStudio.2022.Community -h
winget install WinSCP -h
winget install --id 7zip.7zip -h
winget install --id Git.Git -h
winget install --id Microsoft.Teams -h
winget install --id GitHub.GitHubDesktop -h

winget install --id Valve.Steam -h
winget install --id Discord.Discord -h


#download & install  pytoruch, tensorflow and CUDA 
winget install "NVIDIA CUDA Toolkit" -v 11.7 -h
conda init powershell
conda install pytorch torchvision torchaudio pytorch-cuda=11.7 -c pytorch -c nvidia
conda install tensorflow -y

wsl --install

Enable-UAC
Enable-MicrosoftUpdate
# Eula = End-User License Agreement
Install-WindowsUpdate -acceptEula
