initailSetupScript=~/inital-setup.sh
setupScript=~/repos/local-provision/scripts/setup.sh
cat > ${initailSetupScript} <<'EOF'
#!/bin/bash

localSetupRepo="git@bitbucket.org:seemywingz/local-provision.git"
repoDir=~/repos

exitOnError () {
  exitCode=$1
  errorMessage=$2
  [[ $1 -gt 0 ]] && (echo "Error: ${2}" && exit 1) ||:
}

isInstalled () {
  app=$1
  [[ -x "$(command -v ${app})" ]] && true || false
}

if ! isInstalled git; then
  msg="Installing Git"
  echo ${msg}
  sudo apt install git -y
  exitOnError $? ${msg}
fi

cd
mkdir -p ${repoDir}
cd ${repoDir}
if [[ -d "local-provision" ]];then
  cd local-provision
  git pull
else
  git clone ${localSetupRepo}
fi
EOF
chmod +x ${initailSetupScript}
${initailSetupScript}
rm ${initailSetupScript}
$setupScript