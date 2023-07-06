 export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Check if nvm is installed
if [[ ! -d "$NVM_DIR" ]]; then
    echo "nvm not found, installing..."

    # Install NVM
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash

    # Load NVM
    export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

else
    echo "NVM is already installed"
fi

nvm use node

# Get macOS version
macos_version=$(sw_vers -productVersion)

# Extract major version number
major_version=$(echo "$macos_version" | awk -F '.' '{print $2}')

# Check if major version is less than 14 (Mojave)
if [[ $major_version -lt 14 ]]; then
    echo "macOS version is less than Mojave"
    nvm install 16.20.1
    nvm use 16.20.1
else
    echo "macOS version is Mojave or newer"
    NODE_MAJOR_VERSION=20
    CURRENT_NODE_VERSION=$(node -v 2>/dev/null)
    if [[ $CURRENT_NODE_VERSION == v${NODE_MAJOR_VERSION}.* ]]; then
        echo "Node.js major version $NODE_MAJOR_VERSION is already installed"
    else
        echo "Installing the latest version of Node.js"
        nvm install node
    fi
fi

