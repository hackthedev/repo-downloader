# Repo Downloader
The scripts `install.bat` and `install.sh` can be configured to <b><ins>download and extract the latest release</ins></b> from multiple repos and extract them to the directory where the install script was executed in <b><ins>without creating a subdir</ins></b> or anything.

<br>

For the `install.sh` file its important to note that it should be executed like `./install.sh` and not like `sh install.sh` as it will return an error otherwise.

<br>

## Use Case
This could be used to install "dependencies" or for a plugin system or whatever. You could also modify the script to pass arguments instead of hardcoding the repos.
