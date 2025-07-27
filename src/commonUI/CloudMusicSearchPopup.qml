import QtQuick 2.15
import QtQuick.Controls 2.15
import "../basic"

Popup {
    background: Rectangle {
        anchors.fill: parent
        radius: 10
        color: "#2D2D38"

        //搜索记录标题
        Item {
            id: historyItem
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.topMargin: 30
            anchors.leftMargin: 30
            height: searchLabel.height

            //标题文字
            Label {
                id: searchLabel
                color: "white"
                text: "搜索历史"
                font.bold: true
                font.pixelSize: 18
                font.family: BasicConfig.fontFamily
            }

            //删除搜索记录图标
            Image {
                id: removeIconImg
                anchors.left: searchLabel.right
                anchors.verticalCenter: searchLabel.verticalCenter
                scale: 0.5
                source: "qrc:/resources/searchPopup/remove.png"

                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor

                    onClicked: {
                        searchSongModel.clear()
                    }
                }
            }
        }

        // 流式布局搜索历史标签
        Flow {
           id: songFlow
           anchors.left: historyItem.left
           anchors.right: historyItem.right
           anchors.top: historyItem.bottom
           anchors.topMargin: 20
           spacing: 10

           property int visibleEndIndex: searchSongModel.count - 1
           property int downIndex: -1
           property int upIndex: -1

           // 重复使用控件
           Repeater {
                id: historyRep
                anchors.fill: parent
                model: searchSongModel
                delegate: Rectangle {
                    width: dataLabel.implicitWidth + 20
                    height: 40
                    border.width: 1
                    border.color: "#45454e"
                    color: "#393944"
                    radius: height
                    visible: index <= songFlow.visibleEndIndex

                    Label {
                        id: dataLabel
                        //模型内置的变量，只有一个元素时直接通过modelData获取数据，或者直接写该元素的属性名
                        text: modelData
                        font.pixelSize: 16
                        anchors.centerIn: parent
                        color: "#ddd"
                        font.family: BasicConfig.fontFamily
                        height: 25
                    }

                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true

                        onEntered: {
                            parent.color = "#42424C"
                            dataLabel.color = "white"
                            cursorShape = Qt.PointingHandCursor
                        }

                        onExited: {
                            if (index === songFlow.downIndex || index === songFlow.upIndex) {
                                parent.color = "transparent"
                                dataLabel.color = "#ddd"
                            }
                            else {
                                parent.color = "#393944"
                                dataLabel.color = "#ddd"
                            }

                            cursorShape = Qt.ArrowCursor
                        }

                        onClicked: {
                            if (index === songFlow.downIndex) {
                                songFlow.visibleEndIndex = songFlow.upIndex
                                parent.visible = false
                            }
                            else if (index === songFlow.upIndex) {
                                historyRep.itemAt(songFlow.downIndex).visible = index <= songFlow.visibleEndIndex
                                songFlow.visibleEndIndex = songFlow.downIndex
                            }
                        }
                    }
                }
            }

            Component.onCompleted: {
                let rowWidth = 0
                let cntRow = 0
                let secondRowLastRect = null
                let secondRowLastRectIndex = -1

                for (let i = 0; i < historyRep.count; i++) {
                   let rect = historyRep.itemAt(i)
                   rowWidth += rect.width + 10

                   if (rowWidth - 10 > songFlow.width) {
                       cntRow++
                       rowWidth = rect.width + 10
                       if (cntRow === 2) {
                            secondRowLastRectIndex = i - 1
                            break
                       }
                   }
                }

                if (secondRowLastRectIndex != -1) {
                    let side = 35

                    searchSongModel.insert(secondRowLastRectIndex, { singName: ">" })

                    downIndex = secondRowLastRectIndex
                    visibleEndIndex = downIndex

                    secondRowLastRect = historyRep.itemAt(secondRowLastRectIndex)
                    secondRowLastRect.width = side
                    secondRowLastRect.height = side
                    secondRowLastRect.radius = side / 2
                    secondRowLastRect.color = "transparent"
                    secondRowLastRect.rotation = 90

                    searchSongModel.append({ singName: ">" })

                    secondRowLastRect = historyRep.itemAt(searchSongModel.count - 1)

                    upIndex = searchSongModel.count - 1

                    secondRowLastRect.width = side
                    secondRowLastRect.height = side
                    secondRowLastRect.radius = side / 2
                    secondRowLastRect.color = "transparent"
                    secondRowLastRect.rotation = -90
                }
            }
        }
    }

    enter: Transition {
        NumberAnimation {
            property: "scale"
            from: 0.0
            to: 1.0
            duration: 150
        }
    }

    onClosed: {
        BasicConfig.searchTextFieldFocus = false
    }
}
