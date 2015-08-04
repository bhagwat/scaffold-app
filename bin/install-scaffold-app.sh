#!/bin/bash
#
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.
#

# Global variables
SCAFFOLD_APP_DIR="$HOME/.scaffold-app"

# Local variables
scaffold_app_bashrc="${HOME}/.bashrc"

scaffold_app_init_snippet=$( cat << EOF
export SCAFFOLD_APP_DIR="\$HOME/.scaffold-app"; export PATH=\$PATH:\$SCAFFOLD_APP_DIR/bin
EOF
)
# Sanity checks

echo "Looking for a previous installation of scaffold-app..."
if [ -d "${SCAFFOLD_APP_DIR}" ]; then
	echo "scaffold-app found."
	echo ""
	echo "======================================================================================================"
	echo " You already have scaffold-app installed."
	echo " scaffold-app was found at:"
	echo ""
	echo "    ${SCAFFOLD_APP_DIR}"
	echo ""
	echo " Upgrading.... "
	echo ""
	cd $SCAFFOLD_APP_DIR
	git pull origin master
	cd -
	echo "Done upgrading"
	echo "======================================================================================================"
	echo ""
	exit 0
fi

echo "Looking for Git version control..."
if [ -z $(which git) ]; then
	echo ""
	echo "======================================================================================================"
	echo " Please install git on your system using your favourite package manager."
	echo ""
	echo " Scaffold-app uses git to maintain templates and scripts"
	echo ""
	echo " Restart after installing git."
	echo "======================================================================================================"
	echo ""
	exit 1
fi

echo "Looking for sed..."
if [ -z $(which sed) ]; then
	echo ""
	echo "======================================================================================================"
	echo " Please install sed on your system using your favourite package manager."
	echo ""
	echo " Scaffold-app uses sed extensively."
	echo ""
	echo " Restart after installing sed."
	echo "======================================================================================================"
	echo ""
	exit 2
fi


echo "Installing Scaffold-app scripts..."

# Create directory structure

echo "Create distribution directories..."
mkdir -p "${SCAFFOLD_APP_DIR}"
git clone git@gitlab.intelligrape.net:bhagwat/grails-app-generator.git "${SCAFFOLD_APP_DIR}"

echo "Configure PATH for Scaffold-app shell scripts"
if [ ! -f "${scaffold_app_bashrc}" ]; then
	echo "#!/bin/bash" > "${scaffold_app_bashrc}"
	echo "${scaffold_app_init_snippet}" >> "${scaffold_app_bashrc}"
	echo "Created and initialised ${scaffold_app_bashrc}"
else
	if [[ -z `grep 'SCAFFOLD_APP_DIR' "${scaffold_app_bashrc}"` ]]; then
		echo -e "\n${scaffold_app_init_snippet}" >> "${scaffold_app_bashrc}"
		echo "Updated existing ${scaffold_app_bashrc}"
	fi
fi

echo -e "\nAll done! Cheers!\n"

echo "Make sure or add these exports in .bashrc or .profile file and open a new terminal"
echo $scaffold_app_init_snippet
echo -e "\nEnjoy!!!"