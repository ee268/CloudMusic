import QtQuick 2.15
import QtQuick.Controls 2.15
import "../../basic"
import "../../commonUI"
import "../stakPages/recomItem"

Item {
    Item {
        anchors {
            top: parent.top
            topMargin: 30
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }

        Flickable {
            id: flickId
            anchors {
                top: parent.top
                left: parent.left
                right: parent.right
                bottom: parent.bottom
            }

            clip: true
            //内容高度
            contentHeight: recomCol.implicitHeight + 100
            //重写垂直滚动条样式
            ScrollBar.vertical: ScrollBar {
                //滚动条位置
                anchors {
                    right: parent.right
                    rightMargin: 5
                }
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
                id: recomCol
                anchors.fill: parent
                spacing: 40

                TopCarousel {
                    id: recomCarousal
                }

                PickoutRecom {
                    id: pickoutRecom
                }
            }
        }
    }
}
