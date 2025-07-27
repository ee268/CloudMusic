import QtQuick 2.15
import QtQuick.Controls 2.15
import "../basic"

ComboBox {
    id: fontSelectorCbx
    width: 180
    height: 35

    //显示文字
    property string text: currentText

    property real indicatorRotation: 90
    //count为comboBox自带属性，可获取有多少条数据
    property int avgHeight: count >= 8 ? 8 * 40 + 20: count * 40 + 20

    property bool isOpenPopup: false

    //自定义背景
    background: Rectangle {
        id: cbxBg
        radius: fontSelectorCbx.height / 2
        border.width: 1
        border.color: "#28282F"
        color: "#1A1A21"

        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor

            onPressed: {
                cbxBg.color = "#212127"
            }

            onReleased: {
                cbxBg.color = "#1A1A21"
            }

            onClicked: {
                if (!fontSelectorCbx.isOpenPopup) {
                    fontSelectorCbx.popup.open()
                }
                else {
                    fontSelectorCbx.popup.close()
                }
            }
        }
    }

    //自定义下拉指示器
    indicator: Label {
        text: ">"
        font.pixelSize: 22
        font.bold: true
        font.family: BasicConfig.fontFamily
        anchors.right: fontSelectorCbx.right
        anchors.rightMargin: 10
        anchors.verticalCenter: fontSelectorCbx.verticalCenter
        color: "#e9e9e9"
        rotation: fontSelectorCbx.indicatorRotation
    }

    //自定义下拉内容字体
    contentItem: Text {
        text: fontSelectorCbx.text
        color: "white"
        font.pixelSize: 18
        font.family: BasicConfig.fontFamily
        verticalAlignment: Text.AlignVCenter
        leftPadding: 15
    }

    popup: Popup {
        y: fontSelectorCbx.height + 5
        width: fontSelectorCbx.width
        height: fontSelectorCbx.avgHeight

        background: Rectangle {
            id: cbxPopupBg
            radius: 10
            color: "#2D2D38"
            border.width: 1
            border.color: "#42424C"

            ListView {
                anchors.topMargin: parent.radius
                anchors.bottomMargin: parent.radius
                anchors.fill: parent
                clip: true

                model: fontSelectorCbx.model

                //重写垂直滚动条样式
                ScrollBar.vertical: ScrollBar {
                    id: scrollbar
                    //滚动条位置
                    anchors.right: parent.right
                    anchors.rightMargin: 5
                    //滚动条宽度
                    width: 10
                    //滚动条形状自定义
                    contentItem: Rectangle {
                        //是否显示滚动条依据父控件是否活动
                        visible: count > 8
                        implicitWidth: 10
                        radius: 4
                        color: "#42424b"
                    }
                }

                delegate: Rectangle {
                    id: cbxPopupBgRect
                    width: cbxPopupBg.width - scrollbar.width - 7
                    height: 40
                    color: "transparent"

                    Text {
                        id: cbxPopupBgText
                        color: "#B9B9BD"
                        text: modelData
                        font.pixelSize: 16
                        anchors.left: parent.left
                        anchors.leftMargin: 10
                        anchors.verticalCenter: parent.verticalCenter
                        font.family: BasicConfig.fontFamily
                    }

                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor

                        onEntered: {
                            cbxPopupBgRect.color = "#393944"
                        }

                        onExited: {
                            cbxPopupBgRect.color = "transparent"
                        }

                        onClicked: {
                            fontSelectorCbx.text = modelData
                            fontSelectorCbx.popup.close()
                        }
                    }
                }
            }
        }

        onClosed: {
            fontSelectorCbx.indicatorRotation = 90
            fontSelectorCbx.isOpenPopup = false
        }

        onOpened: {
            fontSelectorCbx.indicatorRotation = -90
            fontSelectorCbx.isOpenPopup = true
        }
    }
}
