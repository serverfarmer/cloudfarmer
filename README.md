Cloud Farmer is a set of simple tools to deploy Server Farmer on new cloud instance
in unattended mode (without user interaction during the whole setup).

Currently it supports only Amazon EC2 service and their flavor of Ubuntu 14.04 LTS,
however there are plans to add support for the below cloud service providers:

- Beyond e24cloud.com
- Google Cloud
- IBM SoftLayer
- Joyent
- Microsoft Azure
- Oktawave
- Rackspace Cloud
- Unizeto UniCloud
- VMware vCloud Air

**Example usage**

1. Installation:

```
git clone https://github.com/serverfarmer/cloudfarmer /opt/cloud
```

Now edit files in /opt/cloud/credentials directory. Then, if you want to create
new Amazon EC2 instances automatically, you have to install "awscli" AWS command
line client:

```
apt-get install python-pip
pip install awscli
aws configure
```

Note that if you only want to work with instances created manually using AWS
browser-based console, you don't need to install "awscli".

2. Creating new cloud server instance:

```
/opt/cloud/providers/ec2/ec2-create-simple.sh aws-test-key1 m4.xlarge
```

3. Provisioning new instance:

```
/opt/cloud/deploy.sh ec2-54-123-45-67.compute-1.amazonaws.com /path/aws-test-key1.pem
```

**Customization**

All user-related data are contained inside /opt/cloud/credentials directory.
