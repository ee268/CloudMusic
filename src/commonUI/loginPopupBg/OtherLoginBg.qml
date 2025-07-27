import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15
import "../../basic"
import "../../commonUI"

Rectangle {
    id: popupOtherBg
    color: "#1B1B24"
    radius: 10
    border.width: 1
    border.color: "#39393D"

    // 关闭按钮
    Image {
        id: closeImgBtn
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

    // 返回扫码登录
    Rectangle { //圆角遮罩
        id: backImgMaskSrc
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.leftMargin: 7
        anchors.topMargin: 7
        radius: parent.radius
        width: backImgBtn.width * backImgBtn.scale
        height: backImgBtn.height * backImgBtn.scale

        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor

            onClicked: {
                BasicConfig.changeLoginPopBgToQrCode()
                // console.log("返回扫码登录页")
            }
        }
    }
    OpacityMask {
        id: backImgMask
        anchors.fill: backImgMaskSrc
        maskSource: backImgMaskSrc
        source: backImgBtn
    }
    Image {
        id: backImgBtn
        scale: 0.5
        source: "qrc:/resources/loginPoup/qrCode.png"
        visible: false
    }
    Canvas { //三角裁剪
        id: triangle
        width: backImgMaskSrc.width + 12
        height: backImgMaskSrc.height + 12

        onPaint: {
            let context = triangle.getContext("2d")
            context.fillStyle = popupOtherBg.color//填充颜色
            context.beginPath() //开始画图
            context.moveTo(triangle.x, triangle.y + triangle.height) //移动位置
            context.lineTo(triangle.x + triangle.width, triangle.y) //画线结束位置
            context.lineTo(triangle.x + triangle.width, triangle.y + triangle.height) //画线结束位置
            context.lineTo(triangle.x, triangle.y + triangle.height)
            context.closePath() //结束画图
            context.fill()
        }
    }

    // 标题
    Row {
        id: titleRow
        anchors.top: triangle.bottom
        anchors.topMargin: 20
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 10

        Rectangle {
            id: titleIconRect
            width: titleIcon.width * 0.8
            height: titleIcon.height * 0.8
            radius: width / 2

            Image {
                id: titleIcon
                anchors.centerIn: parent
                source: "qrc:/resources/title/logo.png"
            }
        }

        Label {
            id: titleText
            anchors.verticalCenter: titleIconRect.verticalCenter
            text: "云音乐"
            color: "white"
            font.pixelSize: 30
            font.family: BasicConfig.fontFamily
        }
    }

    //手机号密码输入框以及其他选项
    Column {
        id: phoneAndPwdColumn
        anchors.top: titleRow.bottom
        anchors.topMargin: 40
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 16

        TextField {
            id: phoneInput
            width: 370
            height: 42
            placeholderText: "请输入手机号"
            placeholderTextColor: "#7A7A80"
            font.pixelSize: 19
            font.family: BasicConfig.fontFamily
            property int textLeftPadding: 0

            leftPadding: textLeftPadding + 20
            color: "white"

            background: Rectangle {
                color: "#22222B"
                radius: phoneInput.height
                border.width: 1
                border.color: "#303038"

                //号码地区
                Item {
                    id: phoneAreaItem
                    height: parent.height
                    width: 100

                    Label {
                        id: phoneAreaText
                        text: "+86"
                        color: "white"
                        x: (parent.width - (phoneAreaText.width + arrowIcon.width)) / 2
                        anchors.verticalCenter: parent.verticalCenter
                        font.pixelSize: phoneInput.font.pixelSize
                    }

                    Label {
                        id: arrowIcon
                        text: "<"
                        rotation: -90
                        color: "white"
                        anchors.left: phoneAreaText.right
                        anchors.verticalCenter: phoneAreaText.verticalCenter
                        font.pixelSize: phoneInput.font.pixelSize
                    }

                    Component.onCompleted: {
                        phoneInput.textLeftPadding = phoneAreaItem.width
                    }
                }

                //分隔线
                Rectangle {
                    anchors.left: phoneAreaItem.right
                    anchors.verticalCenter: parent.verticalCenter
                    width: 1
                    height: parent.height * 0.6
                    color: "#596000"
                }
            }
        }

        TextField {
            id: pwdInput
            width: 370
            height: 42
            placeholderText: "请输入密码"
            placeholderTextColor: "#7A7A80"
            font.pixelSize: 18
            font.family: BasicConfig.fontFamily
            leftPadding: 16
            color: "white"
            echoMode: TextInput.Password

            background: Rectangle {
                color: "#22222B"
                radius: phoneInput.height
                border.width: 1
                border.color: "#303038"

                //清空密码
                Image {
                    id: clearPwd
                    anchors.right: showPwd.left
                    anchors.rightMargin: 6
                    anchors.verticalCenter: parent.verticalCenter
                    source: "qrc:/resources/loginPoup/clear.png"
                    visible: pwdInput.text.length > 0

                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor

                        onClicked: {
                            pwdInput.text = ""
                        }
                    }
                }

                //显示密码
                Image {
                    id: showPwd
                    anchors.right: parent.right
                    anchors.rightMargin: pwdInput.leftPadding
                    anchors.verticalCenter: parent.verticalCenter
                    source: "qrc:/resources/loginPoup/nosee.png"
                    property bool isShowPwd: false

                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor

                        onClicked: {
                            //显示密码
                            if (!showPwd.isShowPwd) {
                                showPwd.source = "qrc:/resources/loginPoup/see.png"
                                pwdInput.echoMode = TextInput.Normal
                                showPwd.isShowPwd = !showPwd.isShowPwd
                            }
                            //不显示密码
                            else {
                                showPwd.source = "qrc:/resources/loginPoup/nosee.png"
                                pwdInput.echoMode = TextInput.Password
                                showPwd.isShowPwd = !showPwd.isShowPwd
                            }
                        }
                    }
                }
            }
        }

        //自动登录、忘记密码、切换验证码登录
        Item {
            id: loginOptionsItem
            width: parent.width
            height: Math.max(autoLoginItem.height, otherOptionsItem.height)

            Item {
                id: autoLoginItem
                width: autoLoginRatioBtn.width
                height: autoLoginRatioBtn.height
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left

                CloudMusicRadioButton {
                    id: autoLoginRatioBtn
                    text: "自动登录"
                    isAlignTop: false
                    anchors.verticalCenter: parent.verticalCenter
                }
            }

            Item {
                id: otherOptionsItem
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter

                property int spacing: 10
                width: forgetPwdText.width + splitLine.width + vcLoginText.width + spacing * 2
                height: forgetPwdText.height

                Label {
                    id: forgetPwdText
                    text: "忘记密码"
                    font.pixelSize: 15
                    font.family: BasicConfig.fontFamily
                    color: "#BBBBBE"

                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        hoverEnabled: true

                        onEntered: {
                            forgetPwdText.color = "white"
                        }

                        onExited: {
                            forgetPwdText.color = "#BBBBBE"
                        }
                    }
                }

                Rectangle {
                    id: splitLine
                    anchors.leftMargin: parent.spacing
                    anchors.left: forgetPwdText.right
                    anchors.verticalCenter: parent.verticalCenter
                    width: 1
                    height: forgetPwdText.height * 0.9
                    color: "#596000"
                }

                Label {
                    id: vcLoginText
                    anchors.leftMargin: parent.spacing
                    anchors.left: splitLine.right
                    text: "验证码登录"
                    font.pixelSize: 15
                    font.family: BasicConfig.fontFamily
                    color: "#BBBBBE"

                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        hoverEnabled: true

                        onEntered: {
                            vcLoginText.color = "white"
                        }

                        onExited: {
                            vcLoginText.color = "#BBBBBE"
                        }

                        onClicked: {
                            if (pwdInput.visible) {
                                vcLoginText.text = "密码登录"
                            }
                            else {
                                vcLoginText.text = "验证码登录"
                            }

                            pwdInput.visible = !pwdInput.visible
                        }
                    }
                }
            }
        }
    }

    // 登录按钮
    Button {
        id: loginBtn
        width: phoneAndPwdColumn.width
        height: 50
        padding: 0
        anchors.topMargin: 40
        anchors.top: phoneAndPwdColumn.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        text: pwdInput.visible ? "登录" : "验证码登录"
        contentItem: Text {
            id: loginBtnText
            z: 100
            text: loginBtn.text
            font.family: BasicConfig.fontFamily
            font.pixelSize: 20
            color: "white"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }

        background: Rectangle {
            id: loginBtnBg
            radius: loginBtn.height
            gradient: Gradient {
                orientation: Gradient.Horizontal
                GradientStop { color: "#FF1168"; position: 0 }
                GradientStop { color: "#FC3D49"; position: 0.6 }
                GradientStop { color: "#FD3E4A"; position: 1 }
            }
        }

        //按下时按钮缩小
        onPressed: {
            loginBtn.scale = 0.95
            loginBtn.opacity = 0.7
        }
        onReleased: {
            loginBtn.scale = 1
            loginBtn.opacity = 1
        }
    }

    //其他登录方式和服务条款
    Column {
        id: otherLoginAndServiceCol
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 45
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 22

        //其他登录方式按钮
        Row {
            id: otherLoginBtnRow
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 21

            ListModel {
                id: otherLoginIconModel
                Component.onCompleted: {
                    let urlList = [
                        [
                            "qrc:/resources/loginPoup/wx_normal.png",
                            "qrc:/resources/loginPoup/QQ_normal.png",
                            "qrc:/resources/loginPoup/sina_normal.png",
                            "qrc:/resources/loginPoup/wy_normal.png"
                        ],
                        [
                            "qrc:/resources/loginPoup/wx_hover.png",
                            "qrc:/resources/loginPoup/QQ_hover.png",
                            "qrc:/resources/loginPoup/sina_hover.png",
                            "qrc:/resources/loginPoup/wy_hover.png"
                        ]
                    ]

                    for (let j = 0; j < urlList[0].length; j++) {
                        otherLoginIconModel.append({ normal: urlList[0][j], hovered: urlList[1][j] })
                    }
                }
            }

            Repeater {
                model: otherLoginIconModel

                Rectangle {
                    id: otherLoginBtn
                    width: 50
                    height: width
                    color: "#22222B"
                    border.width: 1
                    border.color: "#2F2F37"
                    radius: width / 2

                    Image {
                        id: loginIcon
                        scale: 0.8
                        anchors.centerIn: parent
                        source: normal
                    }

                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        hoverEnabled: true

                        onEntered: {
                            loginIcon.source = hovered
                            if(index === 0){
                                otherLoginBtn.color = "#252d28"
                                otherLoginBtn.border.color = "#2d3a2b"
                            }else if(index === 1){
                                otherLoginBtn.color = "#222a38"
                                otherLoginBtn.border.color = "#263346"
                            }else if(index === 2){
                                otherLoginBtn.color = "#251c24"
                                otherLoginBtn.border.color = "#321e26"
                            }else if(index === 3){
                                otherLoginBtn.color = "#251c24"
                                otherLoginBtn.border.color = "#321e26"
                            }
                        }

                        onExited: {
                            loginIcon.source = normal
                            otherLoginBtn.color = "#22222B"
                            otherLoginBtn.border.color = "#2F2F37"
                        }
                    }
                }
            }
        }

        // 服务条款勾选
        Row {
            id: serviceRadioBtnRow
            anchors.horizontalCenter: parent.horizontalCenter

            //服务条款勾选按钮
            RadioButton {
                id: serviceRadioBtn
                padding: 0
                text: "同意"
                property bool isSelect: false

                indicator: Rectangle {
                    id: serviceRadioBtnIdct
                    width: 20
                    height: width
                    radius: width / 2
                    color: serviceRadioBtn.isSelect ? "#FF3A3A" : "transparent"
                    border {
                        width: !serviceRadioBtn.isSelect ? 1 : 0
                        color: "#75757B"
                    }
                    anchors.verticalCenter: serviceRadioBtn.verticalCenter

                    Text {
                        anchors.centerIn: parent
                        text: "✔"
                        color: "white"
                        visible: serviceRadioBtn.isSelect
                    }
                }

                contentItem: Text {
                    id: serviceRadioBtnText
                    text: serviceRadioBtn.text
                    font.family: BasicConfig.fontFamily
                    font.pixelSize: 15
                    color: "#8D8D92"
                    verticalAlignment: Text.AlignVCenter
                    leftPadding: serviceRadioBtn.indicator.width + serviceRadioBtn.spacing
                }

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor

                    onEntered: {
                        serviceRadioBtnIdct.border.color = "white"
                    }

                    onExited: {
                        serviceRadioBtnIdct.border.color = "#75757B"
                    }

                    onClicked: {
                        serviceRadioBtn.isSelect = !serviceRadioBtn.isSelect
                    }
                }
            }

            Row {
                id: serviceTextRow

                Label {
                    id: serviceClauseText
                    text: "《服务条款》"
                    font.family: BasicConfig.fontFamily
                    font.pixelSize: 14
                    color: "#5E7CBD"

                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor

                        onEntered: {
                            serviceClauseText.color = "#789EF0"
                        }

                        onExited: {
                            serviceClauseText.color = "#5E7CBD"
                        }
                    }
                }

                Label {
                    id: privacyPolicyText
                    text: "《隐私政策》"
                    font.family: BasicConfig.fontFamily
                    font.pixelSize: 14
                    color: "#5E7CBD"

                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor

                        onEntered: {
                            privacyPolicyText.color = "#789EF0"
                        }

                        onExited: {
                            privacyPolicyText.color = "#5E7CBD"
                        }
                    }
                }

                Label {
                    id: childPrivacyPolicyText
                    text: "《儿童隐私政策》"
                    font.family: BasicConfig.fontFamily
                    font.pixelSize: 14
                    color: "#5E7CBD"

                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor

                        onEntered: {
                            childPrivacyPolicyText.color = "#789EF0"
                        }

                        onExited: {
                            childPrivacyPolicyText.color = "#5E7CBD"
                        }
                    }
                }
            }
        }
    }
}
