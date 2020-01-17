![img](http://zfsonlinux.org/images/zfs-linux.png)

This repository is intended to help ZFS enthusiasts to build, test and deploy Debian packages for ZFS on Linux, 
using latest master branch and patches to it, listed in patches/series folder. Official distributions are often lag behing deve process, so, those wanting to use latest bleeding egge prebuilt packages, can leverage this possibility.

The repository was based on excellent work of [Debian ZFS team](https://salsa.debian.org/zfsonlinux-team/zfs.git) with a fex customizations, allowed to build run smoontly on Github workflow runners. 

Attached to this repository exist a Github actions workflow located [here](blob/master/.github/workflows/ubuntu-packages-build.yml), which upon each master commit, checks out [ZFS upstream repo](https://github.com/zfsonlinux/zfs) 
then applies patches, builds, tests and upon tests success, deploys  built and tested debian binary packages into tiny fully functional APT repository, created using Gihub Pages.

You can later reference this repository in your deployments or fork this repo (insructions below) and build your custom version of packages, having all the beeding edge changes you want. This approach gives you complete freedom over the building 
version and applied patches over the source code, while still being guided by master branch steam from official repo.
If you want to change upstream repo source or branch from offcial repo to your forked repo, just edit .github/workflow/ubuntu-packages-build.yml workflow file. 

# Official Resources

  * [Site](http://zfsonlinux.org)
  * [Wiki](https://github.com/zfsonlinux/zfs/wiki)
  * [Mailing lists](https://github.com/zfsonlinux/zfs/wiki/Mailing-Lists)
  * [OpenZFS site](http://open-zfs.org/)

# Installation

Add the following to your APT sources.list file:

````
sudo bash -c "wget -O - https://andrey42.github.io/zfs-ubuntu/apt_pub.gpg | apt-key add -"
````

Next, install packages from this repo:

````
sudo add-apt-repository 'deb https://andrey42.github.io/zfs-ubuntu/public bionic zfs-backports-experimental'
sudo bash -c "echo \"zfs-dkms zfs-dkms/note-incompatible-licenses note true\" | debconf-set-selections"
sudo apt install --yes zfs-dkms zfsutils-linux 
````

# Forking the repo
Fork and setup this repo for personal ZFS packages tailored to your needs in 5 easy steps:
 * create github secret GITHUB_PERSONAL_TOKEN containing github personal acess token, it is nesessary for pushing changes into gh-pages branch after succesfull build and test (for some reason, github.token used by Gihtub Actions workflow does not trigger property Ghihub Pages site rebuild).
 * either import your own or generate GPG key (it is used by github workflow to sign packages, read [here](https://help.github.com/en/github/authenticating-to-github/generating-a-new-gpg-key) on how to create gpg key, afterwards export public key into apt_pub.gpg file an commit changes into gh-pages branch
 * export as ASCII-armored your private GPG key into file, then create GPG_KEY github key with the file contents
 * create github secret GPG_PASS holding your password for the private key
 * edit ./index.html file within gh-pages branch, it will hold your repo entry page, explaining details on how to use this repo

