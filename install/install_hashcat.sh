#!/usr/bin/env bash
# install_hashcat.sh — Installs Hashcat on Ubuntu with GPU support

set -euo pipefail

function log_info() {
	echo -e "\033[1;34m[INFO]\033[0m $*"
}

function log_error() {
	echo -e "\033[1;31m[ERROR]\033[0m $*" >&2
}

function detect_gpu_vendor() {
	if lspci | grep -iq 'NVIDIA'; then
		echo "nvidia"
	elif lspci | grep -iq 'AMD'; then
		echo "amd"
	else
		echo "none"
	fi
}

function install_base_packages() {
	log_info "Updating package lists..."
	sudo apt-get update -y

	log_info "Installing base packages..."
	sudo apt-get install -y hashcat ocl-icd-libopencl1 clinfo
}

function install_nvidia_support() {
	log_info "Installing NVIDIA drivers and OpenCL runtime..."
	sudo apt-get install -y nvidia-driver-535 nvidia-opencl-dev
}

function install_amd_support() {
	log_info "Installing AMD OpenCL runtime..."
	sudo apt-get install -y mesa-opencl-icd
}

function verify_installation() {
	log_info "Verifying Hashcat installation..."
	if ! command -v hashcat &>/dev/null; then
		log_error "Hashcat command not found after installation!"
		exit 1
	fi

	log_info "Hashcat version:"
	hashcat --version

	log_info "Checking OpenCL devices:"
	clinfo | grep -E 'Platform Name|Device Name' || log_error "No OpenCL devices found."
}

function main() {
	log_info "Detecting GPU vendor..."
	GPU_VENDOR=$(detect_gpu_vendor)
	log_info "Detected GPU: $GPU_VENDOR"

	install_base_packages

	case "$GPU_VENDOR" in
	nvidia)
		install_nvidia_support
		;;
	amd)
		install_amd_support
		;;
	none)
		log_info "No supported GPU detected. Installing CPU-only support."
		;;
	esac

	verify_installation
	log_info "Hashcat installation complete."
}

main "$@"
