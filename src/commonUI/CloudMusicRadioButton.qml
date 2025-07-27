import QtQuick 2.15
import QtQuick.Controls 2.15
import "../basic"

RadioButton {
    id: autoLoginRatioBtn
    padding: 0
    spacing: 7
    text: ""
    checked: false
    // property bool isSelect: false
    property color textColor: "#818186"
    property int textSize: 18
    property bool isAlignTop: false
    // width: indicatorStyle.width + autoLoginRatioBtnText.width + spacing
    // height: Math.max(indicatorStyle.height, autoLoginRatioBtnText.height)

    //自定义单选框样式
    indicator: Rectangle {
        id: indicatorStyle
        y: !parent.isAlignTop ? (autoLoginRatioBtnText.height / 2 - indicatorStyle.height / 2) : 0
        width: 20
        height: width
        color: autoLoginRatioBtn.checked ? "#FF3A3A" : "transparent"
        radius: 5
        border {
            width: !autoLoginRatioBtn.checked ? 1 : 0
            color: "#76767C"
        }

        Text {
            anchors.centerIn: parent
            text: "✔"
            color: "white"
            visible: autoLoginRatioBtn.checked
        }
    }

    contentItem: Text {
        id: autoLoginRatioBtnText
        anchors.left: indicatorStyle.right
        anchors.leftMargin: parent.spacing
        topPadding: parent.isAlignTop ?  -indicatorStyle.radius : 0
        text: parent.text
        font.family: BasicConfig.fontFamily
        font.pixelSize: parent.textSize
        color: parent.textColor
        textFormat: Text.RichText
    }

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        hoverEnabled: true

        onClicked: {
            autoLoginRatioBtn.checked = !autoLoginRatioBtn.checked
        }

        onEntered: {
            if (!autoLoginRatioBtn.checked) {
                indicatorStyle.border.color = "white"
            }
        }

        onExited: {
            if (!autoLoginRatioBtn.checked) {
                indicatorStyle.border.color = "#76767C"
            }
        }
    }
}
