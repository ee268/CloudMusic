import QtQuick 2.15
import QtQuick.Controls 2.15

import "../basic"

RadioButton {
    id: radioBtn2
    padding: 0
    text: ""
    spacing: 7
    checked: false
    property color borderColor: radioBtn2.checked ? "#FF3A3A" : "#535358"
    property color textColor: "#89898D"
    property string iconSrc: ""

    indicator: Rectangle {
        id: subRepDlgIdct
        anchors.verticalCenter: radioBtn2.verticalCenter
        width: 19
        height: 19
        radius: width / 2
        color: "transparent"
        border {
            width: 1
            color: radioBtn2.borderColor
        }

        Rectangle {
            visible: radioBtn2.checked
            anchors.centerIn: parent
            width: parent.width / 2
            height: width
            radius: width / 2
            color: "#FF3A3A"
        }
    }

    contentItem: Text {
        id: subRepDlgText
        anchors.left: subRepDlgIdct.right
        anchors.leftMargin: parent.spacing
        verticalAlignment: Text.AlignVCenter
        text: radioBtn2.text
        color: parent.textColor
        font.family: BasicConfig.fontFamily
        font.pixelSize: 15

        Image {
            id: icon
            source: radioBtn2.iconSrc
            anchors.left: parent.left
            anchors.leftMargin: parent.width
            anchors.verticalCenter: parent.verticalCenter
        }
    }

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        hoverEnabled: true

        onEntered: {
            if (radioBtn2.checked) {
                subRepDlgIdct.border.color = "#FF3A3A"
            }
            else {
                subRepDlgIdct.border.color = "white"
            }
        }

        onExited: {
            if (radioBtn2.checked) {
                subRepDlgIdct.border.color = "#FF3A3A"
            }
            else {
                subRepDlgIdct.border.color = "#535358"
            }
        }

        onClicked: {
            if (radioBtn2.checked) {
                radioBtn2.checked = false
                subRepDlgIdct.border.color = "white"
            }
            else {
                radioBtn2.checked = true
                subRepDlgIdct.border.color = "#FF3A3A"
            }
        }
    }

    onCheckedChanged: {
        if (!radioBtn2.checked) {
            subRepDlgIdct.border.color = "#535358"
        }
        else {
            subRepDlgIdct.border.color = "#FF3A3A"
        }
    }
}
