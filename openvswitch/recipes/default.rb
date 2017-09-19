#
# Cookbook:: openvswitch
# Recipe:: default
#
# Copyright:: 2017, Dilip Debsingha, All Rights Reserved.

include_recipe 'openvswitch::install'

execute 'rpmdev-setuptree' do
	cwd "/root/"
	user 'root'
	command 'rpmdev-setuptree'
end


remote_file "/root/#{node['openvswitch']['openvswitch_tar']}" do
  source "#{node['openvswitch']['openvswitch_releases_url']}/#{node['openvswitch']['openvswitch_tar']}"
	not_if { ::File.exists?("/root/#{node['openvswitch']['openvswitch_tar']}")}
end

execute "Extract OpenVSwitch Tar" do
  cwd "/root/"
	user 'root'
  command "tar -xvf #{node['openvswitch']['openvswitch_tar']}"
end

execute "Copy tar file to RPMSOURCE" do
	user 'root'
  command "cp /root/#{node['openvswitch']['openvswitch_tar']} /root/rpmbuild/SOURCES/"
end

execute "RPMBUILD OpenVSwitch-kmod-centos" do
	user 'root'
  cwd "/root/#{node['openvswitch']['openvswitch_version']}/"
  command "rpmbuild -bb -D \'kversion #{node['kernel']['release']}\' rhel/openvswitch.spec"
	only_if { ::Dir.empty?('/root/rpmbuild/RPMS/x86_64/')}
end

execute "Install OpenVSwitch on CentOS7" do
	user 'root'
	command "yum -y localinstall /root/rpmbuild/RPMS/x86_64/openvswitch*"
	live_stream true
end


service 'openvswitch' do
	action [:enable,:start]
end


execute "OpenVSwitch DB Schema Version" do
	command "ovs-vsctl -V"
	live_stream true
end

execute "OpenVSwitch is Running and Version" do
	command "ovs-vsctl show"
	live_stream true
end
