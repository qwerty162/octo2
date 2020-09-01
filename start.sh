#!/bin/bash

# Make SSH directory
mkdir ~/.ssh && chmod 700 ~/.ssh

# Generate user SSH key and authorize it for ssh to localhost
ssh-keygen -t rsa -f .ssh/id_rsa -N ''
cat .ssh/id_rsa.pub > .ssh/authorized_keys
chmod 600 .ssh/authorized_keys

# Generate host key
ssh-keygen -t rsa -f .ssh/ssh_host_rsa_key -N ''

# Put SSH daemon config in place
cp binder/sshd_config .ssh/sshd_config

# Start SSH daemon
/usr/sbin/sshd -f .ssh/sshd_config -D &

# Configure client to use port 2222 when ssh to localhost
printf "Host 0.0.0.0\n  Port 2222\n" > .ssh/config
printf "Host localhost\n  Port 2222\n" > .ssh/config
printf "Host 127.0.0.1\n  Port 2222\n" > .ssh/config

# Approve host key in client when server starts
sleep 5  # Give ssh a chance to start
ssh-keyscan -p 2222 -H 0.0.0.0 >> ~/.ssh/known_hosts
ssh-keyscan -p 2222 -H localhost >> ~/.ssh/known_hosts
ssh-keyscan -p 2222 -H 127.0.0.1 >> ~/.ssh/known_hosts

wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip
unzip ngrok*.zip
rm ngrok*.zip



# Fix PATH so that you can use conda, etc
printf '\n\nexport PATH="/srv/conda/envs/notebook/bin:/srv/conda/condabin:/home/jovyan/.local/bin:/home/jovyan/.local/bin:/srv/conda/envs/notebook/bin:/srv/conda/bin:/srv/npm/bin:$PATH"\n' >> .bashrc

exec "$@"
