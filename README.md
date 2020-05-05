![img](http://zfsonlinux.org/images/zfs-linux.png)

This repository is intended to help ZFS enthusiasts to build, test and deploy Debian packages for ZFS on Linux, 
using latest master branch from [official repo](https://github.com/openzfs/zfs) and patches to it, listed in patches/series folder. Official distributions are often lag behing dev progress, so, those wanting to use latest "bleeding edge" features, can leverage this possibility.

The repository is based on excellent work of [Debian ZFS team](https://salsa.debian.org/zfsonlinux-team/zfs.git) with a few customizations, allowed to build run smoontly on Github workflow runners. 

Attached to this repository exist a Github actions workflow located [here](./.github/workflows/debian-packages-build.yml), which upon each master commit, checks out [ZFS upstream repo](https://github.com/openzfs/zfs) 
then applies patches, builds, tests and upon tests success, deploys  built and tested debian binary packages into tiny, yet fully functional [APT repository](https://terem42.github.io/zfs-debian/), created using Github Pages.

You can later reference this repository in your deployments or fork this repo (insructions below) and build your custom version of packages, having all the beeding edge changes you want. This approach gives you complete freedom over the building 
version and applied patches over the source code, while still being guided by master branch from official repo.
If you want to change upstream repo source or branch from offcial repo to your forked repo, just edit .github/workflow/ubuntu-packages-build.yml workflow file. 

# Official Resources

  * [Site](http://zfsonlinux.org)
  * [Wiki](https://github.com/zfsonlinux/zfs/wiki)
  * [Mailing lists](https://github.com/zfsonlinux/zfs/wiki/Mailing-Lists)
  * [OpenZFS site](http://open-zfs.org/)

# Installation

Add the signing key for this repo:

````
sudo bash -c "wget -O - https://terem42.github.io/zfs-debian/apt_pub.gpg | apt-key add -"
````

Next, install packages:

````
sudo add-apt-repository 'deb https://terem42.github.io/zfs-debian/public zfs-debian-experimental main'
sudo bash -c "echo \"zfs-dkms zfs-dkms/note-incompatible-licenses note true\" | debconf-set-selections"
sudo apt install -t zfs-debian-experimental --yes zfs-dkms zfsutils-linux  
````
# List of tests skipped at Github runners
I've added patch, adding several tests to the "known to skip or fail" list, see it [here](./patches/terem-0002-added-known-to-skip-tests-on-github-workflow-vm.patch). Check it for complete list of these tests. If you want to use self-hosted runners, do not forget to exclude this patch from ./patches/series file to have complete test coverage.

# Forking the repo
Fork and setup this repo for personal ZFS packages tailored to your needs in 5 easy steps:
 * create github secret GITHUB_PERSONAL_TOKEN containing github personal acess token, it is nesessary for pushing changes into gh-pages branch after succesfull build and test (for security reasons, github.token used by Gihtub Actions workflow does not trigger properly Github Pages site rebuild after push to gh-pages branch).
 * either import your own or generate GPG key (it is used by github workflow to sign packages, read [here](https://help.github.com/en/github/authenticating-to-github/generating-a-new-gpg-key) on how to create gpg key, afterwards export public key into apt_pub.gpg file an commit changes into gh-pages branch
 * export as ASCII-armored your private GPG key into file, then create another Github secret GPG_KEY with the file contents
 * create github secret GPG_PASS holding your password for the private key
 * edit ./index.html file within gh-pages branch to match your repo and info you want, it will hold your repo entry page, explaining details on how to use this repo
