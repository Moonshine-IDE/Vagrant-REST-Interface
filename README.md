# Vagrant-REST-Interface

## Summary
This project uses Github Actions to package the rest-interface.jar artifact and bash scripts (to provision a virtual machine) into a ZIP file. After each release, new ZIP files (one per supported operating system) are created and made available through Github release assets. Users interested in running a rest-interface instance in Vagrant,
can use this ZIP to easily deploy the rest-interface application into their Virtual Machine.

## Using the generated ZIP file within your Vagrant VM

### Requirements

Here are the requirements for this demo:
- [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
- [Vagrant](https://www.vagrantup.com/downloads)

Update your Vagrantfile as follows
1. Set the `HTTP_HOST_PORT` variable with the port you want to use (reserve) in your Host machine to access the rest-interface.
2. Set the `HTTP_GUEST_PORT` variable with the port that the rest-interface will use (reserve) in the virtual machine.
3. Add the variable `APP_HOME_DIR`, this will indicate the directory where the rest-interface files (binaries and logs) will live within the VM.

At the end, your Vagrantfile (Centos 7) should look like this
```
HTTP_HOST_PORT=8095
HTTP_GUEST_PORT=8080

APP_HOME_DIR="/opt/rest-interface"
Vagrant.configure(2) do |config|

  config.vm.box = "centos/7"

  config.vm.network "forwarded_port",
    guest: HTTP_GUEST_PORT,
    host: HTTP_HOST_PORT,
    host_ip: "127.0.0.1"

  config.vm.provision "shell", name:"Pull scripts for REST interface", privileged:true, inline: <<-SHELL
    # These libraries could be moved or removed by the user if they were already covered
    yum install -y wget
    yum install -y unzip
    wget https://github.com/Moonshine-IDE/Vagrant-REST-Interface/releases/download/0.1.2/VagrantCRUD_centos7.zip

    unzip -d rest VagrantCRUD_centos7.zip
    mv rest/rest-interface-*.jar rest/rest-interface.jar
    chmod +x -R rest/
  SHELL

  config.vm.provision "shell",
    inline: "/bin/sh /home/vagrant/rest/provision.sh $1",
    privileged: true,
    args: [
      APP_HOME_DIR
    ]

  config.vm.provision "shell",
    inline: "/bin/sh /home/vagrant/rest/always.sh $1 $2 $3",
    privileged: false,
    run: "always",
    args: [
      HTTP_GUEST_PORT,
      APP_HOME_DIR,
      HTTP_HOST_PORT
    ]

```
Take a look at the [demos](https://github.com/Moonshine-IDE/Vagrant-REST-Interface/tree/master/demo) for more examples.
