Cloud Farmer is a set of simple tools to deploy Server Farmer on new cloud instance
in unattended mode (without user interaction during the whole setup).

Currently it supports:

- Amazon EC2 service with their flavor of Ubuntu (tested with 14.04 LTS and 16.04
LTS, but expected to work without problems with any recent Ubuntu version)
- Rackspace Cloud service with Ubuntu 14.04 LTS or 16.04 LTS
- any other cloud service based on OpenStack (including public, private and hybrid
 clouds) with any recent Debian/Ubuntu version

There are plans to add support for the below cloud service providers:

- Beyond e24cloud.com
- Google Cloud
- IBM SoftLayer
- Joyent
- Microsoft Azure
- Oktawave
- VMware vCloud Air

## Example usage

### Installation

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

### Creating new cloud instance

Note that creating instances is supported only for Amazon EC2.

```
/opt/cloud/providers/ec2/create-simple.sh aws-test-key1 m4.xlarge
```

### Provisioning new cloud instance

```
/opt/cloud/deploy.sh ec2-54-123-45-67.compute-1.amazonaws.com /path/aws-test-key1.pem

/opt/cloud/deploy.sh 162.209.99.47 /path/rackspace-test-key3.pem
```

## Customization

All user-related data are contained inside /opt/cloud/credentials directory.
