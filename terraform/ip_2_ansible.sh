 #!/bin/bash
ip_project=`awk '{print $2}' project_public_ip.txt`
ip_jenkins=`awk '{print $4}' project_public_ip.txt`
echo -e "[my_all_servers]\n$ip_project\n$ip_jenkins\n\n[project_servers]\n$ip_project\n\n[jenkins_server]\n$ip_jenkins" > ../ansible/hosts.txt