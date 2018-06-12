BUILD_DIR := build

# Locate JQ for parsing info.json
JQ = $(shell which jq 2> /dev/null)

ifeq ($(strip $(JQ)),)
$(error "jq program is required to parse info.json")
else
MODNAME = $(shell cat info.json | $(JQ) -r .name)
MODVERSION = $(shell cat info.json | $(JQ) -r .version)
FACTORIOVERSION = $(shell cat info.json | $(JQ) -r .factorio_version)
FACTORIOFOLDER = /mnt/c/Bin/Factorio/Factorio_0.16.47/mods
endif

all: release

release: clean
	@mkdir -p "./$(BUILD_DIR)"
	git archive --prefix "$(MODNAME)_$(MODVERSION)/" -o "./$(BUILD_DIR)/$(MODNAME)_$(MODVERSION).zip" HEAD
	cp ./$(BUILD_DIR)/$(MODNAME)_$(MODVERSION).zip "$(FACTORIOFOLDER)/"

dev: clean
	@mkdir -p $(BUILD_DIR)
	rsync -qvaz --delete --exclude={.git,build} ./ "./$(BUILD_DIR)/$(MODNAME)_$(MODVERSION)"
	rsync -qvaz --delete "./$(BUILD_DIR)/$(MODNAME)_$(MODVERSION)/" "$(FACTORIOFOLDER)/$(MODNAME)_$(MODVERSION)"
	set -e; for file in $$(find "./$(BUILD_DIR)/$(MODNAME)_$(MODVERSION)" -iname '*.lua' -type f); do echo "Checking syntax: $$file" ; luac -p $$file; done;

clean:
	rm -rf $(FACTORIOFOLDER)/$(MODNAME)_*
