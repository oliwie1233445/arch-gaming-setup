#!/bin/bash
set -e

echo "[+] Aktualizacja systemu..."
sudo pacman -Syu --noconfirm

echo "[+] Instalacja sterowników (mesa + vulkan)..."
sudo pacman -S --noconfirm mesa lib32-mesa vulkan-icd-loader lib32-vulkan-icd-loader

# Usuń komentarze zgodnie z GPU:
# sudo pacman -S --noconfirm nvidia nvidia-utils lib32-nvidia-utils nvidia-settings
# sudo pacman -S --noconfirm vulkan-radeon lib32-vulkan-radeon xf86-video-amdgpu
# sudo pacman -S --noconfirm vulkan-intel lib32-vulkan-intel xf86-video-intel

echo "[+] Wine, Steam, Lutris..."
sudo pacman -S --noconfirm wine wine-gecko wine-mono winetricks
sudo pacman -S --noconfirm steam lutris lib32-libpulse lib32-openal lib32-vkd3d

echo "[+] ProtonUp-Qt..."
sudo pacman -S --noconfirm protonup-qt

echo "[+] Narzędzia wydajności..."
sudo pacman -S --noconfirm gamemode mangohud goverlay

echo "[+] Audio i pady..."
sudo pacman -S --noconfirm pipewire pipewire-audio pipewire-pulse pipewire-alsa wireplumber
sudo pacman -S --noconfirm xboxdrv joystick

read -p "Zainstalować kernel ZEN? (t/n): " zen
[[ "$zen" == "t" ]] && yay -S --noconfirm linux-zen linux-zen-headers

read -p "Zainstalować Heroic Games Launcher? (t/n): " heroic
[[ "$heroic" == "t" ]] && yay -S --noconfirm heroic-games-launcher

echo "[+] Kopiowanie konfiguracji MangoHud..."
mkdir -p ~/.config/MangoHud
cp config/MangoHud.conf ~/.config/MangoHud/MangoHud.conf

echo "[+] Włączanie GameMode..."
mkdir -p ~/.config/systemd/user
cp config/gamemoded.service ~/.config/systemd/user/
systemctl --user enable --now gamemoded.service

echo "[+] Gotowe! Uruchom ProtonUp-Qt aby zainstalować Proton-GE dla Steam i Lutris."
