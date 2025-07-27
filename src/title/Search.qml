import QtQuick 2.15
import QtQuick.Controls 2.15
import "../basic"
import "../commonUI"

Row {
    id: searchRow
    spacing: 8

    //返回上一页
    Rectangle {
        id: backForwardRect
        width: 24 + 5
        height: 35 + 5
        radius: 4
        color: "transparent"
        border.width: 1
        border.color: "#2B2B31"

        Image {
            anchors.centerIn: parent
            source: "qrc:/resources/title/arrow.png"
        }
    }

    //搜索框
    CloudMusicSearchBox {
        id: searchTextField
        height: backForwardRect.height
        width: 320
        focus: BasicConfig.searchTextFieldFocus
        placeholderText: "晴天"
        placeholderTextColor: "#7B777E"
        leftPadding: 55
        font.pixelSize: 22
        color: "white"
    }

    //搜索历史记录
    ListModel {
        id: searchSongModel

        ListElement{singName:"想象之中"}
        ListElement{singName:"雨道"}
        ListElement{singName:"哪里都是你"}
        ListElement{singName:"入戏太深"}
        ListElement{singName:"That girl"}
        ListElement{singName:"素颜"}
        ListElement{singName:"她说"}
        ListElement{singName:"ABC"}
        ListElement{singName:"daylight"}
        ListElement{singName:"其他"}
    }

    //搜索记录弹出框
    CloudMusicSearchPopup {
        id: searchPop
        width: parent.width
        height: 800
        closePolicy: Popup.CloseOnPressOutside
        y: searchTextField.height + parent.spacing
    }

    //听歌识曲
    Rectangle {
        id: soundHoundRect
        height: backForwardRect.height
        width: height
        radius: 8
        border.width: 1
        border.color: "#36262f"
        color: "#241c26"

        Image {
            scale: 0.9
            anchors.centerIn: parent
            source: "qrc:/resources/title/record.png"
        }

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true

            onEntered: {
                parent.color = "#342233"
            }

            onExited: {
                parent.color = "#241c26"
            }
        }
    }
}
