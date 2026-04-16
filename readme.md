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
```
Or the manual enter command:
```
podman exec -it "claude-code-dev" bash -login
```
