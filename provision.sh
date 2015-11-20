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
git clone git@github.com:jwilger/dotfiles.git
cd dotfiles; git submodule init; git submodule update; rake update; cd -
