Name: harbour-qr-share-plugin
Version: 0.2
Release: 1
Summary: QRCode text / link / vcard share plugin, using qqr.js by M4rtinK
Group: System/Libraries
License: LICENCE
URL: https://github.com/Acce0ss/harbour-qr-share-plugin
Source0: %{name}-%{version}.tar.gz
BuildRequires: pkgconfig(Qt5Core)
BuildRequires: pkgconfig(Qt5Qml)
BuildRequires: pkgconfig(nemotransferengine-qt5)
BuildRequires: qt5-qttools
BuildRequires: qt5-qttools-linguist

Requires:  nemo-transferengine-qt5
Requires:  declarative-transferengine-qt5 >= 0.0.44
Requires:  qt5-qtdeclarative-import-sensors >= 5.2

%description
%{summary}.

%files
%defattr(-,root,root,-)
%{_libdir}/nemo-transferengine/plugins/*shareplugin.so
%{_libdir}/qt5/qml/fi/lahdemaki/QQRCode/qmldir
%{_libdir}/qt5/qml/fi/lahdemaki/QQRCode/qqr.js
%{_libdir}/qt5/qml/fi/lahdemaki/QQRCode/QRCode.qml
%{_datadir}/nemo-transferengine/plugins/QRCodeShow.qml
%{_datadir}/translations/nemotransferengine/*.qm

%package ts-devel
Summary:   Translation source for QRCode share plugin
License:   TBD
Group:     System/Libraries

%description ts-devel
Translation source for QRCode share plugin

%files ts-devel
%defattr(-,root,root,-)
%{_datadir}/translations/source/harbour_qr_share_plugin.ts

%prep
%setup -q -n %{name}-%{version}

%build

%qmake5

make %{?jobs:-j%jobs}

%install
rm -rf %{buildroot}
%qmake5_install

%changelog
* Sun Mar 8 2015 Asser Lähdemäki <asser@lahdemaki.fi> - 0.2-1
- Added downsideUp feature requested by Vattuvarg
- Some cosmetic changes (rounded border for code, code always centered)
- Hopefully stabilized the code generation a bit

* Fri Mar 6 2015 Asser Lähdemäki <asser@lahdemaki.fi> - 0.1-1
- Initial release, with some bugs in generating codes
- Translations not working yet
