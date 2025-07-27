import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15
import "./src/leftPage"
import "./src/rightPage"
import "./src/bottomPage"
import "./src/commonUI"
import "./src/basic"

CloudMusicWindow {
    id: window
    width: 1342
    height: 939

    Connections {
        target: BasicConfig
        //触发信号时的处理函数，on + 信号名

        //关闭和打开登录窗口
        function onOpenLoginPopup() {
            loginPopup.open()
        }
        function onCloseLoginPopup() {
            loginPopup.close()
        }

        //关闭和打开歌词颜色选择弹窗
        function onOpenLyricColorPopup() {
            lyricColorPopup.open()
        }
        function onCloseLyricColorPopup() {
            lyricColorPopup.close()
        }
    }

    // 窗口边框
    Rectangle {
        id: windowBorder
        anchors.fill: parent
        color: "transparent"
        radius: 10
        border.width: 1
        border.color: "#494949"
    }

    // 圆角遮罩层
    Rectangle {
        id: windowBg
        anchors.fill: parent
        anchors.margins: windowBorder.border.width
        border.width: 1
        border.color: "red"
        layer.enabled: true
        layer.effect: OpacityMask{
            maskSource: Rectangle{
                width: windowBg.width
                height: windowBg.height
                radius: 10
            }
        }

        // 左页面
        LeftPage {
            id: leftRect
            width: 255
            anchors.top: parent.top
            anchors.bottom: bottomRect.top
            anchors.left: parent.left
            color: "#1a1a21"
        }

        // 右页面
        RightPage {
            id: rightRect
            anchors.left: leftRect.right
            anchors.right: parent.right
            anchors.bottom: bottomRect.top
            anchors.top: parent.top
            color: "#13131a"
        }

        // 底部播放页面
        BottomPage {
            id: bottomRect
            height: 100
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            color: "#2d2d37"
        }
    }

    // 登录弹出框
    CloudMusicLoginPoup {
        id: loginPopup
        // parent: Overlay.overlay
        x: parent.width / 2 - width / 2
        y: parent.height / 2 - height / 2
        width: 456
        height: 638
        clip: true
    }

    //歌词颜色弹出框
    CloudMusicLyricColorPopup {
        id: lyricColorPopup
        width: 600
        height: 400
        modal: true
        x: parent.width / 2 - width / 2
        y: parent.height / 2 - height / 2
        closePolicy: Popup.NoAutoClose
    }
}
