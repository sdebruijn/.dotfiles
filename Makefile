.PHONY: *

help: ## This help dialog.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2 | "sort -u"}' $(MAKEFILE_LIST)


all: ## Install all dotfiles
	stow --verbose --target=${HOME} --restow */

test: ## Test stow command 
	stow --verbose --target=${HOME} --restow test/
	
delete: ## Uninstall all dotfiles
	stow --verbose --target=${HOME} --delete */

