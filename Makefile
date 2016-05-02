# (C) Copyright Connected Digital Economy Catapult Limited 2015
.PHONY: clean requirements docs

# You should not set these variables from the command line.
# Directory that this Makfile is in
SERVICEDIR          = $(shell pwd)

# Python script directory
PYTHON_SCRIPT_DIR   = $(SERVICEDIR)/python

# Directory to build docs in
BUILDDIR            = $(SERVICEDIR)/_build

DOC_DIR             = $(SERVICEDIR)/documents

MARKDOWN_DOC_DIR_IN = $(DOC_DIR)/markdown

# Directory to output architecture markdown converted docs to
ARCH_DOC_DIR_OUT    = $(BUILDDIR)/arch

# Directory to find architecture markdown docs
ARCH_DOC_DIR_IN     = $(MARKDOWN_DOC_DIR_IN)/arch

# Directory to output authentication markdown converted docs to
AUTH_DOC_DIR_OUT    = $(BUILDDIR)/auth

# Directory to find authentication markdown docs
AUTH_DOC_DIR_IN     = $(MARKDOWN_DOC_DIR_IN)/auth

# Directory to output tocs markdown converted docs to
TOCS_DOC_DIR_OUT    = $(BUILDDIR)/tocs

# Directory to find tocs markdown docs
TOCS_DOC_DIR_IN     = $(MARKDOWN_DOC_DIR_IN)/tocs

# Directory to output types markdown converted docs to
TYPES_DOC_DIR_OUT = $(BUILDDIR)/types

# Directory to find types markdown docs
TYPES_DOC_DIR_IN  = $(MARKDOWN_DOC_DIR_IN)/types

# Directory to output versioning markdown converted docs to
VERSION_DOC_DIR_OUT = $(BUILDDIR)/versioning

# Directory to find versioning markdown docs
VERSION_DOC_DIR_IN  = $(MARKDOWN_DOC_DIR_IN)/versioning

# Grip app
GRIP_APP            = grip

# Grip switches
GRIP_SWITCHES       =

# Create list of target .html file names to be created based on all .md files found in the 'doc directory'
md_docs :=	$(patsubst $(ARCH_DOC_DIR_IN)/%.md,$(ARCH_DOC_DIR_OUT)/%.html,$(wildcard $(ARCH_DOC_DIR_IN)/*.md)) \
			$(patsubst $(AUTH_DOC_DIR_IN)/%.md,$(AUTH_DOC_DIR_OUT)/%.html,$(wildcard $(AUTH_DOC_DIR_IN)/*.md)) \
			$(patsubst $(TOCS_DOC_DIR_IN)/%.md,$(TOCS_DOC_DIR_OUT)/%.html,$(wildcard $(TOCS_DOC_DIR_IN)/*.md)) \
			$(patsubst $(TYPES_DOC_DIR_IN)/%.md,$(TYPES_DOC_DIR_OUT)/%.html,$(wildcard $(TYPES_DOC_DIR_IN)/*.md)) \
			$(patsubst $(VERSION_DOC_DIR_IN)/%.md,$(VERSION_DOC_DIR_OUT)/%.html,$(wildcard $(VERSION_DOC_DIR_IN)/*.md)) \
			$(patsubst $(SERVICEDIR)/%.md,$(BUILDDIR)/%.html,$(wildcard $(SERVICEDIR)/*.md))

clean:
	rm -rf $(BUILDDIR)

# Install requirements
requirements:
	pip install -r $(SERVICEDIR)/requirements.txt

# Dependencies of .html document files created from files in the 'architecture doc directory'
$(ARCH_DOC_DIR_OUT)/%.html : $(ARCH_DOC_DIR_IN)/%.md
	mkdir -p $(dir $@)
	$(GRIP_APP) $(GRIP_SWITCHES) $< --export $@
	file_translate -c $(DOC_DIR)/translate.json -i $@ -o $@

# Dependencies of .html document files created from files in the 'authentication doc directory'
$(AUTH_DOC_DIR_OUT)/%.html : $(AUTH_DOC_DIR_IN)/%.md
	mkdir -p $(dir $@)
	$(GRIP_APP) $(GRIP_SWITCHES) $< --export $@
	file_translate -c $(DOC_DIR)/translate.json -i $@ -o $@

# Dependencies of .html document files created from files in the 'tocs doc directory'
$(TOCS_DOC_DIR_OUT)/%.html : $(TOCS_DOC_DIR_IN)/%.md
	mkdir -p $(dir $@)
	$(GRIP_APP) $(GRIP_SWITCHES) $< --export $@
	file_translate -c $(DOC_DIR)/translate.json -i $@ -o $@

# Dependencies of .html document files created from files in the 'types doc directory'
$(TYPES_DOC_DIR_OUT)/%.html : $(TYPES_DOC_DIR_IN)/%.md
	mkdir -p $(dir $@)
	$(GRIP_APP) $(GRIP_SWITCHES) $< --export $@
	file_translate -c $(DOC_DIR)/translate.json -i $@ -o $@

# Dependencies of .html document files created from files in the 'versioning doc directory'
$(VERSION_DOC_DIR_OUT)/%.html : $(VERSION_DOC_DIR_IN)/%.md
	mkdir -p $(dir $@)
	$(GRIP_APP) $(GRIP_SWITCHES) $< --export $@
	file_translate -c $(DOC_DIR)/translate.json -i $@ -o $@

# Dependencies of .html document files created from README.md
$(BUILDDIR)/%.html : $(SERVICEDIR)/%.md
	mkdir -p $(dir $@)
	$(GRIP_APP) $(GRIP_SWITCHES) $< --export $@
	file_translate -c $(DOC_DIR)/translate.json -i $@ -o $@

# Create .html docs from all markdown files
md_docs: $(md_docs)
	# Copy dependent files required to render the views, e.g. images
	rsync \
		--exclude '*.md' \
		--exclude 'eap' \
		--exclude 'drawio' \
		-r \
		$(MARKDOWN_DOC_DIR_IN)/ $(BUILDDIR)

# Create all docs
docs: md_docs
