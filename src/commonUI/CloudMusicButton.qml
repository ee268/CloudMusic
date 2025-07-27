import QtQuick 2.15
import QtQuick.Controls 2.15
import "../basic"

Rectangle {
    width: 95
    height: 35
    border {
        width: 1
        color: "#525257"
    }
    radius: height / 2
    color: "transparent"
    property string text: ""

    Label {
        anchors.centerIn: parent
        text: parent.text
        font.pixelSize: 18
        font.family: BasicConfig.fontFamily
        color: "white"
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor

        onEntered: {
            parent.color = "#1A1A21"
        }

        onExited: {
            parent.color = "transparent"
        }
    }
}
