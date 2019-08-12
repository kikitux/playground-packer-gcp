set -e
pushd /home/packer/workspace
packer validate bionic64.json
time packer build bionic64.json
packer validate bionic64-nginx.json
time packer build bionic64-nginx.json
rm -fr  packer_cache/ output-*/
