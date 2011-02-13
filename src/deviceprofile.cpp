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
#if defined(Q_WS_MAC) || defined(Q_WS_X11)
        m_displaySize.setWidth(360);
        m_displaySize.setHeight(640);
#else
    //m_displaySize = qApp->desktop()->screenGeometry().size();
    m_displaySize.setWidth(360);
    m_displaySize.setHeight(640);
#endif
}
