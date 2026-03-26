#!/bin/bash
# Check for new debugpy releases on PyPI

set -e

PACKAGE="debugpy"
SPEC_FILE="python-debugpy.spec"

# Get current version from spec file
CURRENT_VERSION=$(grep "^%global pypi_version" "$SPEC_FILE" | awk '{print $3}')

# Get latest version from PyPI
LATEST_VERSION=$(curl -s "https://pypi.org/pypi/$PACKAGE/json" | jq -r '.info.version')

echo "Current version in spec: $CURRENT_VERSION"
echo "Latest version on PyPI:  $LATEST_VERSION"

if [ "$CURRENT_VERSION" = "$LATEST_VERSION" ]; then
    echo "✓ Spec file is up to date"
    exit 0
else
    echo "⚠ New version available: $LATEST_VERSION"
    echo ""
    echo "To update:"
    echo "1. Edit $SPEC_FILE and update version to $LATEST_VERSION"
    echo "2. Add changelog entry"
    echo "3. Run: make srpm"
    echo ""
    echo "Or let Packit handle it automatically!"
    exit 1
fi
