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
## Running the demos
We have Vagrantfiles for Centos 7 and Ubuntu, you can use these files to launch a Virtual Machine containing the rest-interface application listening by default in the port 8095.

### Centos 7 demo VM
To start a Centos 7 Virtual Machine using Vagrant + Virtual Box:
1. Open a command line and change directory to the `demo/centos7` directory within this project.
2. execute `vagrant up` command to launch a virtual machine. By default, this Virtual machine will use the port 8095 in your computer, if that port is not available you can use a different one by changing the value of `HTTP_HOST_PORT` in the Vagrantfile.
3. Wait for the VM to be ready, the fist time you launch the VM it will take some time, between 5-10 minutes, subsequent usages (vagrant up) of the Virtual Machine should be considerably faster (about 1 minute or less).
4. When the VM is ready you will see the message: `rest-interface is starting at 127.0.0.1:8095, it takes about 20 seconds to become ready, please wait...`
5. You can then open [127.0.0.1:8095](http://127.0.0.1:8095) in your web browser and see the documentation page, where you can see the avaiable endpoints and some examples of how to use them.
6. To stop the Virtual Machine, from a command line in the demo/centos7 directory, execute: `vagrant halt`.

### Ubuntu demo VM
To start a Ubuntu Virtual Machine using Vagrant + Virtual Box:
1. Open a command line and change directory to the `demo/ubuntu` directory within this project.
2. Please continue from step 2 of the Centos 7 demo VM, the process is the same from there.

