QMAKEVERSION = $$[QMAKE_VERSION]
ISQT5 = $$find(QMAKEVERSION, ^[2-9])

isEmpty( ISQT5 ) {
error("Use the qmake include with Qt5 or greater, on Debian that is qt5-qmake");
}

TEMPLATE = subdirs
SUBDIRS  = src
