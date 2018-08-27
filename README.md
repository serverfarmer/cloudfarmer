Cloud Farmer is a multi-cloud server deployment tool, based on Server Farmer. It allows full lifecycle, fully automatic management of Linux-based cloud instances, supporting all important cloud computing vendors:

- Alibaba Cloud
- Amazon Web Services
- Beyond e24cloud.com
- Google Cloud Platform
- Hetzner Cloud
- Microsoft Azure
- Rackspace Cloud
- any cloud service based on OpenStack (including public, private and hybrid clouds)

All supported providers are well tested with Ubuntu 14.04 LTS, 16.04 LTS and 18.04 LTS, and also are expected to work without major problems with any recent Debian or Ubuntu version).


## Operations reference

```
/opt/cloud/api
|
├── account
|   ├── list-all.sh       # list all configured accounts for all providers
|   ├── list.sh           # list all configured accounts for given provider, eg. ec2
|   ├── setup.sh          # configure new account
|   └── test.sh           # test if configured account is still valid (eg. from crontab)
|
├── image
|   ├── list.sh           # list available Linux image names (in provider-specific format)
|   └── get-ubuntu.sh     # get image name of latest Ubuntu LTS version supported by given provider
|
├── instance
|   ├── list.sh           # list created instances (also created manually)
|   ├── create.sh         # create new cloud instance
|   ├── delete.sh         # delete instance
|   └── provision.sh      # configure new instance (works also with all other servers)
|
├── instance-type
|   └── list.sh           # list instance types (in provider-specific format, eg. m5.2xlarge)
|
├── key
|   ├── list.sh           # list ssh keys uploaded to given provider/account
|   ├── create.sh         # create and upload new ssh key pair
|   └── get-path.sh       # get full path for given ssh key name
|
└── region
    ├── list-available.sh # list all regions available for given provider/account
    └── get-configured.sh # get primary region associated with given provider/account
```


## Example usage

### Installation

Cloud Farmer requires Server Farmer installed, with configured roles farm-manager, farm-provisioning, and preferably also backup-collector.

```
git clone https://github.com/serverfarmer/cloudfarmer /opt/cloud
/opt/cloud/install.sh
/opt/cloud/api/account/setup.sh yourprovider youraccount
```

where:
- `yourprovider` is one of: `alibaba`, `azure`, `e24`, `ec2`, `gce`, `hetzner` or `rackspace`
- `youraccount` is the name of your configured account (or region name in case of `azure`)

After you finished the initial setup, you can always manually edit files inside `/etc/local/.cloud` directory to make sure that your provider is properly configured.

Additional notes:

1. `azure` and `gce` support having only one account configured at the same time, however `azure` allows operating on each region as separate pseudo-account.

2. For `azure` and `gce`, the setup process needs browser interaction.

3. For `rackspace` provider, the configuration process will ask you for a Profile Name. Cloud Farmer works only with named profiles, not with the default nameless profile, so you have to type some non-empty name there, even if you use only one Rackspace account.

4. `alibaba` provider doesn't support creating and deleting instances yet, and listing existing instances works only in full details mode.


### Creating new cloud instance

```
/opt/cloud/api/instance/create.sh ec2 prod_account prod_key1 m5.2xlarge
/opt/cloud/api/instance/create.sh azure eastus testkey2 Standard_A2
```

Hostname of the new instance will be written on console, as soon as it's ready for provisioning.

### Provisioning Server Farmer to the new cloud instance

```
/opt/cloud/api/instance/provision.sh ec2 ec2-54-123-45-67.compute-1.amazonaws.com prod_key1 myprofile
/opt/cloud/api/instance/provision.sh azure testkey2-5c82.eastus.cloudapp.azure.com testkey2 myprofile
```

### Listing all configured accounts and cloud instances

```
/opt/cloud/api/account/list-all.sh
```

## How to contribute

We are welcome to contributions of any kind: bug fixes, added code comments,
support for new operating system versions, cloud platforms etc.

If you want to contribute:
- fork this repository and clone it to your machine
- create a feature branch and do the change inside it
- push your feature branch to github and create a pull request

## License

|                      |                                          |
|:---------------------|:-----------------------------------------|
| **Author:**          | Tomasz Klim (<opensource@tomaszklim.pl>) |
| **Copyright:**       | Copyright 2015-2018 Tomasz Klim          |
| **License:**         | MIT                                      |

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
