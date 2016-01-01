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

git clone https://github.com/serverfarmer/cloudfarmer /opt/cloud

/opt/cloud/deploy.sh ec2-54-123-45-67.compute-1.amazonaws.com /path/aws-test.pem

**Customization**

All user-related data are contained inside /opt/cloud/credentials directory.
