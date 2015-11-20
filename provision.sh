sudo locale-gen en_US.UTF-8
sudo cat - > /etc/default/locale <<EOF
LANG=en_US.UTF-8
LANGUAGE=
LC_CTYPE="en_US.UTF-8"
LC_NUMERIC="en_US.UTF-8"
LC_TIME="en_US.UTF-8"
LC_COLLATE="en_US.UTF-8"
LC_MONETARY="en_US.UTF-8"
LC_MESSAGES="en_US.UTF-8"
LC_PAPER="en_US.UTF-8"
LC_NAME="en_US.UTF-8"
LC_ADDRESS="en_US.UTF-8"
LC_TELEPHONE="en_US.UTF-8"
LC_MEASUREMENT="en_US.UTF-8"
LC_IDENTIFICATION="en_US.UTF-8"
LC_ALL=en_US.UTF-8
EOF
sudo apt-get update
sudo apt-get install -y \
  zsh \
  git \
  tmux \
  vim \
  libssl-dev libreadline-dev zlib1g-dev \
  postgresql libpq-dev \
  g++
git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
git clone https://github.com/ianheggie/rbenv-binstubs.git ~/.rbenv/plugins/rbenv-binstubs
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.zshrc.local
echo 'eval "$(rbenv init -)"' >> ~/.zshrc.local
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
rbenv install 2.2.3
rbenv global 2.2.3
rbenv rehash
sudo chsh -s /usr/bin/zsh vagrant
git clone git@github.com:jwilger/dotfiles.git ~/dotfiles
cd dotfiles; git submodule init; git submodule update; rake update; cd -
