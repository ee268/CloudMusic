import QtQuick 2.15
import "../title"

//标题
Item {
    id: title
    height: 60

    Search {
        id: search
        anchors.left: parent.left
        anchors.leftMargin: 36
        anchors.verticalCenter: parent.verticalCenter
    }

    //窗口隐藏、最大化、最小化、关闭控件
    MiniAndMax {
        id: miniMax
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        anchors.rightMargin: 0.02 * window.width
    }

    UserIconAndSetting {
        id: userIcon
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: miniMax.left
        anchors.rightMargin: 10
        spacing: 8
    }
}
