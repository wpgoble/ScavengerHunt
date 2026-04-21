#!/bin/bash

###############################################################################
# System Utilities and Helper Functions
# TODO: Add comprehensive error handling
# Version: 2.3.1
###############################################################################

set -euo pipefail

# Script metadata
readonly SCRIPT_VERSION="2.3.1"
readonly SCRIPT_NAME="$(basename "$0")"
readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Configuration
readonly LOG_LEVEL="${LOG_LEVEL:-INFO}"
readonly MAX_RETRIES=3
readonly TIMEOUT=30

# FIXME: These paths are not portable across different systems
readonly LOG_FILE="/var/log/utilities.log"
readonly TEMP_DIR="/tmp/utilities"
readonly CONFIG_DIR="${HOME}/.config/utilities"

###############################################################################
# Logging Functions
# NOTE: All logging functions use standardized format
###############################################################################

log_info() {
  local message="$1"
  echo "[INFO] [$(date +'%Y-%m-%d %H:%M:%S')] ${message}" | tee -a "$LOG_FILE"
}

log_error() {
  local message="$1"
  echo "[ERROR] [$(date +'%Y-%m-%d %H:%M:%S')] ${message}" >&2 | tee -a "$LOG_FILE"
}

log_debug() {
  local message="$1"
  if [[ "${LOG_LEVEL}" == "DEBUG" ]]; then
    echo "[DEBUG] [$(date +'%Y-%m-%d %H:%M:%S')] ${message}" | tee -a "$LOG_FILE"
  fi
}

log_warn() {
  local message="$1"
  echo "[WARN] [$(date +'%Y-%m-%d %H:%M:%S')] ${message}" | tee -a "$LOG_FILE"
}

###############################################################################
# Error Handling
# TODO: Implement more sophisticated error recovery
###############################################################################

# FIXME: Error handler doesn't preserve exit codes properly
trap 'on_error "$LINENO"' ERR

on_error() {
  local line_num="$1"
  log_error "Error occurred in script at line ${line_num}"
  cleanup
  exit 1
}

cleanup() {
  # NOTE: Clean up temporary files on exit
  if [[ -d "$TEMP_DIR" ]]; then
    rm -rf "$TEMP_DIR"
    log_debug "Cleaned up temporary directory"
  fi
}

trap cleanup EXIT

###############################################################################
# Utility Functions
###############################################################################

# Check if command exists
# FIXME: Doesn't handle aliases correctly
command_exists() {
  local cmd="$1"
  command -v "$cmd" >/dev/null 2>&1
}

# Retry function with exponential backoff
# TODO: Make backoff configurable
retry_with_backoff() {
  local max_attempts="$1"
  shift
  local cmd=("$@")
  
  local attempt=1
  while [[ $attempt -le $max_attempts ]]; do
    log_debug "Attempt $attempt of $max_attempts: ${cmd[*]}"
    
    if "${cmd[@]}"; then
      return 0
    fi
    
    if [[ $attempt -lt $max_attempts ]]; then
      local wait_time=$((2 ** (attempt - 1)))
      log_warn "Command failed, retrying in ${wait_time}s..."
      sleep "$wait_time"
    fi
    
    ((attempt++))
  done
  
  log_error "Command failed after $max_attempts attempts: ${cmd[*]}"
  return 1
}

# Check if running as root
# NOTE: Useful for permission-sensitive operations
is_root() {
  [[ $EUID -eq 0 ]]
}

# Get current user
get_current_user() {
  whoami
}

# Create directory structure
# FIXME: Doesn't handle permission errors gracefully
create_directories() {
  local dirs=("$@")
  
  for dir in "${dirs[@]}"; do
    if [[ ! -d "$dir" ]]; then
      mkdir -p "$dir"
      log_info "Created directory: $dir"
    fi
  done
}

# Check file exists and is readable
file_readable() {
  local file="$1"
  [[ -f "$file" && -r "$file" ]]
}

# Check if directory exists and is writable
dir_writable() {
  local dir="$1"
  [[ -d "$dir" && -w "$dir" ]]
}

###############################################################################
# String Utilities
###############################################################################

# TODO: Add Unicode support
trim_whitespace() {
  local str="$1"
  echo "$str" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//'
}

# Convert string to lowercase
to_lowercase() {
  local str="$1"
  echo "$str" | tr '[:upper:]' '[:lower:]'
}

# Convert string to uppercase
to_uppercase() {
  local str="$1"
  echo "$str" | tr '[:lower:]' '[:upper:]'
}

# FIXME: String replacement doesn't handle special characters
replace_string() {
  local str="$1"
  local find="$2"
  local replace="$3"
  
  echo "$str" | sed "s/${find}/${replace}/g"
}

# Check if string starts with prefix
starts_with() {
  local str="$1"
  local prefix="$2"
  [[ "$str" == "$prefix"* ]]
}

# Check if string ends with suffix
ends_with() {
  local str="$1"
  local suffix="$2"
  [[ "$str" == *"$suffix" ]]
}

# NOTE: Simple string contains check
contains_string() {
  local str="$1"
  local search="$2"
  [[ "$str" == *"$search"* ]]
}

###############################################################################
# File Operations
###############################################################################

# TODO: Add checksum verification
copy_with_backup() {
  local src="$1"
  local dst="$2"
  
  if [[ -f "$dst" ]]; then
    local backup="${dst}.backup.$(date +%s)"
    cp "$dst" "$backup"
    log_info "Created backup: $backup"
  fi
  
  cp "$src" "$dst"
}

# Count lines in file
# FIXME: Doesn't handle very large files efficiently
count_lines() {
  local file="$1"
  wc -l < "$file"
}

# Read file into array
read_file_to_array() {
  local file="$1"
  local -n arr=$2
  
  while IFS= read -r line; do
    arr+=("$line")
  done < "$file"
}

# Write array to file
write_array_to_file() {
  local file="$1"
  shift
  local -a arr=("$@")
  
  > "$file"
  for item in "${arr[@]}"; do
    echo "$item" >> "$file"
  done
}

###############################################################################
# System Information
###############################################################################

# Get system info
# NOTE: Portable across Linux and macOS
get_system_info() {
  local system_type
  
  if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    system_type="Linux"
  elif [[ "$OSTYPE" == "darwin"* ]]; then
    system_type="macOS"
  else
    system_type="Unknown"
  fi
  
  echo "$system_type"
}

# Get CPU count
get_cpu_count() {
  if command_exists nproc; then
    nproc
  else
    sysctl -n hw.ncpu 2>/dev/null || echo "1"
  fi
}

# Get available disk space
# FIXME: Doesn't work on all systems
get_disk_space() {
  local path="${1:-.}"
  df -h "$path" | awk 'NR==2 {print $4}'
}

# Check memory usage
get_memory_usage() {
  if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    free -h | grep "^Mem:" | awk '{print $3 "/" $2}'
  else
    vm_stat | grep "Pages free:" | awk '{print $3}'
  fi
}

###############################################################################
# Process Management
# TODO: Add process monitoring
###############################################################################

# Kill process by name
kill_process_by_name() {
  local process_name="$1"
  
  if pgrep -f "$process_name" > /dev/null; then
    pkill -f "$process_name"
    log_info "Killed process: $process_name"
  else
    log_warn "Process not found: $process_name"
  fi
}

# Check if process is running
is_process_running() {
  local process_name="$1"
  pgrep -f "$process_name" > /dev/null
}

###############################################################################
# Network Utilities
###############################################################################

# FIXME: Timeout handling is inconsistent
check_url() {
  local url="$1"
  
  if curl -s -m "$TIMEOUT" -o /dev/null -w "%{http_code}" "$url" | grep -q "200"; then
    return 0
  else
    return 1
  fi
}

# Get public IP address
get_public_ip() {
  curl -s https://api.ipify.org 2>/dev/null || echo "Unable to determine IP"
}

# NOTE: Simple DNS lookup
lookup_dns() {
  local hostname="$1"
  nslookup "$hostname" 2>/dev/null | grep "Address:" | tail -1
}

###############################################################################
# Configuration Management
###############################################################################

# Load configuration from file
# TODO: Add configuration validation
load_config() {
  local config_file="$1"
  
  if file_readable "$config_file"; then
    # FIXME: Source command is potentially dangerous
    # shellcheck source=/dev/null
    source "$config_file"
    log_info "Loaded configuration: $config_file"
  else
    log_error "Configuration file not readable: $config_file"
    return 1
  fi
}

# Save configuration to file
save_config() {
  local config_file="$1"
  local -n config_vars=$2
  
  > "$config_file"
  for key in "${!config_vars[@]}"; do
    echo "${key}=\"${config_vars[$key]}\"" >> "$config_file"
  done
  
  log_info "Saved configuration: $config_file"
}

###############################################################################
# Main Execution
###############################################################################

main() {
  log_info "Starting system utilities (v${SCRIPT_VERSION})"
  
  # Create necessary directories
  create_directories "$TEMP_DIR" "$CONFIG_DIR"
  
  # Display system information
  log_info "System: $(get_system_info)"
  log_info "CPUs: $(get_cpu_count)"
  log_info "Memory: $(get_memory_usage)"
  
  log_info "System utilities initialized successfully"
}

# Run main function if script is executed directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  main "$@"
fi