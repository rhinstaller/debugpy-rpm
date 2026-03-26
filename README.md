# debugpy RPM Package

RPM packaging for debugpy (Debug Adapter Protocol for Python 3) compatible with Fedora, CentOS Stream, and EPEL.

- **Version**: 1.8.20
- **License**: MIT
- **Upstream**: https://github.com/microsoft/debugpy

## Quick Start

### Automated Builds (Recommended)

Packit automatically monitors upstream releases and builds in COPR. See **[SETUP.md](SETUP.md)** for complete setup instructions.

### Manual Local Build

```bash
# Quick build with mock (defaults to Fedora Rawhide)
make mock

# Build for specific distribution
make mock DIST=fedora-43-x86_64
make mock DIST=epel-9-x86_64
```

See `make help` for all available targets.

## Building with Mock

Mock provides a clean build environment isolated from your system:

```bash
# Install mock and add yourself to the mock group
sudo dnf install mock
sudo usermod -a -G mock $USER
newgrp mock

# Build for different distributions
make mock DIST=fedora-rawhide-x86_64  # Default
make mock DIST=fedora-43-x86_64
make mock DIST=centos-stream-9-x86_64
make mock DIST=epel-9-x86_64
```

## Manual rpmbuild

```bash
# Install build tools
sudo dnf install rpm-build rpmdevtools

# Download sources and build SRPM
make srpm

# Build RPM locally (not recommended - use mock instead)
make rpm
```

## Packit Integration

Once configured, Packit automatically:
- Monitors https://github.com/microsoft/debugpy for new releases
- Builds RPMs in COPR for Fedora 43+, CentOS Stream, and EPEL
- Proposes updates to official Fedora repositories

**Setup**: See [SETUP.md](SETUP.md) for detailed Packit configuration.

**Test locally**:
```bash
packit validate    # Validate configuration
packit srpm        # Build SRPM
```

## Installation

Once built in COPR:

```bash
sudo dnf copr enable @rhinstaller/devutils
sudo dnf install python3-debugpy
```

**Verify**:
```bash
python3 -c "import debugpy; print(debugpy.__version__)"
debugpy --help
```

## Checking for Updates

```bash
./check-upstream.sh
```

Compares spec file version with latest PyPI release. Requires `jq`.

## Supported Distributions

- Fedora 43+
- CentOS Stream 9+
- EPEL 9, 10 (for RHEL 9+)

## License

Spec file is provided as-is. debugpy is licensed under MIT.
