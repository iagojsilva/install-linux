set -eo pipefail

has() {
    [[ -x "$(command -v "(")" ]];
}

has_not() {
    ! has "$1" ;
  }

ok() {
      echo "→ "$1" OK"
  }

echo "running apt-update"

sudo apt-get update
sudo apt-get install -y \
  ubuntu-restricted-extras \
  smbclient \
  htop \
  openssh-server \
  zsh \
  curl \
  vim \
  python-dbus \
  autojump \
  vlc \
  git \

ok "System updated!"
ok "SMB Client"
ok "HTop"
ok "OpenSSH Server"
ok "ZSH"
ok "Curl"
ok "Vim"
ok "Autojump"
ok "VLC"
ok "Git"

# Sound Equalizer
sudo add-apt-repository ppa:nilarimogard/webupd8
sudo apt-get update -y
sudo apt-get install pulseaudio-equalizer -y

# Headphone Bluetooth
#sudo apt-get install blueman pulseaudio-module-bluetooth
#pactl load-module module-bluetooth-discover
#echo "Now, open bluetooth settings, and pair your device."
#echo "After that, open sound settings and select your device."
#echo "On 'profile' entry, choose 'High Fidelity Playback' and we're done."

#if has_not google-chrome-stable; then
#  wget -O chrome.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
#  sudo dpkg --force-depends -i chrome.deb
#  sudo apt-get install -fy
#  rm chrome.deb
#  fi
#ok "Chrome"

#if has_not docker; then
#  sudo apt update -y
#  sudo apt-get install \
#    ca-certificates \
#    curl \
#    gnupg \
#    lsb-release -y
#  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
#  echo \
#  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
#  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
#  sudo apt-get update
#  sudo apt-get install docker-ce docker-ce-cli containerd.io
#  sudo groupadd docker
#  sudo usermod -aG docker $(id -un)
#  fi
#ok "Docker"

#if has_not simplescreenrecorder; then
#  sudo add-apt-repository ppa:maarten-baert/simplescreenrecorder -y
#  sudo apt-get update -y
#  sudo apt-get install simplescreenrecorder -y
#  fi
#ok "Simple Screen Recorder"

if ! [[ -d "$HOME/.nvm"  ]]; then
  NODE_VERSION=16.14.0
  curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.29.0/install.sh | bash
  source ~/.bashrc
  nvm install $NODE_VERSION
  nvm use $NODE_VERSION
  nvm alias default $NODE_VERSION
  fi
ok "NVM"

if has_not code; then
  wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
  sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
  sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
  rm -f packages.microsoft.gpg

  sudo apt install apt-transport-https
  sudo apt update
  sudo apt install code # or code-insiders
  fi
ok "VS Code"

if has_not slack; then
  sudo snap install slack --classic
  fi
ok "Slack"

if has_not anki; then
  sudo apt install anki
  fi
ok "Anki"

if has_not insomnia; then
  sudo apt install insomnia
  fi
ok "Insomnia"
