import QtQuick 2.15
import QtQuick.Controls 2.15
import "../../basic"

Rectangle {
    id: popupBg
    // color: "#1b1b23"
    gradient: Gradient {
        orientation: Gradient.Vertical
        GradientStop { color: "#21151B"; position: 0 }
        GradientStop { color: "#13131A"; position: 1 }
    }

    radius: 10
    border.width: 1
    border.color: "#39393D"

    // 关闭图标
    Image {
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
                BasicConfig.closeLoginPopup()
            }
        }
    }

    // 登录标题
    Label {
        id: loginText
        text: "扫码登录"
        color: "white"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 100
        font.bold: true
        font.family: BasicConfig.fontFamily
        font.pixelSize: 32
    }

    // 扫码登录
    Item {
        id: loginImgRow
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: loginText.bottom
        anchors.topMargin: 30
        height: tipImg.height
        property int imgSpacing: 15
        property int tipImgPosX: (parent.width - (tipImg.width + qrCodeImg.width + imgSpacing)) / 2
        property int qrCodeImgPosX: tipImgPosX + tipImg.width + imgSpacing

        Rectangle {
            id: tipImg
            x: parent.tipImgPosX
            width: 171
            height: 293

            Image {
                anchors.fill: parent
                source: "qrc:/resources/loginPoup/loginTip.jpg"
            }

            Component.onCompleted: {
                parent.qrCodeImgPosX = parent.tipImgPosX + width + parent.imgSpacing
            }
        }

        Rectangle {
            id: qrCodeImg
            x: parent.qrCodeImgPosX
            width: 170
            height: width

            Image {
                anchors.fill: parent
                // anchors.verticalCenter: parent.verticalCenter
                source: "qrc:/resources/loginPoup/qrCode.png"

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true

                    onEntered: {
                        showTipImgAni.start()

                        //二维码文字样式和位置修改
                        qrCodeTextRow.width = innerRow.width + codeLoginText.width + 5
                        qrCodeTextRow.anchors.topMargin = qrCodeImg.height / 4
                        useText.color = "#bababc"
                        codeLoginText.color = "#bababc"
                        appText.color = "white"
                        codeLoginText.x = innerRow.x + innerRow.width + 5
                        codeLoginText.y = innerRow.y
                    }

                    onExited: {
                        unShowTipImgAni.start()

                        //二维码文字样式和位置还原
                        qrCodeTextRow.width = innerRow.width
                        qrCodeTextRow.anchors.topMargin = 10
                        useText.color = "white"
                        codeLoginText.color = "white"
                        appText.color = "cornflowerblue"
                        codeLoginText.x = (innerRow.width - codeLoginText.width) / 2
                        codeLoginText.y = innerRow.y + innerRow.height + 5
                    }
                }

                Component.onCompleted:  {
                    // 解决tipImg改变x时把qrCodeImg推动的问题
                    loginImgRow.qrCodeImgPosX = x
                }
            }
        }

        // 二维码显示
        ParallelAnimation {
            id: showTipImgAni

            // 二维码移动到中间
            NumberAnimation {
                id: qrCodeXAni
                target: qrCodeImg
                properties: "x"
                // from: qrCodeImg.x
                to: (popupBg.width - qrCodeImg.width) / 2
                duration: BasicConfig.loginPopupCodeAniDuration
            }
            NumberAnimation {
                id: qrCodeYAni
                target: qrCodeImg
                property: "y"
                to: (loginImgRow.height - qrCodeImg.height) / 2
                duration: BasicConfig.loginPopupCodeAniDuration
            }

            // 二维码移动到中间时放大
            NumberAnimation {
                id: qrCodeScaleAni
                target: qrCodeImg
                properties: "scale"
                // from: qrCodeImg.scale
                to: 1.4
                duration: BasicConfig.loginPopupCodeAniDuration
            }

            // 扫码提示图片移动到中间
            NumberAnimation {
                id: tipImgXAni
                target: tipImg
                properties: "x"
                to: (popupBg.width - tipImg.width) / 2
                duration: BasicConfig.loginPopupCodeAniDuration
            }

            // 扫码提示图片移动时透明度变化
            NumberAnimation {
                id: tipImgOpacityAni
                target: tipImg
                properties: "opacity"
                to: 0
                duration: BasicConfig.loginPopupCodeAniDuration
            }
        }

        // 还原动画
        ParallelAnimation {
            id: unShowTipImgAni

            // 二维码位置还原
            NumberAnimation {
                id: qrCodeXAniRe
                target: qrCodeImg
                properties: "x"
                // from: qrCodeImg.x
                to: loginImgRow.qrCodeImgPosX
                duration: BasicConfig.loginPopupCodeAniDuration
            }
            NumberAnimation {
                id: qrCodeYAniRe
                target: qrCodeImg
                property: "y"
                to: tipImg.y
                duration: BasicConfig.loginPopupCodeAniDuration
            }

            // 二维码大小还原
            NumberAnimation {
                id: qrCodeScaleAniRe
                target: qrCodeImg
                properties: "scale"
                // from: qrCodeImg.scale
                to: 1
                duration: BasicConfig.loginPopupCodeAniDuration
            }

            // 扫码提示图片位置还原
            NumberAnimation {
                id: tipImgXAniRe
                target: tipImg
                properties: "x"
                to: loginImgRow.tipImgPosX
                duration: BasicConfig.loginPopupCodeAniDuration
            }

            // 扫码提示图片移动时透明度还原
            NumberAnimation {
                id: tipImgOpacityAniRe
                target: tipImg
                properties: "opacity"
                to: 1
                duration: BasicConfig.loginPopupCodeAniDuration
            }
        }

        // 二维码文字
        Item {
            id: qrCodeTextRow
            anchors.top: qrCodeImg.bottom
            anchors.topMargin: 10
            anchors.horizontalCenter: qrCodeImg.horizontalCenter
            width: innerRow.width
            height: innerRow.height + codeLoginText.height + codeLoginText.anchors.topMargin
            visible: !showTipImgAni.running

            Row {
                id: innerRow
                spacing: 5

                Label {
                    id: useText
                    wrapMode: Text.WrapAnywhere
                    font.pixelSize: 20
                    font.family: BasicConfig.fontFamily
                    color: "white"
                    horizontalAlignment: Text.AlignHCenter
                    text: "使用"
                }

                Label {
                    id: appText
                    wrapMode: Text.WrapAnywhere
                    font.pixelSize: 20
                    font.family: BasicConfig.fontFamily
                    color: "cornflowerblue"
                    horizontalAlignment: Text.AlignHCenter
                    text: "云音乐APP"

                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                    }
                }
            }

            Label {
                id: codeLoginText
                x: (innerRow.width - codeLoginText.width) / 2
                y: innerRow.y + innerRow.height + 5
                wrapMode: Text.WrapAnywhere
                font.pixelSize: 20
                font.family: BasicConfig.fontFamily
                color: "white"
                horizontalAlignment: Text.AlignHCenter
                text: "扫码登录"
            }
        }
    }

    //跳转其他登录模式
    Item {
        id: otherLoginMode
        anchors.top: loginImgRow.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        Label {
            id: otherLoginText
            text: "选择其它登录模式>"
            color: "#838A7B"
            font.pixelSize: 17
            font.family: "微软雅黑"
            anchors.centerIn: parent

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor

                onClicked: {
                    BasicConfig.changeLoginPopBgToOther()
                }
            }
        }
    }
}
