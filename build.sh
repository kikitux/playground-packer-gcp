uname -a
id
df -Ph
env

pushd /home/packer/workspace
ls -al 
packer version
packer validate template.json
set -e
packer build template.json
ls -al 
