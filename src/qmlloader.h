/**
 * QuickFlickr - FlickrClient for mobile devices.
 *
 * Author: Marko Mattila (marko.mattila@d-pointer.com)
 *         http://www.d-pointer.com
 *
 *  QuickFlickr is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU Lesser General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or
 *  (at your option) any later version.
 *
 *  QuickFlickr is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU Lesser General Public License for more details.
 *
 *  You should have received a copy of the GNU Lesser General Public License
 *  along with QuickFLickr.  If not, see <http://www.gnu.org/licenses/>.
 */
#ifndef QMLLOADER_H
#define QMLLOADER_H


#include <QtQuick/QQuickView>

class FlickrManager;
class QmlLoader: public QQuickView
{
    Q_OBJECT
public:
    QmlLoader();
    virtual ~QmlLoader();
    
public slots:
    void minimize();
    
private:
    FlickrManager    * m_flickrManager;    
};

#endif // QMLLOADER_H
