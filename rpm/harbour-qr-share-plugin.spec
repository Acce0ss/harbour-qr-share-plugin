Name: harbour-qr-share-plugin
Version: 0.4
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
#%{_datadir}/translations/nemotransferengine/*eng_en.qm

%package ts-devel
Summary:   Translation source for QRCode share plugin
License:   TBD
Group:     System/Libraries

%description ts-devel
Translation source for QRCode share plugin

%files ts-devel
%defattr(-,root,root,-)
%{_datadir}/translations/source/harbour_qr_share_plugin.ts

%package en_GB_qm
Summary:   Translation to UK English for QRCode share plugin
License:   MIT
Group:     System/Libraries

%description en_GB_qm
Translation source for QRCode share plugin

%files en_GB_qm
%defattr(-,root,root,-)
%{_datadir}/translations/nemotransferengine/harbour_qr_share_plugin-en_GB.qm

%package fi_qm
Summary:   Translation to UK English for QRCode share plugin
License:   MIT
Group:     System/Libraries

%description fi_qm
Translation source for QRCode share plugin

%files fi_qm
%defattr(-,root,root,-)
%{_datadir}/translations/nemotransferengine/harbour_qr_share_plugin-fi.qm

%package sv_qm
Summary:   Translation to Swedish for QRCode share plugin
License:   MIT
Group:     System/Libraries

%description sv_qm
Translation source for QRCode share plugin

%files sv_qm
%defattr(-,root,root,-)
%{_datadir}/translations/nemotransferengine/harbour_qr_share_plugin-sv.qm

%package ru_qm
Summary:   Translation to Russian for QRCode share plugin
License:   MIT
Group:     System/Libraries

%description ru_qm
Translation source for QRCode share plugin

%files ru_qm
%defattr(-,root,root,-)
%{_datadir}/translations/nemotransferengine/harbour_qr_share_plugin-ru.qm

%prep
%setup -q -n %{name}-%{version}

%build

%qmake5

make %{?jobs:-j%jobs}

%install
rm -rf %{buildroot}
%qmake5_install

%changelog
* Thu Mar 19 2015 Asser Lähdemäki <asser@lahdemaki.fi> - 0.4-1
- added separate language packages

* Sun Mar 8 2015 Asser Lähdemäki <asser@lahdemaki.fi> - 0.3-1
- fix bug in pulldown menu

* Sun Mar 8 2015 Asser Lähdemäki <asser@lahdemaki.fi> - 0.2-1
- Added downsideUp feature requested by Vattuvarg
- Some cosmetic changes (rounded border for code, code always centered)
- Hopefully stabilized the code generation a bit

* Fri Mar 6 2015 Asser Lähdemäki <asser@lahdemaki.fi> - 0.1-1
- Initial release, with some bugs in generating codes
- Translations not working yet
