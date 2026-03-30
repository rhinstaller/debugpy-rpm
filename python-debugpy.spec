%global pypi_name debugpy
%global pypi_version 1.8.20

Name:           python-%{pypi_name}
Version:        %{pypi_version}
Release:        1%{?dist}
Summary:        An implementation of the Debug Adapter Protocol for Python

License:        MIT
URL:            https://github.com/microsoft/debugpy
Source0:        https://files.pythonhosted.org/packages/source/d/%{pypi_name}/%{pypi_name}-%{version}.tar.gz

BuildRequires:  python3-devel
BuildRequires:  pyproject-rpm-macros
BuildRequires:  python3-pip
BuildRequires:  python3-setuptools
%if 0%{?rhel} && 0%{?rhel} < 11
BuildRequires:  python3-wheel
%endif
BuildRequires:  gcc
BuildRequires:  gcc-c++

# For building Cython extensions
BuildRequires:  python3-cython

%description
debugpy is an implementation of the Debug Adapter Protocol for Python 3.
It enables debugging Python applications through a standardized protocol,
allowing various IDEs and editors to connect and control execution.

%package -n python3-%{pypi_name}
Summary:        %{summary}
%{?python_provide:%python_provide python3-%{pypi_name}}

%description -n python3-%{pypi_name}
debugpy is an implementation of the Debug Adapter Protocol for Python 3.
It enables debugging Python applications through a standardized protocol,
allowing various IDEs and editors to connect and control execution.

%prep
%autosetup -n %{pypi_name}-%{version}

%build
%pyproject_wheel

%install
%pyproject_install
%pyproject_save_files %{pypi_name}

%files -n python3-%{pypi_name} -f %{pyproject_files}
%doc README.md
%{_bindir}/debugpy
%{_bindir}/debugpy-adapter

%changelog
* Thu Mar 26 2026 Bruno <bciconel@redhat.com> - 1.8.20-1
- Initial package for Fedora, CentOS Stream, and EPEL
