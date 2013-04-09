
po_files=$(wildcard po/*.po)

default:
	$(MAKE) update-po

update-po:
	$(MAKE) pull-transifex

pull-transifex-all:
	tx pull -a

pull-transifex:
	tx pull
	$(MAKE) strip-po

strip-po:
	@for po_file in $(po_files); do \
		echo Stripping $$po_file; \
		msgattrib --translated --no-fuzzy --no-location $$po_file > $$po_file.tmp; \
		mv $$po_file.tmp $$po_file; \
	done
	@export FILES_TO_REMOVE=`find . -name '*.po' -empty`; \
	if [ "$$FILES_TO_REMOVE" != "" ]; then \
		echo Removing empty translation files; \
		rm -v $$FILES_TO_REMOVE; \
	fi
