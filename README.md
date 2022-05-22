# cody

> keep it simple stupid installer manager

## Install

```sh
$(curl --version >/dev/null 2>/dev/null && echo curl -L || echo wget -O-) https://gitlab.com/risserlabs/community/cody/-/raw/main/cody.sh 2>/dev/null | sh -s install cody
```

## Usage

### install a installer

```sh
cody install <INSTALLER_NAME>
```

_or install a installer without installing cody_

```sh
$(curl --version >/dev/null 2>/dev/null && echo curl -L || echo wget -O-) https://gitlab.com/risserlabs/community/cody/-/raw/main/cody.sh 2>/dev/null | sh -s install <INSTALLER_NAME>
```

### uninstall a installer

```sh
cody uninstall <INSTALLER_NAME>
```

_or uninstall a installer without installing cody_

```sh
$(curl --version >/dev/null 2>/dev/null && echo curl -L || echo wget -O-) https://gitlab.com/risserlabs/community/cody/-/raw/main/cody.sh 2>/dev/null | sh -s uninstall <INSTALLER_NAME>
```
