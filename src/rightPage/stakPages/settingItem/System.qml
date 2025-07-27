import QtQuick 2.15
import QtQuick.Controls 2.15
import "../../../basic"
import "../../../commonUI"

Column {
    spacing: BasicConfig.settingItemSplitLineTopMargin

    Row {
        spacing: BasicConfig.settingTitleRightMargin

        Label {
            id: systemTitleLabel
            text: "系统"
            width: 150
            font.pixelSize: 22
            font.bold: true
            font.family: BasicConfig.fontFamily
            color: "white"
        }

        Column {
            spacing: 30

            ButtonGroup {
                id: timerBtnGroup
                exclusive: false
            }

            //开启定时关闭
            CloudMusicRadioButton {
                id: openTimerClose
                ButtonGroup.group: timerBtnGroup
                text: "开启定时关闭软件"
                textColor: "white"
                textSize: 20

                onCheckedChanged: {
                    if (openTimerClose.checked) {
                        closeAndShutdown.opacity = 1
                        closeAndShutdownMouse.cursorShape = Qt.PointingHandCursor
                    }
                    else {
                        closeAndShutdown.opacity = 0.3
                        closeAndShutdown.checked = false
                        closeAndShutdownMouse.cursorShape = Qt.ForbiddenCursor
                    }
                }
            }

            //设置关闭时间
            Row {
                id: setCloseTimeRow
                spacing: 10

                Label {
                    anchors.verticalCenter: parent.verticalCenter
                    text: "剩余关闭时间"
                    color: "white"
                    font.family: BasicConfig.fontFamily
                    font.pixelSize: openTimerClose.textSize
                }

                CloudMusicSettingComboBox {
                    text: "0"
                    model: ListModel{}
                    anchors.verticalCenter: parent.verticalCenter
                    Component.onCompleted: {
                        for(let i = 0; i < 24; i++) {
                            model.append({ hour: i })
                        }
                    }
                }

                Label {
                    anchors.verticalCenter: parent.verticalCenter
                    text: "小时"
                    color: "white"
                    font.family: BasicConfig.fontFamily
                    font.pixelSize: openTimerClose.textSize
                }

                CloudMusicSettingComboBox {
                    text: "0"
                    model: ListModel{}
                    anchors.verticalCenter: parent.verticalCenter
                    Component.onCompleted: {
                        for(let i = 0; i < 60; i++) {
                            model.append({ minute: i })
                        }
                    }
                }
            }


            //关闭时关机
            CloudMusicRadioButton {
                id: closeAndShutdown
                ButtonGroup.group: timerBtnGroup
                text: "关闭软件同时关机"
                textColor: "#89898D"
                textSize: 20
                opacity: 0.3

                MouseArea {
                    id: closeAndShutdownMouse
                    anchors.fill: parent
                    cursorShape: Qt.ForbiddenCursor

                    onClicked: {
                        if (openTimerClose.checked) {
                            closeAndShutdown.checked = !closeAndShutdown.checked
                        }
                    }
                }
            }

            Row {
                spacing: 40

                Label {
                    anchors.verticalCenter: parent.verticalCenter
                    text: "关闭主面板"
                    color: "white"
                    font.family: BasicConfig.fontFamily
                    font.pixelSize: openTimerClose.textSize
                }

                ButtonGroup {
                    id: btnGrp
                    exclusive: true
                }

                CloudMusicRadioButton2 {
                    anchors.verticalCenter: parent.verticalCenter
                    text: "最小化到系统托盘"
                    checked: true
                    ButtonGroup.group: btnGrp
                }

                CloudMusicRadioButton2 {
                    anchors.verticalCenter: parent.verticalCenter
                    text: "退出云音乐"
                    ButtonGroup.group: btnGrp
                }
            }
        }
    }

    //分隔线
    Rectangle {
        id: systemSplitLine
        width: tileSplitLine.width
        height: 1
        color: "#212127"
    }
}
