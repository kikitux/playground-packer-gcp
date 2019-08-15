#!/usr/bin/env

declare -A build
build["nginx"]="nginx"
build["redis"]="redis-server redis-tools"
build["mysql"]="mysql-server"
build["php"]="nginx php php-fpm"
build["docker"]="docker.io"
build["jdk"]="default-jdk"
build["jre"]="default-jre"
build["dev"]="git curl wget build-essential"

cat <<EOF
timeout: 9000s
steps:
EOF

  #waitFor:
  #- BUILD-BIONIC64-${b^^}

for b in ${!build[*]}; do 
cat <<EOF
- name: gcr.io/\$PROJECT_ID/remote-builder
  id: BUILD-BIONIC64-${b^^}
  timeout: 3000s
  waitFor: ["-"]
  env:
    - INSTANCE_ARGS=--image nestedvbox --machine-type=n1-standard-2 --preemptible --boot-disk-type=pd-ssd --boot-disk-size=50GB
    - ZONE=europe-west4-a
    - USERNAME=packer
    - COMMAND=packer build -var "build_name=bionic64-${b}" -var "packages=${build["$b"]}" -var "wd=/home/packer/workspace" /home/packer/workspace/bionic64-vagrant.json
- name: gcr.io/\$PROJECT_ID/vagrant
  id: PUBLISH-BIONIC64-${b^^}
  timeout: 3000s
  env:
    - ATLAS_TOKEN=\${_TOKEN}
  args:
  - 'cloud'
  - 'publish'
  - 'kikitux/bionic64-${b}'
  - '\$TAG_NAME'
  - 'virtualbox'
  - 'bionic64-${b}/package.box'
  - '--release'
  - '--force'
EOF
done

cat <<EOF
substitutions:
  _TOKEN: TOKEN # default value
EOF
