import QtQuick 2.15
import QtGraphicalEffects 1.15
import "../basic"

Row {
    id: miniMax

    spacing: 15

    //隐藏到系统托盘
    Image {
        id: hideImg
        anchors.verticalCenter: parent.verticalCenter
        source: "/resources/title/hide.png"
        layer.enabled: false //默认不开启
        layer.effect: ColorOverlay { //颜色叠加
            source: hideImg
            color: "white"
        }

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor

            //鼠标移入移出变色
            onEntered: {
                parent.layer.enabled = true
            }
            onExited: {
                parent.layer.enabled = false
            }

            onClicked: {
                window.hide()
            }
        }
    }

    //最小化
    Image {
        id: miniImg
        anchors.verticalCenter: parent.verticalCenter
        source: "/resources/title/mini.png"
        layer.enabled: false //默认不开启
        layer.effect: ColorOverlay { //颜色叠加
            source: miniImg
            color: "white"
        }

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor

            //鼠标移入移出变色
            onEntered: {
                parent.layer.enabled = true
            }
            onExited: {
                parent.layer.enabled = false
            }

            onClicked: {
                window.showMinimized()
            }
        }
    }

    //最大化
    Image {
        id: maxImg
        anchors.verticalCenter: parent.verticalCenter
        source: BasicConfig.maxImgUrl
        layer.enabled: false //默认不开启
        layer.effect: ColorOverlay { //颜色叠加
            source: maxImg
            color: "white"
        }

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor

            //鼠标移入移出变色
            onEntered: {
                parent.layer.enabled = true
            }
            onExited: {
                parent.layer.enabled = false
            }

            onClicked: {
                if (BasicConfig.isWindowMax) {
                    BasicConfig.maxImgUrl = "qrc:/resources/title/max.png"
                    BasicConfig.isWindowMax = false
                    window.showNormal()
                    return
                }

                BasicConfig.maxImgUrl = "qrc:/resources/title/maxed.png"
                window.showMaximized()
                BasicConfig.isWindowMax = true
            }
        }
    }

    //关闭
    Image {
        id: closeImg
        anchors.verticalCenter: parent.verticalCenter
        source: "/resources/title/close.png"
        layer.enabled: false //默认不开启
        layer.effect: ColorOverlay { //颜色叠加
            source: closeImg
            color: "white"
        }

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor

            //鼠标移入移出变色
            onEntered: {
                parent.layer.enabled = true
            }
            onExited: {
                parent.layer.enabled = false
            }

            onClicked: {
                Qt.quit()
            }
        }
    }
}
