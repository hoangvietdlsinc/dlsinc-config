Vagrant.configure("2") do |ansible_lab|
    ansible_lab.vm.define "webserver01" do |webserver01|
      webserver01.vm.provider "vmware_desktop" do |v|
       v.cpus = 2
        v.memory = 2048
      end
      webserver01.vm.box = "bento/rockylinux-8"
      webserver01.vm.hostname = "webserver01.dlsinc.internal"
      webserver01.vm.network "private_network", ip: "10.100.100.20"
      webserver01.vm.synced_folder ".", "/vagrant"
    end
    #ansible_lab.vm.define "database01" do |database01|
    # database01.vm.provider "vmware_desktop" do |v|
    #    v.cpus = 1
    #    v.memory = 1024
    #  end
    #  database01.vm.box = "bento/rockylinux-8"
    #  database01.vm.hostname = "database01.dlsinc.internal"
    #  database01.vm.network "private_network", ip: "10.100.100.30"
    #  database01.vm.synced_folder ".", "/vagrant"
    #end
    ansible_lab.vm.define "ansiblevm01" do |ansiblevm01|
      ansiblevm01.vm.provider "vmware_desktop" do |v|
        v.cpus = 1
        v.memory = 1024
      end
      ansiblevm01.vm.box = "bento/rockylinux-8"
      ansiblevm01.vm.hostname = "ansiblevm01.dlsinc.internal"
      ansiblevm01.vm.network "private_network", ip: "10.100.100.10"
      ansiblevm01.vm.provision "shell", path: "script.sh"
      ansiblevm01.vm.synced_folder ".", "/vagrant"
    end
  

  end