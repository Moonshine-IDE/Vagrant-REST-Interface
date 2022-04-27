# -*- mode: ruby -*-
# vi: set ft=ruby :

# The ports on the host that you want to use to access the port on the guest.
# This must be greater than port 1024.
HTTP_SERVER_PORT=8080

APP_HOME_DIR="/opt/rest-interface"
Vagrant.configure(2) do |config|

  config.vm.box = "centos/7"

  # This prevents vagrant checking kernel and guest-additions for subsequent
  # vagrant up command executions, reducing the vm startup time
  if not isProvisioned(config.vm.box) then
    if Vagrant.has_plugin?("vagrant-vbguest") then
      config.vbguest.installer_options = { allow_kernel_upgrade: true }
      config.vbguest.auto_update = true
    else
      raise 'vagrant-vbguest is not installed! Please install vagrant-vbguest plugin!'
    end
  else
    config.vbguest.auto_update = false
  end

  config.vm.provider "virtualbox" do |vb|
     vb.name = "rest-interface"
     vb.memory = "1024"
   end

  config.vm.network "forwarded_port", guest: 8080, host: HTTP_SERVER_PORT, host_ip: "127.0.0.1"

  config.vm.synced_folder "./rest-interface", APP_HOME_DIR, create: true

  config.vm.provision "shell", path: "provision.sh", privileged: false

  config.vm.provision "shell", path: "always.sh", privileged: false, run: "always"

end

def isProvisioned(vm_name='default', provider='virtualbox')
  File.exists?(File.join(File.dirname(__FILE__),".vagrant/machines/#{vm_name}/#{provider}/action_provision"))
end
