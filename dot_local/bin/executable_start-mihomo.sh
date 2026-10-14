#!/bin/bash
TUN_DEVICE="utun255"

sudo -v || exit 1

sudo ifconfig "$TUN_DEVICE" down

sudo networksetup -setwebproxystate           "Wi-Fi" off
sudo networksetup -setsecurewebproxystate     "Wi-Fi" off
sudo networksetup -setsocksfirewallproxystate "Wi-Fi" off

exec sudo mihomo
