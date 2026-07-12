#!/usr/bin/env bash
set -Eeuo pipefail

readonly KIND_VERSION="${KIND_VERSION:-v0.32.0}"
readonly INSTALL_DIR="${INSTALL_DIR:-/usr/local/bin}"
readonly INSTALL_PATH="${INSTALL_DIR}/kind"

command -v curl >/dev/null 2>&1 || {
    echo "Error: curl is required." >&2
    exit 1
}

case "$(uname -s)" in
    Linux)
        os="linux"
        ;;
    *)
        echo "Error: this script supports Linux only." >&2
        exit 1
        ;;
esac

case "$(uname -m)" in
    x86_64 | amd64)
        arch="amd64"
        ;;
    aarch64 | arm64)
        arch="arm64"
        ;;
    *)
        echo "Error: unsupported architecture: $(uname -m)" >&2
        exit 1
        ;;
esac

download_url="https://kind.sigs.k8s.io/dl/${KIND_VERSION}/kind-${os}-${arch}"
tmp_file="$(mktemp)"

cleanup() {
    rm -f "${tmp_file}"
}
trap cleanup EXIT

echo "Downloading kind ${KIND_VERSION} for ${os}/${arch}..."

curl \
    --fail \
    --location \
    --silent \
    --show-error \
    --retry 3 \
    --output "${tmp_file}" \
    "${download_url}"

if [[ "${EUID}" -eq 0 ]]; then
    install -m 0755 "${tmp_file}" "${INSTALL_PATH}"
else
    command -v sudo >/dev/null 2>&1 || {
        echo "Error: sudo is required to install into ${INSTALL_DIR}." >&2
        exit 1
    }

    sudo install -m 0755 "${tmp_file}" "${INSTALL_PATH}"
fi

echo "Installed kind at ${INSTALL_PATH}"
kind version