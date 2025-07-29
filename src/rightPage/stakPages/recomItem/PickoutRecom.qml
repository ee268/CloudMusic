import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15
import "../../../basic"

Item {
    width: parent.width - (BasicConfig.recoPagePadding - leftArrow.width) * 2
    height: carouselArea.height
    anchors {
        horizontalCenter: parent.horizontalCenter
    }

    Item {
        id: leftArrow
        anchors {
            left: parent.left
            verticalCenter: parent.verticalCenter
        }
        width: 30
        height: 45

        Image {
            id: leftArrowImg
            anchors.fill: parent
            source: "qrc:/resources/title/arrow.png"
            // layer.enabled: false
            // layer.effect: ColorOverlay {
            //     source: leftArrowImg
            //     color: "white"
            // }
        }

        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor

            // onEntered: {
            //     leftArrowImg.layer.enabled = true
            // }

            // onExited: {
            //     leftArrowImg.layer.enabled = false
            // }

            onClicked: {
                carouselRow.contentX = 0
            }
        }
    }

    Item {
        id: carouselArea
        anchors {
            left: leftArrow.right
            leftMargin: 5
            right: rightArrow.left
            rightMargin: 5
        }
        height: 315
        property int curShowItemCnt: 0
        property int curShowItemWidth: 0

        //标题区域
        Item {
            id: titleItem
            anchors {
                left: parent.left
                right: parent.right
                top: parent.top
            }
            height: 50

            //标题文字
            Label {
                anchors {
                    left: parent.left
                    verticalCenter: parent.verticalCenter
                }

                text: "精选推荐"
                font.bold: true
                font.pixelSize: 22
                font.family: BasicConfig.fontFamily
                color: "white"
            }

            //刷新按钮
            Item {
                anchors {
                    right: parent.right
                    verticalCenter: parent.verticalCenter
                }
                width: 25
                height: width

                Image {
                    id: refreshIcon
                    anchors.fill: parent
                    source: "qrc:/resources/recommend/refresh.png"
                    layer.enabled: false
                    layer.effect: ColorOverlay {
                        source: refreshIcon
                        color: "white"
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    hoverEnabled: true

                    onEntered: {
                        refreshIcon.layer.enabled = true
                    }

                    onExited: {
                        refreshIcon.layer.enabled = false
                    }
                }
            }
        }

        //轮播控件区域
        Item {
            id: carouselItem
            anchors {
                left: parent.left
                right: parent.right
                top: titleItem.bottom
                topMargin: 8
                bottom: parent.bottom
            }
            clip: true

            Row {
                ListModel {
                    id: carouselImg
                    Component.onCompleted: {
                        let s = "qrc:/resources/carouselImg2/Cartethyia"
                        for (let i = 1; i <= 10; i++) {
                            carouselImg.append({ img: s + `${i}.jpg` })
                        }
                    }
                }

                ListView {
                    id: carouselRow
                    model: carouselImg
                    spacing: 20
                    // enabled: false
                    height: carouselItem.height
                    width: carouselItem.width
                    orientation: ListView.Horizontal

                    Behavior on contentX {
                        NumberAnimation {
                            duration: 400
                        }
                    }

                    delegate: Rectangle {
                        id: bgRect
                        width: {
                            let minimumSize = 175
                            let maximumSize = 200
                            for (let i = 5; i <= 10; i++) {
                                let avgWidth = (carouselRow.width - carouselRow.spacing * (i - 1)) / i
                                if (avgWidth >= minimumSize && avgWidth <= maximumSize) {
                                    carouselArea.curShowItemCnt = i
                                    carouselArea.curShowItemWidth = avgWidth
                                    return avgWidth
                                }
                            }

                            carouselArea.curShowItemCnt = 10
                            carouselArea.curShowItemWidth = maximumSize
                            return maximumSize
                        }
                        height: carouselRow.height
                        color: "pink"
                        radius: 15
                        layer.enabled: true
                        layer.effect: OpacityMask {
                            source: bgRect
                            maskSource: Rectangle {
                                width: bgRect.width
                                height: bgRect.height
                                radius: bgRect.radius
                            }
                        }

                        //封面背景
                        Image {
                            id: cover
                            anchors.fill: parent
                            source: img
                        }

                        //顶部标题
                        Rectangle {
                            anchors {
                                left: parent.left
                                right: parent.right
                                top: parent.top
                            }
                            height: 60
                            gradient: Gradient {
                                orientation: Gradient.Vertical
                                GradientStop { color: "#DDCECECE"; position: 0 }
                                GradientStop { color: "#CCCECECE"; position: 0.5 }
                                GradientStop { color: "#00CCCCCC"; position: 1 }
                            }

                            Label {
                                anchors {
                                    left: parent.left
                                    top: parent.top
                                    leftMargin: 10
                                    topMargin: 10
                                }
                                text: "卡提西亚"
                                color: "white"
                                font.pixelSize: 21
                                font.family: BasicConfig.fontFamily
                                font.bold: true
                            }
                        }

                        //底部标题
                        Rectangle {
                            id: bottomRect
                            anchors {
                                left: parent.left
                                right: parent.right
                                bottom: parent.bottom
                            }
                            height: 60
                            color: "#C8C8C7"
                        }

                        //播放按钮
                        Item {
                            id: playBtn
                            width: 30
                            height: width
                            anchors {
                                right: parent.right
                                rightMargin: 10
                                bottom: parent.bottom
                                bottomMargin: 20
                            }
                            z: 100
                            opacity: 0

                            Behavior on opacity {
                                NumberAnimation {
                                    duration: 100
                                }
                            }

                            Image {
                                anchors.fill: parent
                                source: "qrc:/resources/recommend/play.png"
                            }
                        }

                        //渐变背景
                        Rectangle {
                            id: gradientRect
                            width: parent.width
                            height: parent.height
                            y: parent.height - bottomTitle.y - bottomTitle.height + 5

                            Text {
                                id: bottomTitle
                                anchors {
                                    bottom: parent.bottom
                                    bottomMargin: parent.height * 0.4
                                    horizontalCenter: parent.horizontalCenter
                                }
                                height: bottomRect.height
                                width: bottomRect.width - 20
                                text: "悠闲时光 | 樱花雨下的清新歌新歌新歌新歌新歌新歌新歌声"
                                font.family: BasicConfig.fontFamily
                                font.pixelSize: 18
                                color: "white"
                                wrapMode: Text.Wrap
                                elide: Text.ElideRight
                            }

                            //前三首预览
                            Item {
                                id: songsItem
                                anchors {
                                    left: bottomTitle.left
                                    right: bottomTitle.right
                                    top: bottomTitle.bottom
                                }
                                height: songsCol.height

                                Column {
                                    id: songsCol
                                    anchors {
                                        left: parent.left
                                    }
                                    spacing: 12

                                    Repeater {
                                        model: ["花日", "K-Pop x Funk Type Beat\"Pearl\"", "盛夏派对 wait a sec."]

                                        delegate: Row {
                                            spacing: 5
                                            Label {
                                                id: rankText
                                                anchors.verticalCenter: parent.verticalCenter
                                                text: index + 1
                                                font.pixelSize: 15
                                                font.family: BasicConfig.fontFamily
                                                font.bold: true
                                                color: "#99ffffff"
                                            }

                                            Label {
                                                anchors.verticalCenter: parent.verticalCenter
                                                width: index === 0 ? songsItem.width - rankText.width : (songsItem.width - rankText.width) * 0.6
                                                text: modelData
                                                maximumLineCount: 1
                                                elide: Text.ElideRight
                                                font.pixelSize: 15
                                                font.family: BasicConfig.fontFamily
                                                color: "#DDffffff"
                                            }
                                        }
                                    }
                                }
                            }

                            Behavior on y {
                                NumberAnimation {
                                    duration: 200
                                }
                            }

                            // color: "red"

                            gradient: Gradient {
                                orientation: Gradient.Vertical
                                GradientStop { color: "#11C8C8C7"; position: 0 }
                                GradientStop { color: "#C8C8C7"; position: 0.5 }
                                GradientStop { color: "#C8C8C7"; position: 1 }
                            }
                        }

                        MouseArea {
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                            hoverEnabled: true

                            onEntered: {
                                gradientRect.y = 0
                                playBtn.opacity = 1
                            }

                            onExited: {
                                gradientRect.y = parent.height - bottomTitle.y - bottomTitle.height + 5
                                playBtn.opacity = 0
                            }
                        }
                    }
                }
            }
        }
    }

    Item {
        id: rightArrow
        anchors {
            right: parent.right
            verticalCenter: parent.verticalCenter
        }
        width: 30
        height: 45

        Image {
            id: rightArrowImg
            anchors.fill: parent
            rotation: -180
            source: "qrc:/resources/title/arrow.png"
            // layer.enabled: false
            // layer.effect: ColorOverlay {
            //     source: rightArrowImg
            //     color: "white"
            // }
        }

        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor

            // onEntered: {
            //     rightArrowImg.layer.enabled = true
            // }

            // onExited: {
            //     rightArrowImg.layer.enabled = false
            // }

            onClicked: {
                let showCnt = carouselImg.count - carouselArea.curShowItemCnt
                carouselRow.contentX = showCnt * carouselArea.curShowItemWidth + carouselRow.spacing * showCnt
            }
        }
    }
}
