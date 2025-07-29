import QtQuick 2.15
import QtQuick.Controls 2.15
import Qt.labs.platform 1.1
import "../basic"

Popup {
    id: lyricColorPopup

    Overlay.modal: Rectangle {
        color: "transparent"
    }

    enter: Transition {
        NumberAnimation {
            property: "scale"
            from: 0.0
            to: 1.0
            duration: 150
        }
    }

    exit: Transition {
        NumberAnimation {
            property: "scale"
            from: 1.0
            to: 0.0
            duration: 150
        }
    }

    ColorDialog {
        id: colorDialog
        title: "颜色"

        onAccepted: {
            if (priObj.setColorType === 0) {
                priObj.downColor = currentColor
            }
            else if (priObj.setColorType === 1) {
                priObj.upColor = currentColor
            }
            else if (priObj.setColorType === 2) {
                priObj.borderColor = currentColor
            }
        }
    }

    QtObject {
        id: priObj
        property int setColorType: -1 //0为上渐变、1为下渐变、2为描边
        property color upColor: BasicConfig.openLyricColorPopupModel === 0 ?
                                    BasicConfig.finishedLyricsUpColor : BasicConfig.unFinishedLyricsUpColor

        property color downColor: BasicConfig.openLyricColorPopupModel === 0 ?
                                      BasicConfig.finishedLyricsDownColor : BasicConfig.unFinishedLyricsDownColor

        property color borderColor: BasicConfig.openLyricColorPopupModel === 0 ?
                                        BasicConfig.finishedLyricsBorderColor : BasicConfig.unFinishedLyricsBorderColor
    }

    onOpened: {
        priObj.upColor=BasicConfig.openLyricColorPopupModel === 0        ?  BasicConfig.finishedLyricsUpColor    : BasicConfig.unFinishedLyricsUpColor
        priObj.downColor=BasicConfig.openLyricColorPopupModel === 0  ?  BasicConfig.finishedLyricsDownColor  : BasicConfig.unFinishedLyricsDownColor
        priObj.borderColor=BasicConfig.openLyricColorPopupModel === 0    ?  BasicConfig.finishedLyricsBorderColor: BasicConfig.unFinishedLyricsBorderColor
    }

    background: Rectangle {
        radius: 20
        color: "#2D2D38"

        // 关闭图标
        Image {
            id: closeIcon
            scale: 1.4
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.topMargin: 30
            anchors.rightMargin: 30
            source: "qrc:/resources/title/close.png"

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor

                onClicked: {
                    lyricColorPopup.close()
                }
            }
        }

        //窗口标题
        Label {
            id: colorPopupTitle
            anchors {
                top: closeIcon.bottom
                topMargin: 10
                horizontalCenter: parent.horizontalCenter
            }
            text: `更改「${ BasicConfig.openLyricColorPopupModel === 0 ? "已播放" : "未播放" }」配色方案`
            color: "white"
            font.bold: true
            font.pixelSize: 32
            font.family: BasicConfig.fontFamily
        }

        //设置颜色渐变
        Row {
            id: setColorRow
            anchors {
                top: colorPopupTitle.bottom
                topMargin: 60
                horizontalCenter: parent.horizontalCenter
            }
            spacing: 30

            Rectangle {
                width: 50
                height: 50
                radius: 6
                border {
                    width: 1
                    color: priObj.borderColor
                }
                gradient: Gradient {
                    orientation: Gradient.Vertical

                    GradientStop {
                        color: priObj.downColor
                        position: 0
                    }
                    GradientStop {
                        color: priObj.upColor
                        position: 1
                    }
                }
            }

            Repeater {
                model: ["渐变上", "渐变下", "描边"]

                delegate: Rectangle {
                    width: 130
                    height: 50
                    radius: height / 2
                    color: "#34343E"
                    border {
                        width: 1
                        color: "#3A3A44"
                    }

                    Row {
                        spacing: 5
                        anchors.centerIn: parent

                        Rectangle {
                            width: 20
                            height: 20
                            radius: 3
                            color: index === 0 ? priObj.downColor : (index === 1 ? priObj.upColor : priObj.borderColor)
                            // color: priObj.downColor
                            anchors.verticalCenter: parent.verticalCenter
                        }

                        Label {
                            text: modelData
                            font.pixelSize: 20
                            font.family: BasicConfig.fontFamily
                            color: "#ddd"
                            anchors.verticalCenter: parent.verticalCenter
                        }
                    }

                    MouseArea {
                        anchors.fill: parent

                        onClicked: {
                            priObj.setColorType = index
                            colorDialog.open()
                        }
                    }
                }
            }
        }

        //确认按钮
        Item {
            anchors {
                top: setColorRow.bottom
                left: parent.left
                right: parent.right
                bottom: parent.bottom
            }

            Rectangle {
                id: closeColorPopupBtn
                anchors.centerIn: parent
                width: 220
                height: 44
                radius: height / 2
                color: "#FC3D49"

                Label {
                    anchors.centerIn: parent
                    text: "确认"
                    color: "white"
                    font.pixelSize: 20
                    font.family: BasicConfig.fontFamily
                }

                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    hoverEnabled: true

                    onEntered: {
                        closeColorPopupBtn.opacity = 0.9
                    }

                    onExited: {
                        closeColorPopupBtn.opacity = 1
                    }

                    onPressed: {
                        closeColorPopupBtn.scale = 0.95
                    }

                    onReleased: {
                        closeColorPopupBtn.scale = 1
                    }

                    onClicked: {
                        if (BasicConfig.openLyricColorPopupModel === 0) {
                            BasicConfig.finishedLyricsUpColor = priObj.upColor
                            BasicConfig.finishedLyricsDownColor = priObj.downColor
                            BasicConfig.finishedLyricsBorderColor = priObj.borderColor
                        }
                        else if (BasicConfig.openLyricColorPopupModel === 1) {
                            BasicConfig.unFinishedLyricsUpColor = priObj.upColor
                            BasicConfig.unFinishedLyricsDownColor = priObj.downColor
                            BasicConfig.unFinishedLyricsBorderColor = priObj.borderColor
                        }

                        console.log("yibofang ", BasicConfig.finishedLyricsUpColor, BasicConfig.finishedLyricsDownColor, BasicConfig.finishedLyricsBorderColor)
                        console.log("weibofang ", BasicConfig.unFinishedLyricsUpColor, BasicConfig.unFinishedLyricsDownColor, BasicConfig.unFinishedLyricsBorderColor)
                        lyricColorPopup.close()
                    }
                }
            }
        }
    }
}
