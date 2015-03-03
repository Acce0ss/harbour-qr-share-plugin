Name: example-share-plugin
Version: 0.0.1
Release: 0
Summary: Share plugins for nemo transfer engine
Group: System/Libraries
License: LICENCE
URL: https://github.com/nemomobile/transfer-engine
Source0: %{name}-%{version}.tar.gz
BuildRequires: pkgconfig(Qt5Core)
BuildRequires: pkgconfig(Qt5Qml)
BuildRequires: pkgconfig(nemotransferengine-qt5)
BuildRequires: qt5-qttools
BuildRequires: qt5-qttools-linguist

Requires:  nemo-transferengine-qt5
Requires:  declarative-transferengine-qt5 >= 0.0.44

%description
%{summary}.

%files
%defattr(-,root,root,-)
%{_libdir}/nemo-transferengine/plugins/*shareplugin.so
%{_datadir}/nemo-transferengine/plugins/*.qml
%{_datadir}/translations/nemotransferengine/*.qm

%package ts-devel
Summary:   Translation source for Transfer Engine share plugins
License:   TBD
Group:     System/Libraries

%description ts-devel
Translation source for Transfer Engine share plugins

%files ts-devel
%defattr(-,root,root,-)
%{_datadir}/translations/source/example_share_plugin.ts

%prep
%setup -q -n %{name}-%{version}

%build

%qmake5

make %{?jobs:-j%jobs}

%install
rm -rf %{buildroot}
%qmake5_install

