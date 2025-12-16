#!/usr/bin/env bash

if [[ -e /etc/os-release ]]; then
  if (source /etc/os-release && [[ "$ID"=="Arch" || "$ID_LIKE"=="Arch" ]]); then
    echo 1
  else
    echo 0
  fi
fi
