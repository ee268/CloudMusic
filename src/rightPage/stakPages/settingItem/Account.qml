import QtQuick 2.15
import QtQuick.Controls 2.15
import "../../../basic"

//账户设置
Column {
    spacing: BasicConfig.settingItemSplitLineTopMargin

    Row {
        spacing: BasicConfig.settingTitleRightMargin

        Label {
            id: accountTitleLabel
            text: "账号"
            width: 150
            font.pixelSize: 22
            font.bold: true
            font.family: BasicConfig.fontFamily
            color: "white"
        }

        Column {
            spacing: 20

            Label {
                id: accountDiscriptionLabel
                text: "登录云音乐，手机电脑多端同步，320k高音质无线下载"
                font.pixelSize: 18
                font.family: BasicConfig.fontFamily
                color: "#e8e8e8"
            }

            //立即登录按钮
            Rectangle {
                id: immediateLoginBtn
                width: 100
                height: 30
                radius: 15
                color: "#e84d5f"

                Label {
                    text: "立即登录"
                    font.pixelSize: 18
                    font.family: BasicConfig.fontFamily
                    anchors.centerIn: parent
                    color: "white"
                }

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor

                    onEntered: {
                        parent.opacity = 0.8
                    }
                    onExited: {
                        parent.opacity = 1
                    }
                }
            }
        }
    }

    //分隔线
    Rectangle {
        id: accountSplitLine
        width: tileSplitLine.width
        height: 1
        color: "#212127"
    }
}
