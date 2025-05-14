set -e

REPO_NAME="wsl-setup"
REPO_LOCAL_LOCATION="${HOME}/code/${REPO_NAME}"

echo -e "\nUpdating System..."

sudo apt update -y
sudo apt upgrade -y

echo -e "\nCloning ${REPO_NAME}..."
git clone https://github.com/kyedavey/${REPO_NAME}.git ${REPO_LOCAL_LOCATION}

echo -e "\nInstallation starting..."
for installer in ${REPO_LOCAL_LOCATION}/install/*.sh; do source $installer; done

echo -e "\nInstallation complete"