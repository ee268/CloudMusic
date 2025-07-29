import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15
import "../title"

Rectangle {
    id: rightRect

    TopTitle {
        id: title
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
    }

    // 存储页面，可以前后切换
    //重要：以stakview显示的页面都会沿用其设置的大小，所以子页面的根节点无需设置大小
    StackView {
        id: mainStakView
        anchors.top: title.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        clip: true

        //初始界面
        initialItem: "qrc:/src/rightPage/stakPages/Recommend.qml"
    }
}
