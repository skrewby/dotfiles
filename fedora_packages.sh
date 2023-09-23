#!/bin/bash

echo ""
echo "----------------------------"
echo "Installing Fedora packages  "
echo "----------------------------"
echo ""

dnf install neovim kitty zsh util-linux clang-tools-extra gcc-c++ fzf ripgrep util-linux-user
dnf -y groupinstall "Development Tools"
dnf -y groupinstall c-development

echo "More theming options for Fedora: "
echo "    Mutter Rounded"

