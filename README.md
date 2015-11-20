# Dev Box #

Dev Box is a simple [Vagrant][vagrant] configuration that I use to
configure a virtual machine for my personal development projects. It
uses a simple [shell provisioner][shell-provisioner], and is configured
to allocate approximately 80% of the host machine's RAM and CPU
resources (configurable in the [Vagrantfile][vagrantfile]).

## Vagrant Plugins ##

Make sure the following vagrant plugins are installed on the host
machine with `vagrant plugin install {plugin-name}`:

* vagrant-vbguest
* vagrant-timezone

[vagrant]: http://vagrantup.com
[shell-provisioner]: provision.sh
[vagrantfile]: Vagrantfile
