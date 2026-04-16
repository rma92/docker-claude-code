# Docker/Podman Debian Claude Code

Makes a docker container for running Claude Code, so you can do dangerously-skip-permissions relatively safely.

Usage:
```
# On your server:
chmod +x launch-debian.sh install-claude-code.sh enter.sh

# 1. Start the container
./launch-debian.sh

# 2. Copy the installer in and run it
podman cp install-claude-code.sh claude-code-dev:/tmp/
podman exec -it claude-code-dev bash /tmp/install-claude-code.sh

# 2a. Optinally, install gh to auth your github easily
podman cp install-gh.sh claude-code-dev:/tmp/
podman exec -it claude-code-dev bash /tmp/install-gh.sh

# 3. Shell in whenever you want
./enter.sh

# addtional commands
chmod +x launch-debian.sh start-debian.sh stop-debian.sh mount-home.sh unmount-home.sh destroy-debian.sh

# Build and create the container
#./launch-debian.sh                  # default name
#./launch-debian.sh my-container     # custom name

# Turn on the container if it's stopped.
#./start-debian.sh
#./start-debian.sh my-container

# Stop the container
#./stop-debian.sh
#./stop-debian.sh my-container

# Destroy the container
#./destroy-debian.sh
#./destroy-debian.sh my-container

# Mount or unmount the home directory
#./mount-home.sh                     # adds $HOME mount, recreates container
#./unmount-home.sh                   # removes $HOME mount, recreates container
```
Or the manual enter command:
```
podman exec -it "claude-code-dev" bash -login
```

# Add a limited user, and install claude code:
```
podman exec "claude-code-dev" useradd -m -s /bin/bash user
podman cp install-claude-code-user.sh claude-code-dev:/tmp/
podman exec claude-code-dev chmod a+rx /tmp/install-claude-code-user.sh
podman exec -it -u user claude-code-dev bash /tmp/install-claude-code-user.sh
```
To use it:
```
podman exec -it -u user claude-code-dev bash --login
```
And
```
claude auth login
```
