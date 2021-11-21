## Automated ELK Stack Deployment

The files in this repository were used to configure the network depicted below.

![](Diagrams\Azure_Image_Diagram.PNG)


These files have been tested and used to generate a live ELK deployment on Azure. They can be used to either recreate the entire deployment pictured above. Alternatively, select portions of the YAML file may be used to install only certain pieces of it, such as Filebeat.

  - [Elk-server YAML Playbook](Ansible\elk-server-playbook.yml)
  - [Filebeat YAML Playbook](Ansible\filebeat-playbook.yml)
  - [Metricbeat YAML Playbook](Ansible\metricbeat.yml)

This document contains the following details:
- Description of the Topology
- Access Policies
- ELK Configuration
  - Beats in Use
  - Machines Being Monitored
- How to Use the Ansible Build


### Description of the Topology

The main purpose of this network is to expose a load-balanced and monitored instance of DVWA, the D*mn Vulnerable Web Application.

Load balancing ensures that the application will be highly efficient, in addition to monitoring traffic to the network.
- Load balancing contains an important function known as the off-loading function which is rather effective in defending against distributed denial-of-service (DDoS) attacks. The aspects of security that load balancers will protect include availability, web-traffic, web-security. 

- The jump-box is advantageous because it serves as an additional security measure since it is a secure computer in which all admins will first connect to before performing any administrative task. It can also be utilized as a point to connect to other servers or network environments. It also presents the advantages of automation, security, network segmentation, and access control. 

Integrating an ELK server allows users to easily monitor the vulnerable VMs for changes to the data and system logs.
- Filebeat allows a user to forward and centralize log data. These log files and locations are monitored which are then forwareded to either Elasticsearch or Logstash for indexing. 

- Metricbeat allows administrators to periodically collect metrics from the operating system and the metrics from various services running on the server. Metricbeat will collect statistics and ship them to a specified output such as Elasticsearch or Logstash.

The configuration details of each machine may be found below.

| Name          | Function          | IP Address     | Operating System |
|---------------|-------------------|----------------|------------------|
| Jump Box      | Gateway           | 10.0.0.1       | Linux            |
| Web-1         | Web Server        | 10.1.2.2       | Linux            |
| Web-2         | Web Server        | 10.1.2.3       | Linux            |
| Load Balancer | Front-End IP addr | 52.149.222.111 | Linux            |
| Elk           | Elk Server        | 10.0.2.2       | Linux            |
| Workstation   | Access Control    | 74.85.2.2      | Windows          |

### Access Policies

The machines on the internal network are not exposed to the public Internet. 

Only the Elk Server machine can accept connections from the Internet. Access to this machine is only allowed from the following IP addresses:
- Workstation-Home Public IP address TCP port 5601

Machines within the network can only be accessed by Workstation-Home and JumpBox-Provisioner.
- JumpBox-Provisioner: 10.1.2.7 SSH port 22
- Workstation-Home: TCP port 5601

A summary of the access policies in place can be found in the table below.

| Name          | Publicly Accessible | Allowed IP Addresses              |
|---------------|---------------------|-----------------------------------|
| Jump Box      | No                  | 10.0.0.1 10.0.0.2                 |
| Web-1         | No                  | 10.1.2.2 on SSH                   |
| Web-2         | No                  | 10.1.2.3 on SSH                   |
| Elk Server    | No                  | Workstation Public IP on TCP 5601 |   
| Load Balancer | No                  | Workstation Public IP on HTTP 80  |

### Elk Configuration

Ansible was used to automate configuration of the ELK machine. No configuration was performed manually, which is advantageous because it helps with the representation of Infrastructure as Code (IAC). This involves provisioning and management of computing infrastructure and related configuration and it is also fast and performs all functions over SSH without requiring an agent installation. Making it secure, efficient, and reliable. 

The playbook implements the following tasks:
- Install docker.io
- Install python3-pip
- Install Docker module
- Increase virtual memory
- Download and launch a docker elk container
- Enable service docker on boot

The following screenshot displays the result of running `docker ps` after successfully configuring the ELK instance.

![](Diagrams/elk_server_image.png)

### Target Machines & Beats
This ELK server is configured to monitor the following machines:
- Web-1: 10.1.2.2
- Web-2: 10.1.2.3

We have installed the following Beats on these machines:
- Filebeat
- Metricbeat

These Beats allow us to collect the following information from each machine:
- Filebeat
  + *log events*
- Metricbeat
  + *metrics and system statistics*

### Using the Playbook
In order to use the playbook, you will need to have an Ansible control node already configured. Assuming you have such a control node provisioned: 

SSH into the control node and follow the steps below:
- To SSH into the Jumpbox, use the following commands
  + ```ssh admin@20.114.10.10```
  + ```sudo docker start <container_name>```
  + ```sudo docker exec -ti <container_name> /bin/bash```
- Navigate to the ```/etc/ansible``` directory
- Copy the ```elk-server-playbook.yml``` file to the ```/etc/ansible``` directory.
- Update the ```filebeat-config.yml``` file to include the Elk Server's IP address
  + ```nano filebeat-config.yml```
  + **CTRL + W** > Type: *setup.kibana*
  + Un-comment that line and the *host* line by removing the *#*. 
  + Insert the Elk-Server's private IP address in the *" "* marks.
  + ```
      setup.kibana:up.kibana: 
      host: "10.0.2.2:5601"
    ```
- Run the playbook with the command ```ansible-playbook filebeat-playbook.yml```
  + Navigate to [http://[Elk-server-PublicIP]:5601/app/kibana]()
  + Navigate to **Kibana > Logs: Add log data > System logs > Module Status> Check data** to check that the installation worked as expected.
- Update the ```metricbeat-config.yml``` file to include the Elk Server's IP address
  + ```nano metricbeat-config.yml```
  + **CTRL + W** > Type: *setup.kibana*
  + Un-comment that line and the *host* line by removing the *#*. 
  + Insert the Elk-Server's private IP address in the *" "* marks.
  + ```
      setup.kibana:up.kibana: 
      host: "10.0.2.2:5601"
    ```
- Run the playbook with the command ```ansible-playbook metricbeat.yml```
  + Navigate to [http://[Elk-server-PublicIP]:5601/app/kibana]()
  + Navigate to **Kibana > Add Metric Data > Docker Metrics > Module Status** to check that the installation worked as expected.

