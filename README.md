# cody

> keep it simple stupid package manager

## Install

```sh
$(curl --version >/dev/null 2>/dev/null && echo curl -L || echo wget -O-) https://gitlab.com/risserlabs/community/cody/-/raw/main/cody.sh 2>/dev/null | sh -s install cody
```

## Usage

### install a package

```sh
cody install <PACKAGE_NAME>
```

_or install a package without installing cody_

```sh
$(curl --version >/dev/null 2>/dev/null && echo curl -L || echo wget -O-) https://gitlab.com/risserlabs/community/cody/-/raw/main/cody.sh 2>/dev/null | sh -s install <PACKAGE_NAME>
```

### uninstall a package

```sh
cody uninstall <PACKAGE_NAME>
```

_or uninstall a package without installing cody_

```sh
$(curl --version >/dev/null 2>/dev/null && echo curl -L || echo wget -O-) https://gitlab.com/risserlabs/community/cody/-/raw/main/cody.sh 2>/dev/null | sh -s uninstall <PACKAGE_NAME>
```
