import QtQuick 2.15
import QtQuick.Window 2.15
import Qt.labs.platform 1.1
import "../basic"

Window {
    id: window
    visible: true
    title: qsTr("云音乐")

    // 设置无边框窗口
    flags: Qt.FramelessWindowHint | Qt.Window | Qt.WindowSystemMenuHint |
           Qt.WindowMaximizeButtonHint | Qt.WindowMinimizeButtonHint
    color: "#00000000"

    MouseArea {
        anchors.fill: parent
        property point clickPos: "0, 0"
        onPressed: function(mouse) {
            clickPos = Qt.point(mouse.x, mouse.y)
            //取消搜索框焦点
            BasicConfig.searchTextFieldFocus = false
            //取消窗口最大化
            window.showNormal()
            BasicConfig.maxImgUrl = "qrc:/resources/title/max.png"
            BasicConfig.isWindowMax = false
        }

        onPositionChanged: function(mouse) {
            // console.log("window: ", window.x, window.y)
            //计算鼠标当前位置和点击位置的差值
            let delta = Qt.point(mouse.x - clickPos.x, mouse.y - clickPos.y)

            //将当前窗口所在屏幕的位置移动delta
            window.x += delta.x
            window.y += delta.y
        }
    }

    // 系统托盘
    SystemTrayIcon {
        id: trayIcon
        visible: true
        icon.source: "qrc:/resources/appIcon/cloudMusic.png"
        tooltip: "后台运行中"

        menu: Menu {
            MenuItem {
                text: "显示窗口"
                onTriggered: {
                    window.show();
                    window.raise();
                    window.requestActivate();
                }
            }
            MenuItem {
                text: "退出"
                onTriggered: Qt.quit()
            }
        }
    }

    Component.onCompleted: {
        // 初次启动时，窗口居中屏幕
        window.x = (Screen.width - window.width) / 2
        window.y = (Screen.height - window.height) / 2
    }
}
