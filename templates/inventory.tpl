control_servers:
    hosts:
        %{ for index, ip in home_app ~}

        home-${index}:
            ansible_host: ${ip}
            ansible_user: ec2-user

        %{ endfor ~}
   
   worker_servers:
    hosts:
        %{ for index, ip in home_app ~}

        home-${index}:
            ansible_host: ${ip}
            ansible_user: ec2-user

        %{ endfor ~}
