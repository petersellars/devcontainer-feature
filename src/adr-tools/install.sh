#!/bin/bash

set -e

# Checks if packages are installed and installs them if not
check_packages() {
	if ! dpkg -s "$@" >/dev/null 2>&1; then
		if [ "$(find /var/lib/apt/lists/* | wc -l)" = "0" ]; then
			echo "Running apt-get update..."
			apt-get update -y
		fi
		apt-get -y install --no-install-recommends "$@"
	fi
}

check_packages curl ca-certificates

curl -LJO https://github.com/npryce/adr-tools/archive/3.0.0.tar.gz && \
  mkdir /usr/local/bin/adr && \
  tar -xzvf adr-tools-3.0.0.tar.gz -C /usr/local/bin/adr --strip-components=1 && \
  echo "export PATH=$PATH:/usr/local/bin/adr/src" >> ~/.bashrc && \
  echo "source /usr/local/bin/adr/autocomplete/adr" >> ~/.bashrc

# Clean up
rm -rf /var/lib/apt/lists/*
    
echo 'Done!'
