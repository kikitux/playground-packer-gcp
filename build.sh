pushd /home/packer/workspace
packer validate template.json
set -e
packer build template.json
set +e
rm -fr  packer_cache/
