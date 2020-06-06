# dri (dotfiles requirement installer)

## can be used for managing requirements. (in any way)

A group of scripts to manage dotfiles requirements.

Currently supported distros. (It's super easy to add support, Help Required).

* ArchLinux (And arch based distros).
* Termux. [Currently Working]

Currently supported additional packages.
*   aur (yay) (arch only)
*   pip

# Requirements
* xargs
* grep
* coreutils

# Philosophy
A dedicated folder with the required requirements must be used.
(probably in your dotfiles repo).

### 1) Directory Structure
Example: 'REQUIREMENT'

* Each sub folder must contain the requirement for that distro.
```
.
└── REQUIREMENT
    ├── ArchLinux
    ├── Debian
    └── Termux
```
* Requirement can be (not necessary) broken into groups. (files in sub folder).
Each group can be installed separately.

```
.
└── REQUIREMENT
    ├── ArchLinux
    │   ├── Group1
    │   ├── Group2
    │   ├── Group3
    │   ├── Group4
    │   └── Group5
    ├── Debian
    │   ├── Group1
    │   ├── Group3
    │   ├── Group4
    │   └── Group5
    └── Termux
```

* As you can see, Debian is missing a `Group2` folder. This will be treated as
`Group2` is not supported in Debian
* `Termux` is missing all the files this will be treated as `Termux` as unsupported
distro. (same will be the case if `Termux` folder is missing.
* Empty Group file will be treated as if they don't have any requirement.
* Groups can have duplicate packages.

### 2) Group files
There are two types of package to install.
*  Native Packages.
Ex: pacman for ArchLinux, apt for Ubuntu etc.
* Additional Packages.
Ex: aur, pip, cargo, go etc.

<b>You can ignore the lines and line no. This is just a fancy representation.</b>
```
───────┬──────────────────────────────────────────────────────────────────────────────────────
       │ File: Group1
───────┼──────────────────────────────────────────────────────────────────────────────────────
   1   │ pkg1
   2   │ pkg2
   3   │ pkg3
   4   │ AUR:pkg4
   5   │ AUR:pkg5
   6   │ PIP:pkg6
   7   │ PREFIX:pkg7:extra-option
   8   │ PREFIX:pkg8:extra-option
───────┴──────────────────────────────────────────────────────────────────────────────────────
```
read `Group1` in repo.

* Each required package (pkg) should be separated by a newline.
* No prefix for native packages.
* \<PREFIX\>:\<PKG\> format is used for additional packages.
* Additional pkg can have extra option but the install-\<prefix\>.sh must handle that.

### 3) Keeping it minimal
The scripts are focused upon for optimization and minimalisms. (Not to a meme's extent).
There will be no limitation on the line number. (but one must try to minimize).

### 4) Installation
The user must go to the directory of their repo and use `dri` within the repo folder for installation. (Repository structure) (on `dri`)

### 5) Testing and community
I personally don't use a lot of distro myself. (Btw, I use arch 😂). If you find this
idea great and want to help in the development. Please help with the distro you use.

A successful project has a strong community behind it. If you wan to help you are most
welcome,if you can share and let other people know about this (who might me interesting)
it will be a great help.

# Repository structure. (A guide to the codebase)
 Each folder in this repo is dedicated to a particular distro.
 (Unless mentioned otherwise)

Each folder will contain the following.
```
install.sh # This will install the native packages.
install-<prefix>.sh # This will install the packages of that prefix.
<prefix>-installer.sh # This will install the prefix installer example: pip, yay
dri # This will handle the prefix(s) and packages and install everything the way it should be
```
### `install.sh`

* <b>Input:</b> space separated  native packages.
* <b>Output:</b> #not important

```
install.sh pkg1 pkg2 pkg3
```

This must install pkg1, pkg2, pkg3 if failed then a non zero code must be returned.

### `install-<prefix>.sh`

* <b>Input:</b> Takes space separated arguments (can be more than just package name,
but must be specified in Group file.
* <b>Output:</b> #not important

Example: In line 7 of the group file option `pkg7:extra-option` will be passed as
string.

`pkg7:extra-option pkg8:extra-option` will be passed for more than one, to `install-<prefix>.sh`


```
install-<prefix>.sh "pkg7:extra-option" "pkg8:extra-option"
```

* if any package is needed to install (natively) for make / dependency. It must use
`install.sh`
* If the installer is not available. `<prefix>-installer.sh` will be called.


### `<prefix>-installer.sh`

* <b>Input:</b> As required. (install-\<prefix\>.sh must be configured accordingly)
* <b>Output:</b> #not important

### `dri` (This should be invoked by the end user)
This takes group files as space separated input of `Group` names. And the location
of the REQUIREMENT  directory.

"Quotes are important"
```
dri "Group1 Group2 Group3" /path/to/requirements/
```
