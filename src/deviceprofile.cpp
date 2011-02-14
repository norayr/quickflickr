#include "deviceprofile.h"
#include <QApplication>
#include <QDesktopWidget>


DeviceProfile * DeviceProfile::instance()
{
    static DeviceProfile instance;
    return &instance;
}


int DeviceProfile::displayWidth() const
{
    return m_displaySize.width();
}

int DeviceProfile::displayHeight() const
{
    return m_displaySize.height();
}

DeviceProfile::DeviceProfile(QObject *parent) :
    QObject(parent)
{
#if defined(Q_WS_MAEMO_5)
        m_displaySize.setWidth( qApp->desktop()->screenGeometry().size().height());
        m_displaySize.setHeight( qApp->desktop()->screenGeometry().size().width());
        return;
#endif
#if defined(Q_WS_MAC) || defined(Q_WS_X11)
        m_displaySize.setWidth(360);
        m_displaySize.setHeight(640);
#else
    m_displaySize = qApp->desktop()->screenGeometry().size();
#endif
}
