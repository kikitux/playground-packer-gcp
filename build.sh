set -e
time packer -var "wd=/home/packer/workspace" validate bionic64.json
time packer -var "wd=/home/packer/workspace" build bionic64.json
time packer -var "wd=/home/packer/workspace" validate bionic64-nginx.json
time packer -var "wd=/home/packer/workspace" build bionic64-nginx.json
rm -fr  packer_cache/ output-*/
