# vi: set ft=ruby :
require_relative 'lib/vmresources'

Vagrant.configure(2) do |config|
  config.vm.box = "boxcutter/ubuntu1510"

  config.ssh.forward_agent = true
  config.ssh.private_key_path = VMResources.ssh_private_key_files
  config.ssh.insert_key = false

  config.vm.network "forwarded_port", guest: 80, host: 8080
  config.vm.network "forwarded_port", guest: 443, host: 8443

  config.timezone.value = :host

  config.vm.provider 'virtualbox' do |v|
    v.memory = VMResources.vm_memory(percent_of_host: 80)
    v.cpus = VMResources.vm_cpu_count(percent_of_host: 80)
  end

  config.vm.provision :shell, inline: "hostnamectl set-hostname dev.johnwilger.com"
  config.vm.provision "file", source: "~/.ssh/authorized_keys", destination: "~/.ssh/authorized_keys"
  config.vm.provision "file", source: "~/.ssh/known_hosts", destination: "~/.ssh/known_hosts"
  config.vm.provision "shell", path: "provision.sh", privileged: false

  config.trigger.after [:provision, :up, :reload] do
    system('echo "==> Fowarding Ports: 80 -> 8080, 443 -> 4443 & Enabling pf"')
    system('sudo sysctl -w net.inet.ip.forwarding=1')
    system(<<EOC
cat <<EOF | sudo pfctl -Ef -
rdr pass on lo0 inet proto tcp from any to any port 80 -> 127.0.0.1 port 8080
rdr pass on lo0 inet proto tcp from any to any port 443 -> 127.0.0.1 port 8443
rdr pass on en0 inet proto tcp from any to any port 2223 -> 127.0.0.1 port 2222
EOF
EOC
          )
  end
end
