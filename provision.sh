sudo locale-gen en_US.UTF-8
cat <<EOF | sudo tee -a /etc/default/locale
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
  ack-grep \
  zsh \
  git \
  tmux \
  vim \
  libssl-dev libreadline-dev zlib1g-dev \
  postgresql libpq-dev \
  g++ \
  nginx

sudo -u postgres createuser -s vagrant

cat <<EOF | sudo tee /etc/nginx/sites-available/default
upstream dev {
  server 127.0.0.1:3000;
}

server {
  listen 80 default_server;
  listen [::]:80 default_server;
  root /dev/null;
  index index.html index.htm index.nginx-debian.html;
  server_name _;
  try_files \$uri/index.html \$uri.html \$uri @dev;
  location @dev {
    proxy_set_header  X-Real-IP        \$remote_addr;
    proxy_set_header  X-Forwarded-For  \$proxy_add_x_forwarded_for;
    proxy_set_header  Host             \$http_host;
    proxy_redirect    off;
    proxy_pass        http://dev;
  }
  error_page   500 502 503 504  /50x.html;
}
EOF
sudo service nginx reload

git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
git clone https://github.com/ianheggie/rbenv-binstubs.git ~/.rbenv/plugins/rbenv-binstubs
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
rbenv install 2.2.3
rbenv global 2.2.3
rbenv rehash
gem install bundler
rbenv rehash

sudo git clone git://github.com/zolrath/wemux.git /usr/local/share/wemux
sudo ln -s /usr/local/share/wemux/wemux /usr/local/bin/wemux
cat <<EOF | sudo tee /usr/local/etc/wemux.conf
host_list=(vagrant)
allow_rogue_mode="false"
default_client_mode="pair"
EOF
echo "/usr/local/bin/wemux" | sudo tee -a /etc/shells

mkdir -p ~/bin
cp /vagrant/files/pair_with ~/bin
chmod +x ~/bin/pair_with

sudo chsh -s /usr/bin/zsh vagrant
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.zshrc.local
echo 'eval "$(rbenv init -)"' >> ~/.zshrc.local

git clone git@github.com:jwilger/dotfiles.git ~/dotfiles
cd ~/dotfiles; git submodule init; git submodule update; rake update; cd -
