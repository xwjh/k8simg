#!/bin/bash

cd `dirname $0`

kubeadm config images list > ../k8s.gcr.io/kcil.txt
cat kcil.txt | awk -F '[/:]' '{print "mkdir "$2" > /dev/null 2>&1; echo -e \"from "$0"\" > "$2"/Dockerfile"}'|bash

cd ..
TAG=$(kubeadm version -ojson|jq -r .clientVersion.gitVersion)
git add -A
git commit -m $TAG
git push origin main

git tag -a $TAG -m $TAG
git push origin --tags $TAG

