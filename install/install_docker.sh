#!/usr/bin/env bash

readonly DOCKER_KEYRING="/etc/apt/keyrings/docker.asc"
readonly DOCKER_SOURCE="/etc/apt/sources.list.d/docker.sources"

log_info() {
  printf '[INFO] %s\n' "$*"
}

log_warn() {
  printf '[WARN] %s\n' "$*" >&2
}

log_error() {
  printf '[ERROR] %s\n' "$*" >&2
}

require_command() {
  local cmd="$1"

  if ! command -v "$cmd" >/dev/null 2>&1; then
    log_error "Required command not found: ${cmd}"
    exit 1
  fi
}

require_root_tools() {
  require_command sudo
  require_command apt-get
  require_command dpkg
  require_command curl
}

detect_distribution() {
  if [[ ! -r /etc/os-release ]]; then
    log_error "/etc/os-release not found"
    exit 1
  fi

  # shellcheck disable=SC1091
  source /etc/os-release

  case "$ID" in
  ubuntu)
    readonly DOCKER_DIST="ubuntu"
    readonly DOCKER_CODENAME="${UBUNTU_CODENAME:-$VERSION_CODENAME}"
    ;;
  debian)
    readonly DOCKER_DIST="debian"
    readonly DOCKER_CODENAME="$VERSION_CODENAME"
    ;;
  *)
    log_error "Unsupported distribution: ${ID}"
    log_error "This script supports Ubuntu and Debian only."
    exit 1
    ;;
  esac

  if [[ -z "${DOCKER_CODENAME}" ]]; then
    log_error "Unable to determine distribution codename."
    exit 1
  fi

  readonly ARCHITECTURE="$(dpkg --print-architecture)"
}

remove_conflicting_packages() {
  log_info "Removing conflicting Docker packages"

  local packages=(
    docker.io
    docker-doc
    docker-compose
    docker-compose-v2
    podman-docker
    containerd
    runc
  )

  sudo apt-get remove -y "${packages[@]}" >/dev/null 2>&1 || true
}

install_prerequisites() {
  log_info "Installing prerequisites"

  sudo apt-get update

  sudo apt-get install -y \
    ca-certificates \
    curl
}

install_repository_key() {
  log_info "Installing Docker repository signing key"

  sudo install -m 0755 -d /etc/apt/keyrings

  sudo curl -fsSL \
    "https://download.docker.com/linux/${DOCKER_DIST}/gpg" \
    -o "$DOCKER_KEYRING"

  sudo chmod a+r "$DOCKER_KEYRING"
}

configure_repository() {
  log_info "Configuring Docker APT repository"

  sudo tee "$DOCKER_SOURCE" >/dev/null <<EOF
Types: deb
URIs: https://download.docker.com/linux/${DOCKER_DIST}
Suites: ${DOCKER_CODENAME}
Components: stable
Architectures: ${ARCHITECTURE}
Signed-By: ${DOCKER_KEYRING}
EOF
}

install_docker() {
  log_info "Installing Docker Engine"

  sudo apt-get update

  sudo apt-get install -y \
    docker-ce \
    docker-ce-cli \
    containerd.io \
    docker-buildx-plugin \
    docker-compose-plugin
}

enable_services() {
  log_info "Enabling Docker services"

  sudo systemctl enable --now containerd
  sudo systemctl enable --now docker
}

configure_user() {
  if id -nG "$USER" | grep -qw docker; then
    return
  fi

  log_info "Adding ${USER} to the docker group"

  sudo usermod -aG docker "$USER"

  log_warn "Log out and back in (or run 'newgrp docker') before using Docker without sudo."
}

verify_installation() {
  log_info "Verifying Docker installation"

  docker --version
  docker compose version
  docker buildx version
}

show_versions() {
  log_info "Installed component versions"

  docker --version
  docker compose version
  docker buildx version
  containerd --version
}

main() {
  require_root_tools
  detect_distribution

  remove_conflicting_packages
  install_prerequisites
  install_repository_key
  configure_repository
  install_docker
  enable_services
  configure_user
  verify_installation

  log_info "Docker setup completed successfully"
  show_versions
}

main "$@"