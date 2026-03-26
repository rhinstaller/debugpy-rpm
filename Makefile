.PHONY: help srpm rpm mock clean spectool

SPEC_FILE = python-debugpy.spec
PACKAGE_NAME = python-debugpy
DIST ?= fedora-rawhide-x86_64

help:
	@echo "Available targets:"
	@echo "  spectool    - Download source files"
	@echo "  srpm        - Build source RPM"
	@echo "  rpm         - Build binary RPM (requires sources)"
	@echo "  mock        - Build using mock (DIST=<target>, default: fedora-rawhide-x86_64)"
	@echo "  clean       - Clean build artifacts"
	@echo ""
	@echo "Mock build examples:"
	@echo "  make mock DIST=fedora-43-x86_64"
	@echo "  make mock DIST=fedora-44-x86_64"
	@echo "  make mock DIST=fedora-rawhide-x86_64"
	@echo "  make mock DIST=centos-stream-9-x86_64"
	@echo "  make mock DIST=centos-stream-10-x86_64"
	@echo "  make mock DIST=epel-9-x86_64"
	@echo "  make mock DIST=epel-10-x86_64"

spectool:
	spectool -g -R $(SPEC_FILE)

srpm: spectool
	rm -f *.src.rpm
	rpmbuild -bs $(SPEC_FILE) \
		--define "_sourcedir $(PWD)" \
		--define "_srcrpmdir $(PWD)"

rpm: spectool
	rpmbuild -ba $(SPEC_FILE) \
		--define "_sourcedir $(PWD)" \
		--define "_rpmdir $(PWD)" \
		--define "_srcrpmdir $(PWD)" \
		--define "_builddir $(PWD)/BUILD" \
		--define "_buildrootdir $(PWD)/BUILDROOT"

mock: srpm
	mock -r $(DIST) --rebuild $(PACKAGE_NAME)-*.src.rpm

clean:
	rm -rf BUILD BUILDROOT RPMS SRPMS
	rm -f *.rpm *.tar.gz *.log
	rm -rf results_*
