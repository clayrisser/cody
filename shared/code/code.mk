CODE ?= code

CODE_INSTALLER := $(CODE)
ifeq ($(CODE),code)
CODE_INSTALLER := cursor
endif

.PHONY: code-extensions
code-extensions: $(patsubst %,$(_INSTALLED_PATH)/.code/%,$(CODE_EXTENSIONS))

$(_INSTALLED_PATH)/.code/%:
	@$(CODE) --install-extension $(@F)
	@mkdir -p $(@D)
	@touch $@
