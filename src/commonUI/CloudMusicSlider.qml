import QtQuick 2.15
import QtQuick.Controls 2.15
import "../basic"

Slider {
    id: cacheSlider
    width: 400
    height: 30
    from: 10
    to: 50

    //自定义滑块背景样式
    background: Rectangle {
        x: cacheSlider.leftPadding
        y: cacheSlider.topPadding + cacheSlider.availableHeight / 2 - height / 2
        implicitWidth: 200
        implicitHeight: 8
        width: cacheSlider.availableWidth
        height: implicitHeight
        radius: height / 2
        color: "#2B2B31"

        Rectangle {
            width: cacheSlider.visualPosition * parent.width
            height: parent.height
            color: "#FF3A3A"
            radius: height / 2
        }
    }

    //自定义滑块按钮样式
    handle: Rectangle {
        x: cacheSlider.leftPadding + cacheSlider.visualPosition * (cacheSlider.availableWidth - width)
        y: cacheSlider.topPadding + cacheSlider.availableHeight / 2 - height / 2
        implicitWidth: 20
        implicitHeight: 20
        radius: implicitHeight / 2
        color: "white"
    }
}
