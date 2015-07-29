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
GAG_DIR="$HOME/.grails-app-generator"

# Local variables
gag_bashrc="${HOME}/.bashrc"

gag_init_snippet=$( cat << EOF

export GAG_DIR="\$HOME/.grails-app-generator"
export PATH=$GAG_DIR/bin:$PATH
EOF
)
# Sanity checks

echo "Looking for a previous installation of GAG..."
if [ -d "${GAG_DIR}" ]; then
	echo "GAG found."
	echo ""
	echo "======================================================================================================"
	echo " You already have GAG installed."
	echo " GAG was found at:"
	echo ""
	echo "    ${GAG_DIR}"
	echo ""
	echo " Upgrading.... "
	echo ""
	cd $GAG_DIR;
	git pull origin master
	cd -
	echo "Done upgrading"
	echo "======================================================================================================"
	echo ""
	exit 0
fi


echo "Looking for sed..."
if [ -z $(which sed) ]; then
	echo "Not found."
	echo ""
	echo "======================================================================================================"
	echo " Please install sed on your system using your favourite package manager."
	echo ""
	echo " GAG uses sed extensively."
	echo ""
	echo " Restart after installing sed."
	echo "======================================================================================================"
	echo ""
	exit 0
fi


echo "Installing GAG scripts..."


# Create directory structure

echo "Create distribution directories..."
mkdir -p "${GAG_DIR}"
git clone git@gitlab.intelligrape.net:bhagwat/grails-app-generator.git "${GAG_DIR}"

if [ ! -f "${gag_bashrc}" ]; then
	echo "#!/bin/bash" > "${gag_bashrc}"
	echo "${gag_init_snippet}" >> "${gag_bashrc}"
	echo "Created and initialised ${gag_bashrc}"
else
	if [[ -z `grep 'GAG_DIR' "${gag_bashrc}"` ]]; then
		echo -e "\n${gag_init_snippet}" >> "${gag_bashrc}"
		echo "Updated existing ${gag_bashrc}"
	fi
fi

echo -e "\n\n\nAll done!\n\n"

echo "Please open a new terminal"
echo "Enjoy!!!"