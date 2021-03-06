/****************************************************************************
**
** Copyright (C) 2012 Digia Plc and/or its subsidiary(-ies).
** Contact: http://www.qt-project.org/legal
**
** This file is part of the QtSensors module of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:LGPL$
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and Digia.  For licensing terms and
** conditions see http://qt.digia.com/licensing.  For further information
** use the contact form at http://qt.digia.com/contact-us.
**
** GNU Lesser General Public License Usage
** Alternatively, this file may be used under the terms of the GNU Lesser
** General Public License version 2.1 as published by the Free Software
** Foundation and appearing in the file LICENSE.LGPL included in the
** packaging of this file.  Please review the following information to
** ensure the GNU Lesser General Public License version 2.1 requirements
** will be met: http://www.gnu.org/licenses/old-licenses/lgpl-2.1.html.
**
** In addition, as a special exception, Digia gives you certain additional
** rights.  These rights are described in the Digia Qt LGPL Exception
** version 1.1, included in the file LGPL_EXCEPTION.txt in this package.
**
** GNU General Public License Usage
** Alternatively, this file may be used under the terms of the GNU
** General Public License version 3.0 as published by the Free Software
** Foundation and appearing in the file LICENSE.GPL included in the
** packaging of this file.  Please review the following information to
** ensure the GNU General Public License version 3.0 requirements will be
** met: http://www.gnu.org/copyleft/gpl.html.
**
**
** $QT_END_LICENSE$
**
****************************************************************************/

#ifndef QTILTSENSOR_H
#define QTILTSENSOR_H

#include <QtSensors/qsensor.h>

QT_BEGIN_NAMESPACE

class QTiltReadingPrivate;

class Q_SENSORS_EXPORT QTiltReading : public QSensorReading
{
    Q_OBJECT
    Q_PROPERTY(qreal yRotation READ yRotation)
    Q_PROPERTY(qreal xRotation READ xRotation)
    DECLARE_READING(QTiltReading)

public:
    qreal yRotation() const;
    void setYRotation(qreal y);

    qreal xRotation() const;
    void setXRotation(qreal x);

};

class Q_SENSORS_EXPORT QTiltFilter : public QSensorFilter
{
public:
    virtual bool filter(QTiltReading *reading) = 0;
private:
    bool filter(QSensorReading *reading);
};

class Q_SENSORS_EXPORT QTiltSensor : public QSensor
{
    Q_OBJECT
public:
    explicit QTiltSensor(QObject *parent = 0);
    ~QTiltSensor();
    QTiltReading *reading() const;
    static char const * const type;

    Q_INVOKABLE void calibrate();

private:
    Q_DISABLE_COPY(QTiltSensor)
};

QT_END_NAMESPACE
#endif
