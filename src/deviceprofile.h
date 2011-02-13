#ifndef DEVICEPROFILE_H
#define DEVICEPROFILE_H

#include <QObject>
#include <QSize>

class DeviceProfile : public QObject
{
    Q_OBJECT
public:
    static DeviceProfile * instance();
    Q_INVOKABLE int displayWidth() const;
    Q_INVOKABLE int displayHeight() const;

protected:
    explicit DeviceProfile(QObject *parent = 0);
private:
    QSize m_displaySize;

};

#endif // DEVICEPROFILE_H
