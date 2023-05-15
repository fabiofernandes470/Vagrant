# -*- mode: ruby -*-
# vi: set ft=ruby :

vms = {
  #'m1' => {'memory' => '512', 'cpus' => 1, 'ip' => '10'}, # conteudo dentro de matrizes
  #'m2' => {'memory' => '512', 'cpus' => 1, 'ip' => '20'},
  #'m3' => {'memory' => '512', 'cpus' => 1, 'ip' => '30'}
  'ansible' => {'memory' => '1024', 'cpus' => 2, 'ip' => '100'}
}

Vagrant.configure('2') do |config|

  config.vm.box = 'bento/ubuntu-18.04'
  config.vm.box_check_update = false
  config.vm.synced_folder "./ansible", "/ansible"
  
  vms.each do |name, conf|
    config.vm.define "#{name}" do |m|
      m.vm.hostname = "#{name}.fabiofernandes.local"
      m.vm.network 'private_network', ip: "172.27.11.#{conf['ip']}"
      m.vm.provider 'virtualbox' do |vb| # VirtualBox
        vb.name = "#{name}"
        vb.memory = conf['memory']
        vb.cpus = conf['cpus']
        vb.customize ["modifyvm", :id, "--groups", "/auto"]
      end  
      
      m.vm.provision "shell", inline: <<-'SHELL'
        apt-get update
        apt-get install -y curl nano ansible
	      mkdir -p /root/.ssh
        cp /vagrant/ansible/key/id_rsa* /root/.ssh
        chmod 400 /root/.ssh/id_rsa*
        cp /vagrant/ansible/key/id_rsa.pub /root/.ssh/authorized_keys
        #mkdir -p /root/ansible     
        #cp -r /vagrant/ansible/* /root/ansible  #COPIANDO PASTA VAGRANT PARA VM
        ansible-playbook --connection=local /ansible/playbook.yml
      SHELL

      m.vm.provision "shell", inline: <<-EOF
      HOSTS=$(head -n7 /etc/hosts)
      echo -e "$HOSTS" > /etc/hosts
      echo '172.27.11.100 ansible.fabiofernandes.local' >> /etc/hosts           
      echo '172.27.11.10 m1.fabiofernandes.local' >> /etc/hosts
      echo '172.27.11.20 m2.fabiofernandes.local' >> /etc/hosts
      echo '172.27.11.30 m3.fabiofernandes.local' >> /etc/hosts
      EOF

    end

  end

end 