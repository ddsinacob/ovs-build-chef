#
# Cookbook:: openvswitch
# Recipe:: install
#
# Copyright:: 2017, Dilip Debsingha, All Rights Reserved.

['gcc','make','util-linux','python-devel','python-six','openssl-devel','kernel-devel','graphviz','kernel-debug-devel','autoconf','automake','rpm-build','rpmdevtools','redhat-rpm-config','libtool','checkpolicy','selinux-policy-devel'].each do |pkgs|
  package pkgs do
    action :install
  end
end
