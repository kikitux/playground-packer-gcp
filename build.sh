pushd /home/packer/workspace
packer validate bionic64.json
set -e
packer build bionic64.json
set +e
rm -fr  packer_cache/
