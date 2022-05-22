# cody

> simple universal installer

## Install

```sh
$(curl --version >/dev/null 2>/dev/null && echo curl -L || echo wget -O-) https://gitlab.com/risserlabs/community/cody/-/raw/main/cody.sh 2>/dev/null | sh -s i cody
```

## Usage

### install a installer

```sh
cody i <INSTALLER_NAME>
```

_or install a installer without installing cody_

```sh
$(curl --version >/dev/null 2>/dev/null && echo curl -L || echo wget -O-) https://gitlab.com/risserlabs/community/cody/-/raw/main/cody.sh 2>/dev/null | sh -s i <INSTALLER_NAME>
```

### uninstall a installer

```sh
cody u <INSTALLER_NAME>
```

_or uninstall a installer without installing cody_

```sh
$(curl --version >/dev/null 2>/dev/null && echo curl -L || echo wget -O-) https://gitlab.com/risserlabs/community/cody/-/raw/main/cody.sh 2>/dev/null | sh -s u <INSTALLER_NAME>
```
