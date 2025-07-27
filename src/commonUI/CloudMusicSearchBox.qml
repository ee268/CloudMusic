import QtQuick 2.15
import QtQuick.Controls 2.15
import "../basic"

TextField {
                //外部矩形，边框
    background: Rectangle {
        anchors.fill: parent
        radius: 8
        gradient: Gradient {
            orientation: Gradient.Horizontal
            GradientStop { color: "#21283d"; position: 0 }
            GradientStop { color: "#382635"; position: 1 }
        }

        //内部矩形
        Rectangle {
            id: innerRect
            anchors.fill: parent
            anchors.margins: 1
            radius: parent.radius
            property real gradientStopPos: 1

            gradient: Gradient {
                orientation: Gradient.Horizontal
                GradientStop { color: "#1a1d29"; position: 0 }
                GradientStop { color: "#241c26"; position: innerRect.gradientStopPos }
            }
        }

        Image {
            id: searchIcon
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 16
            scale: 0.8
            source: "qrc:/resources/title/search.png"
        }

        MouseArea{
            anchors.fill: parent
            hoverEnabled: true
            onPressed: {
                innerRect.gradientStopPos = 0 // 移除渐变
                BasicConfig.searchTextFieldFocus = true // 获取焦点
                searchPop.open() // 打开搜索下拉框
            }
        }
    }

    onFocusChanged: {
        if(!focus)innerRect.gradientStopPos = 1 // 还原渐变
    }
}
