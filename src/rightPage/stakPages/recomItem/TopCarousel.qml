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
        visible: false

        Image {
            anchors.fill: parent
            source: "qrc:/resources/title/arrow.png"
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
        height: 190

        //左边轮播图
        Item {
            id: rightCarouselItem
            width: 500
            height: parent.height
            clip: true
            anchors {
                left: parent.left
            }
            property int curImgIndex: 0
            property int actualCurImgIndex: 0

            ListModel {
                id: carouselImg
                Component.onCompleted: {
                    let s = "qrc:/resources/carouselImg/"
                    for (let i = 1; i <= 8; i++) {
                        carouselImg.append({ img: s + `${i}.jpg` })
                    }
                    for (let i = 1; i <= 8; i++) {
                        carouselImg.append({ img: s + `${i}.jpg` })
                    }
                }
            }

            Timer {
                id: carouselChange
                repeat: true
                running: true
                interval: 4600
                // interval: 1200
                onTriggered: {
                    let skipXDistance = parent.width + carouselRow.spacing

                    if (parent.actualCurImgIndex === carouselImg.count / 2) {
                        for (let i = 0; i < carouselImg.count / 2; i++) {
                            let head = 0
                            carouselImg.append(carouselImg.get(head))
                            carouselImg.remove(head)
                        }

                        parent.actualCurImgIndex = 0
                        //console.log(carouselRow.contentWidth, "----------------------------------------")
                        return
                    }

                    parent.curImgIndex = (parent.curImgIndex + 1) % (carouselImg.count / 2)
                    parent.actualCurImgIndex = (parent.actualCurImgIndex + 1) % carouselImg.count
                    //console.log(carouselRow.contentX, " + ", skipXDistance)
                    carouselRow.contentX += skipXDistance
                }
            }

            ListView {
                id: carouselRow
                orientation: ListView.Horizontal
                width: parent.width
                height: parent.height
                spacing: 20
                enabled: false //禁止滑动
                model: carouselImg

                Behavior on contentX {
                    id: behaviorX
                    NumberAnimation {
                        duration: 350
                    }
                }

                delegate: Rectangle {
                    id: imgEle
                    height: carouselRow.height
                    width: carouselRow.width
                    radius: 15
                    gradient: Gradient {
                        orientation: Gradient.Horizontal
                        GradientStop{ color: "#440096F2"; position: 0 }
                        GradientStop{ color: "#66CA2F45"; position: 1 }
                    }

                    Image {
                        width: height
                        height: parent.height
                        anchors.horizontalCenter: parent.horizontalCenter
                        source: img
                    }

                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        hoverEnabled: true

                        onEntered: {
                            parent.opacity = 0.7
                        }

                        onExited: {
                            parent.opacity = 1
                        }
                    }
                }
            }

            //轮播指示器
            Row {
                anchors {
                    horizontalCenter: parent.horizontalCenter
                    left: parent.left
                    leftMargin: 10
                    bottom: parent.bottom
                    bottomMargin: 10
                }

                Repeater {
                    model: carouselImg.count / 2

                    delegate: Item {
                        width: 17
                        height: 10

                        Rectangle {
                            anchors.centerIn: parent
                            width: 8
                            height: width
                            radius: width / 2
                            color: rightCarouselItem.curImgIndex === index ? "white" : "#55808080"
                        }

                        MouseArea {
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                            hoverEnabled: true

                            onEntered: {
                                carouselChange.stop()
                                let skipXDistance = carouselRow.width + carouselRow.spacing
                                if (index > rightCarouselItem.curImgIndex) {
                                    carouselRow.contentX += (index - rightCarouselItem.curImgIndex) * skipXDistance
                                }
                                else {
                                    carouselRow.contentX -= (rightCarouselItem.curImgIndex - index) * skipXDistance
                                }

                                rightCarouselItem.curImgIndex = index
                            }

                            onExited: {
                                carouselChange.start()
                            }
                        }
                    }
                }
            }
        }

        //右边轮播图
    }

    Item {
        id: rightArrow
        anchors {
            right: parent.right
            verticalCenter: parent.verticalCenter
        }
        width: 30
        height: 45
        visible: false

        Image {
            anchors.fill: parent
            rotation: -180
            source: "qrc:/resources/title/arrow.png"
        }
    }
}
