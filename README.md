# ovs-build-chef


Upload the cookbook to Chef Server :  knife cookbook upload openvswitch

Add To Run list :   knife node run_list add chef-node1 \'recipe[openvswitch::default]\''

On Chef Client/Node Run below command to run :   chef-client
