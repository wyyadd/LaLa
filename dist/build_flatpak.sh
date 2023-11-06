#!/bin/bash

app_name="LaLa"
current_dir=$(dirname "$0")
package_dir="/app"

# Copy the app to the Flatpak-based location.
cp -fr "$current_dir/deb/usr/." "$package_dir"
mkdir -p "$package_dir/$app_name"
cp -fr "$current_dir/linux/x64/release/bundle/." \
  "$package_dir/$app_name"
mkdir -p "$package_dir/bin"
ln -s "$package_dir/$app_name/$app_name" "$package_dir/bin/$app_name"