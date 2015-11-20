# Dev Box #

Dev Box is a simple [Vagrant][vagrant] configuration that I use to
configure a virtual machine for my personal development projects. It
uses a simple [shell provisioner][shell-provisioner], and is configured
to allocate approximately 80% of the host machine's RAM and CPU
resources (configurable in the [Vagrantfile][vagrantfile]).

[vagrant]: http://vagrantup.com
[shell-provisioner]: provision.sh
[vagrantfile]: VagrantFile
