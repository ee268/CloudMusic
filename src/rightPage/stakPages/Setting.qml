import QtQuick 2.15
import QtQuick.Controls 2.15
import "../../basic"
import "./settingItem"

Item {
    MouseArea {
        anchors.fill: parent
        propagateComposedEvents: true

        onClicked: {
            parent.forceActiveFocus()
            mouse.accepted = false
        }
    }

    Item {
        anchors.fill: parent
        anchors.leftMargin: 24
        anchors.topMargin: 24

        //设置标题
        Label {
            id: settingMainTitle
            color: "white"
            font.bold: true
            text: "设置"
            font.family: BasicConfig.fontFamily
            font.pixelSize: 32
            anchors.left: parent.left
            anchors.top: parent.top
        }

        //设置的子标题
        Flow {
            id: settingTitleFlow
            anchors.left: settingMainTitle.left
            anchors.top: settingMainTitle.bottom
            anchors.topMargin: 25
            height: 25
            spacing: 20

            Repeater {
                id: selectorRep
                anchors.fill: parent
                model: ["账号","常规","系统","播放","消息与隐私","快捷键","音质与下载","桌面歌词","工具","关于云音乐"]
                property int selectedIndex: 0

                delegate: Item {
                    id: selectorItem
                    width: selectorLabel.implicitWidth
                    height: 40
                    property bool isHovered: false

                    Label {
                        id: selectorLabel
                        text: modelData
                        color: {
                            if (selectorRep.selectedIndex === index) {
                                return "white"
                            }
                            else if(selectorItem.isHovered) {
                                return "#B8B8BA"
                            }
                            else if(!selectorItem.isHovered) {
                                return "#A1A1A3"
                            }
                        }
                        font.pixelSize: 20
                        font.bold: true
                        font.family: BasicConfig.fontFamily
                        anchors.centerIn: parent
                    }

                    Rectangle {
                        visible: selectorRep.selectedIndex === index
                        anchors.top: selectorLabel.bottom
                        anchors.topMargin: 3
                        anchors.horizontalCenter: selectorLabel.horizontalCenter
                        width: selectorLabel.width * 0.8
                        height: 3
                        color: "#eb4d44"
                    }

                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        hoverEnabled: true

                        onEntered: {
                            selectorItem.isHovered = true
                        }

                        onExited: {
                            selectorItem.isHovered = false
                        }

                        onClicked: {
                            selectorRep.selectedIndex = index
                        }
                    }
                }
            }
        }

        //设置的子标题的分隔线
        Rectangle {
            id: tileSplitLine
            anchors.top: settingTitleFlow.bottom
            anchors.topMargin: settingTitleFlow.height
            anchors.left: parent.left
            width: parent.width * 0.9
            height: 1
            color: "#212127"
        }

        Flickable {
            id: flickId
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: tileSplitLine.bottom
            anchors.bottom: parent.bottom
            anchors.topMargin: 10

            clip: true
            //内容高度
            contentHeight: 4800
            //重写垂直滚动条样式
            ScrollBar.vertical: ScrollBar {
                //滚动条位置
                anchors.right: parent.right
                anchors.rightMargin: 5
                //滚动条宽度
                width: 10
                //滚动条形状自定义
                contentItem: Rectangle {
                    //是否显示滚动条依据父控件是否活动
                    visible: parent.active
                    implicitWidth: 10
                    radius: 4
                    color: "#42424b"
                }
            }

            Column {
                anchors.fill: parent
                anchors.topMargin: 30
                spacing: 30

                //账户设置
                Account {
                    id: accountSetting
                }

                //常规设置
                Regular {
                    id: regularSetting
                }

                //系统设置
                System {
                    id: systemSetting
                }

                //播放设置
                Play {
                    id: playSetting
                }

                //消息与隐私设置
                MsgAndPrivacy {
                    id: msgAndPrivacySetting
                }

                //快捷键设置
                QuickKey {
                    id: quickKeySetting
                }

                //音质与下载
                QualityAndDownLoad {
                    id: qualityAndDownLoadSetting
                }

                //桌面与歌词设置
                DesktopAndLyric {
                    id: desktopAndLyricSetting
                }

                //工具设置
                Tools {
                    id: toolsSetting
                }

                //关于云音乐
                AboutCloudMusic {
                    id: aboutSetting
                }
            }
        }
    }
}
