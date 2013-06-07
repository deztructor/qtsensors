/****************************************************************************
**
** Copyright (C) 2012 Digia Plc and/or its subsidiary(-ies).
** Contact: http://www.qt-project.org/legal
**
** This file is part of the QtSensors module of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:BSD$
** You may use this file under the terms of the BSD license as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are
** met:
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in
**     the documentation and/or other materials provided with the
**     distribution.
**   * Neither the name of Digia Plc and its Subsidiary(-ies) nor the names
**     of its contributors may be used to endorse or promote products derived
**     from this software without specific prior written permission.
**
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
**
** $QT_END_LICENSE$
**
****************************************************************************/

/* Layout
                                                                                  mainWnd
                                                                                 /
---------------------------------------------------------------------------------
|--------------------------------------------------------------------------------
||                                  labelTitle                                  |
|--------------------------------------------------------------------------------
|-------------------------------------------------------------------------------- <---- tiltLine
|--------------------------------------------------------------------------------
||                                  labelTilt                                   |
|--------------------------------------------------------------------------------
|         / accuracyRect                               / speedRect
|-------------------------------------------||----------------------------------|
|| Accuracy <----- textAccuracy             || Speed <-----textSpeed            |
||  value   <- textAccuracyValue            ||  value    <- textSpeedValue      |
|| ----------------- ------------------     || --------------- ---------------- |
|| | accuracyLower | | accuracyHigher |     || | speedLower  | | speedHigher  | |
|| ----------------- ------------------     || --------------- ---------------- |
|------------------------------------------ ||----------------------------------|
| -----------
| |Calibrate|    <------------------ calibrate
| -----------
| ---------
| |Degree |    <-------------------- useRadian                   X Rotation: 0  <------------------ xrottext
| ---------
| ---------
| |Start  |    <-------------------- tiltStart                   Y Rotation: 0  <------------------ yrottext
| ---------
|-------------------------------------------------------------------------------- <---- ambientlightLine
|--------------------------------------------------------------------------------
||                                  labelAmbientLight                           |
|--------------------------------------------------------------------------------
| ---------
| |Start  |    <-------------------- ablStart                    Ambient light: -  <--------------- abltext
| ---------
|-------------------------------------------------------------------------------- <---- proximityLine
|--------------------------------------------------------------------------------
||                                  labelProximityLight                           |
|--------------------------------------------------------------------------------
| ---------
| |Start  |    <-------------------- proxiStart                  Proximity: -  <--------------- proxitext
| ---------
------------------------------------------------------------------------------
*/

//Import the declarative plugins
import QtQuick 2.0
import "components"

//! [0]
import QtSensors 5.0
//! [0]

ApplicationWindow {
    id: appWnd

    Rectangle {
        id: mainWnd
        x: 0
        y: 0
        width: 320
        height: 480
        color: "transparent"

        property string speed: "Slow"

        Text {
            id: labelTitle
            anchors.top: mainWnd.top
            anchors.topMargin: 5
            anchors.left: mainWnd.left
            anchors.right: mainWnd.right

            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 30
            font.bold: true
            text: "QML QtSensors"
        }

        //Tile region

        Rectangle {
            id: tiltLine
            anchors.top: labelTitle.bottom
            anchors.topMargin: 5
            anchors.left: mainWnd.left
            anchors.leftMargin: 5
            anchors.right: mainWnd.right
            anchors.rightMargin: 5
            border.width: 1
            height: 1
            border.color: "#888888"
        }

        Text {
            id: labelTilt
            anchors.top: tiltLine.bottom
            anchors.topMargin: 5
            anchors.left: mainWnd.left
            anchors.right: mainWnd.right

            horizontalAlignment: Text.AlignHCenter
            font.bold: true
            text: "TiltSensor"
        }

//! [1]
        TiltSensor {
            id: tilt
            active: false
        }
//! [1]

        Rectangle {
            Button {
                id: calibrate
                anchors.left: mainWnd.left
                anchors.leftMargin: 5
                anchors.top: speedRect.bottom
                height: 30
                width: 80
                text: "Calibrate"

                onClicked:{
                    tilt.calibrate();
                }
            }

            Button {
                id: tiltStart
                anchors.top: calibrate.bottom
                anchors.left: mainWnd.left
                anchors.leftMargin: 5
                height: 30
                width: 80
                text: tilt.active ? "Stop" : "Start"

                onClicked:{
//! [2]
                    tilt.active = (tiltStart.text === "Start");
//! [2]
                }
            }

            Text {
                id: xrottext
                anchors.right: mainWnd.right
                anchors.rightMargin: 5
                anchors.left: useRadian.right
                anchors.leftMargin: 15
                anchors.top: useRadian.top
                anchors.bottom: useRadian.bottom
                verticalAlignment: Text.AlignVCenter
//! [3]
                text: "X Rotation: " + tilt.xRotation + "°"
//! [3]
            }

            Text {
                id: yrottext
                anchors.right: mainWnd.right
                anchors.rightMargin: 5
                anchors.left: tiltStart.right
                anchors.leftMargin: 15
                anchors.top: tiltStart.top
                anchors.bottom: tiltStart.bottom
                verticalAlignment: Text.AlignVCenter
//! [4]
                text: "Y Rotation: " + tilt.yRotation +  "°"
//! [4]
            }

            //Ambient Light region

            Rectangle {
                id: ambientlightLine
                anchors.top: tiltStart.bottom
                anchors.topMargin: 5
                anchors.left: mainWnd.left
                anchors.leftMargin: 5
                anchors.right: mainWnd.right
                anchors.rightMargin: 5
                border.width: 1
                height: 1
                border.color: "#888888"
            }

            Text {
                id: labelAmbientLight
                anchors.top: ambientlightLine.bottom
                anchors.topMargin: 5
                anchors.left: mainWnd.left
                anchors.right: mainWnd.right

                horizontalAlignment: Text.AlignHCenter
                font.bold: true
                text: "AmbientLightSensor"
            }

            AmbientLightSensor {
                id: ambientlight
                active: false
//! [5]
                onReadingChanged: {
                    if (reading.lightLevel == AmbientLightSensor.Unknown)
                        ambientlighttext.text = "Ambient light: Unknown";
                    else if (reading.lightLevel == AmbientLightSensor.Dark)
                        ambientlighttext.text = "Ambient light: Dark";
                    else if (reading.lightLevel == AmbientLightSensor.Twilight)
                        ambientlighttext.text = "Ambient light: Twilight";
                    else if (reading.lightLevel == AmbientLightSensor.Light)
                        ambientlighttext.text = "Ambient light: Light";
                    else if (reading.lightLevel == AmbientLightSensor.Bright)
                        ambientlighttext.text = "Ambient light: Bright";
                    else if (reading.lightLevel == AmbientLightSensor.Sunny)
                        ambientlighttext.text = "Ambient light: Sunny";
                }
//! [5]
            }

            Button{
                id: ambientlightStart
                anchors.top: labelAmbientLight.bottom
                anchors.topMargin: 5
                anchors.left: mainWnd.left
                anchors.leftMargin: 5
                height: 30
                width: 80
                text: ambientlight.active ? "Stop" : "Start"

                onClicked: {
                    ambientlight.active = (ambientlightStart.text === "Start"  ? true: false);
                }
            }

            Text {
                id: ambientlighttext
                anchors.left: ambientlightStart.right
                anchors.leftMargin: 15
                anchors.top: ambientlightStart.top
                anchors.bottom: ambientlightStart.bottom
                verticalAlignment: Text.AlignVCenter
                text: "Ambient light: -"
            }

            //Proximity region

            Rectangle {
                id: proximityLine
                anchors.top: ambientlightStart.bottom
                anchors.topMargin: 5
                anchors.left: mainWnd.left
                anchors.leftMargin: 5
                anchors.right: mainWnd.right
                anchors.rightMargin: 5
                border.width: 1
                height: 1
                border.color: "#888888"
            }

            Text {
                id: labelProximityLight
                anchors.top: proximityLine.bottom
                anchors.topMargin: 5
                anchors.left: mainWnd.left
                anchors.right: mainWnd.right
                horizontalAlignment: Text.AlignHCenter
                font.bold: true
                text: "ProximitySensor"
            }

            ProximitySensor {
                id: proxi
                active: false
            }

            Button{
                id: proxiStart
                anchors.top: labelProximityLight.bottom
                anchors.topMargin: 5
                anchors.left: mainWnd.left
                anchors.leftMargin: 5
                height: 30
                width: 80
                text: proxi.active ? "Stop" : "Start"

                onClicked: {
                    proxi.active = (proxiStart.text === "Start"  ? true: false);
                }
            }

            Text {
                id: proxitext
                anchors.left: proxiStart.right
                anchors.leftMargin: 15
                anchors.top: proxiStart.top
                anchors.bottom: proxiStart.bottom
                verticalAlignment: Text.AlignVCenter
//! [6]
                text: "Proximity: " + (proxi.reading.near ? "near" : "far")
//! [6]
            }
        }
    }
}
