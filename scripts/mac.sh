initailSetupScript=~/redt-inital-setup.sh
cat > ${initailSetupScript} <<'EOF'
#!/bin/bash

localSetupRepo="git@github.com:seemywingz/local-provision.git"

exitOnError () {
  exitCode=$1
  errorMessage=$2
  [[ $1 -gt 0 ]] && (echo "Error: ${2}" && exit 1) ||:
}

isInstalled () {
  app=$1
  [[ -x "$(command -v ${app})" ]] && true || false
}

if ! isInstalled brew; then
  msg="Installing Homebrew"
  echo ${msg}
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  exitOnError $? ${msg}
  brew update
  brew doctor
  brew prune
fi

if ! isInstalled git; then
  msg="Installing Git"
  echo ${msg}
  brew install git
  exitOnError $? ${msg}
fi

cd
mkdir -p git
cd git
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
