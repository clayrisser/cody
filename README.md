# kisspm

> keep it simple stupid package manager

## Install

```sh
$(curl --version >/dev/null 2>/dev/null && echo curl -L || echo wget -O-) https://gitlab.com/risserlabs/community/kisspm/-/raw/main/kisspm.sh 2>/dev/null | sh -s install kisspm
```

## Usage

### install a package

```sh
kisspm install <PACKAGE_NAME>
```

_or install a package without installing kisspm_

```sh
$(curl --version >/dev/null 2>/dev/null && echo curl -L || echo wget -O-) https://gitlab.com/risserlabs/community/kisspm/-/raw/main/kisspm.sh 2>/dev/null | sh -s install <PACKAGE_NAME>
```

### uninstall a package

```sh
kisspm uninstall <PACKAGE_NAME>
```

_or uninstall a package without installing kisspm_

```sh
$(curl --version >/dev/null 2>/dev/null && echo curl -L || echo wget -O-) https://gitlab.com/risserlabs/community/kisspm/-/raw/main/kisspm.sh 2>/dev/null | sh -s uninstall <PACKAGE_NAME>
```
