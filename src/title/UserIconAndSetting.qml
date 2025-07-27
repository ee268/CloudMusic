import QtQuick 2.15
import QtGraphicalEffects 1.15
import "../basic"

Row {

    //头像
    Item {
        anchors.verticalCenter: parent.verticalCenter
        width: 36
        height: 36

        // 原始图片（隐藏）
        Image {
            id: img
            anchors.fill: parent
            source: "qrc:/resources/title/avatar.jpg"
            visible: false
        }

        // 圆形遮罩
        Rectangle {
            id: mask
            anchors.fill: parent
            radius: width / 2
            visible: false
        }

        // 应用遮罩
        OpacityMask {
            anchors.fill: parent
            source: img
            maskSource: mask
        }
    }

    //昵称
    Text {
        id: nameText
        anchors.verticalCenter: parent.verticalCenter
        text: "726-8"
        color: "#B9B9BB"
        font.pixelSize: 20

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor

            onEntered: {
                parent.color = "white"
            }

            onExited: {
                parent.color = "#B9B9BB"
            }

            onClicked: {
                //触发打开登录弹窗信号
                BasicConfig.openLoginPopup()
            }
        }
    }

    //vip图标
    Image {
        id: vipImg
        anchors.verticalCenter: parent.verticalCenter
        source: "qrc:/resources/title/vip.png"
    }

    //个人信息下拉
    Image {
        id: arrowImg
        anchors.verticalCenter: parent.verticalCenter
        source: "qrc:/resources/title/arrow.png"
        rotation: -90
        layer.enabled: false //默认不开启
        layer.effect: ColorOverlay { //颜色叠加
            source: arrowImg
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
        }
    }

    //消息
    Image {
        id: msgImg
        anchors.verticalCenter: parent.verticalCenter
        source: "qrc:/resources/title/message.png"
        scale: 0.7
        layer.enabled: false //默认不开启
        layer.effect: ColorOverlay { //颜色叠加
            source: msgImg
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
        }
    }

    //设置
    Image {
        id: settingImg
        anchors.verticalCenter: parent.verticalCenter
        source: "qrc:/resources/title/setting.png"
        scale: 0.7
        layer.enabled: false //默认不开启
        layer.effect: ColorOverlay { //颜色叠加
            source: settingImg
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
                mainStakView.push("qrc:/src/rightPage/stakPages/Setting.qml")
            }
        }
    }

    //换肤
    Image {
        id: skinImg
        anchors.verticalCenter: parent.verticalCenter
        source: "qrc:/resources/title/skin.png"
        scale: 0.7
        layer.enabled: false //默认不开启
        layer.effect: ColorOverlay { //颜色叠加
            source: skinImg
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
        }
    }

    //分隔线
    Rectangle {
        anchors.verticalCenter: parent.verticalCenter
        height: title.height / 2
        width: 1
        color: "#2B2B31"
    }
}
