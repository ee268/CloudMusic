import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15
import "../../../basic"
import "../../../commonUI"

Column {
    spacing: 80

    Row {
        spacing: BasicConfig.settingTitleRightMargin

        Label {
            id: lyricTitleLabel1
            text: "音乐桌面"
            width: 150
            font.pixelSize: 22
            font.bold: true
            font.family: BasicConfig.fontFamily
            color: "white"
        }

        Column {
            spacing: 12

            Label {
                text: "切换音乐桌面样式，请点击APP右上角的换肤-音乐桌面"
                font.family: BasicConfig.fontFamily
                font.pixelSize: 20
                color: "white"
            }

            Rectangle {
                width: 164
                height: 34
                radius: height / 2
                color: "transparent"
                border {
                    width: 1
                    color: "#FF3A3A"
                }

                Label {
                    anchors.centerIn: parent
                    text: "开启桌面音乐>"
                    color: parent.border.color
                    font.pixelSize: 18
                    font.family: BasicConfig.fontFamily
                }

                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    hoverEnabled: true

                    onEntered: {
                        parent.color = "#26171D"
                    }

                    onExited: {
                        parent.color = "transparent"
                    }
                }
            }
        }
    }

    Row {
        spacing: BasicConfig.settingTitleRightMargin

        Label {
            id: lyricTitleLabel2
            text: "桌面歌词"
            width: 150
            font.pixelSize: 22
            font.bold: true
            font.family: BasicConfig.fontFamily
            color: "white"
        }

        Column {
            spacing: 30

            //歌词启用选项
            Row {
                id: lyricOptionsRow
                spacing: 70

                ButtonGroup {
                    id: lyricOptionBtnGrp
                    exclusive: false
                }

                Repeater {
                    model: ["启用桌面歌词", "启用歌词总在最前", "外文歌词显示翻译", "外文歌词显示音译"]

                    delegate: CloudMusicRadioButton {
                        text: modelData
                        textColor: "white"
                        ButtonGroup.group: lyricOptionBtnGrp
                    }
                }
            }

            //歌词字体设置
            Row {
                spacing: 22

                Repeater {
                    model: ["字体", "字号", "字粗", "描边"]

                    delegate: Column {
                        spacing: 9

                        Label {
                            text: modelData
                            font.family: BasicConfig.fontFamily
                            font.pixelSize: 19
                            font.bold: true
                            color: "white"
                        }

                        CloudMusicSettingComboBox {
                            text: ""
                            width: 170
                            model: []
                            Component.onCompleted: {
                                if (index == 0) {
                                    text = "默认"
                                    model = ["默认","仿宋","华文中宋","华文仿宋","华文宋体","华文新魏","华文楷体","华文细黑","华文行书"
                                             ,"华文楷书","宋体","幼圆","微软雅黑","微软雅黑 Light","新宋体","方正姚体","方正舒体"]
                                }
                                else if (index == 1) {
                                    let sizeList = []
                                    for (let i = 20; i < 97; i++) {
                                        sizeList.push(i)
                                    }
                                    text = "20"
                                    model = sizeList
                                }
                                else if (index == 2) {
                                    text = "标准"
                                    model = ["标准", "加粗"]
                                }
                                else if (index == 3) {
                                    text = "有描边"
                                    model = ["有描边", "无描边"]
                                }
                            }
                        }
                    }
                }
            }

            //调整排版样式
            Column {
                spacing: 9

                Label {
                    text: "调整排版样式"
                    font.family: BasicConfig.fontFamily
                    font.pixelSize: 19
                    font.bold: true
                    color: "white"
                }

                Row {
                    spacing: 22

                    Repeater {
                        model: ["单行显示", "横排显示", "居中"]

                        delegate: CloudMusicSettingComboBox {
                            text: modelData
                            width: 170
                            model: []
                            Component.onCompleted: {
                                if (index === 0) {
                                    model = ["双行显示", "单行显示"]
                                }
                                else if (index === 1) {
                                    model = ["横排显示", "竖排显示"]
                                }
                                else if (index === 2) {
                                    model = ["居中", "左对齐", "右对齐"]
                                }
                            }
                        }
                    }
                }
            }

            //更改配色方案
            Column {
                spacing: 9

                Label {
                    text: "更改配色方案"
                    font.family: BasicConfig.fontFamily
                    font.pixelSize: 19
                    font.bold: true
                    color: "white"
                }

                Row {
                    spacing: 22

                    CloudMusicSettingComboBox {
                        text: "网易红"
                        width: 170
                        model: ["自定义","周易红","落日晖","可爱粉","天际蓝","清新绿","活力紫","温柔黄","低调灰"]
                    }

                    Repeater {
                        model: ["已播放", "未播放"]
                        delegate: Rectangle {
                            width: 170
                            height: 35
                            radius: height / 2
                            border.width: 1
                            border.color: "#28282F"
                            color: "#1A1A21"

                            Row {
                                anchors.verticalCenter: parent.verticalCenter
                                leftPadding: parent.radius
                                spacing: 5

                                Rectangle {
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: 20
                                    height: width
                                    radius: 3
                                    border {
                                        width: 1
                                        color: index === 0 ? BasicConfig.finishedLyricsBorderColor : BasicConfig.unFinishedLyricsBorderColor
                                    }

                                    gradient: Gradient {
                                        orientation: Gradient.Vertical
                                        GradientStop {
                                            color: index === 0 ? BasicConfig.finishedLyricsDownColor : BasicConfig.unFinishedLyricsDownColor
                                            position: 0
                                        }
                                        GradientStop {
                                            color: index === 0 ? BasicConfig.finishedLyricsUpColor : BasicConfig.unFinishedLyricsUpColor
                                            position: 1
                                        }
                                    }
                                }

                                Label {
                                    anchors.verticalCenter: parent.verticalCenter
                                    text: modelData
                                    color: "white"
                                    font.pixelSize: 18
                                    font.family: BasicConfig.fontFamily
                                }
                            }

                            MouseArea {
                                anchors.fill: parent
                                cursorShape: Qt.PointingHandCursor

                                onPressed: {
                                    parent.color = "#212127"
                                }

                                onReleased: {
                                    parent.color = "#1A1A21"
                                }

                                onClicked: {
                                    BasicConfig.openLyricColorPopupModel = index
                                    console.log("model", BasicConfig.openLyricColorPopupModel)
                                    BasicConfig.openLyricColorPopup()
                                }
                            }
                        }
                    }
                }
            }

            //预览
            Column {
                spacing: 9

                Label {
                    text: "预览"
                    font.family: BasicConfig.fontFamily
                    font.pixelSize: 19
                    font.bold: true
                    color: "white"
                }

                Rectangle {
                    width: 750
                    height: 250
                    color: "#19191F"
                    radius: 25
                    border {
                        width: 1
                        color: "#2B2B31"
                    }

                    Item {
                        width: previewText1.width
                        height: previewText1.font.pixelSize + 1
                        anchors.centerIn: parent

                        Item {
                            anchors {
                                left: parent.left
                                top: parent.top
                                bottom: parent.bottom
                            }
                            width: parent.width / 2
                            clip: true

                            Label {
                                id: previewText1
                                anchors {
                                    left: parent.left
                                    verticalCenter: parent.verticalCenter
                                }
                                text: "云音乐"
                                font.family: BasicConfig.fontFamily
                                font.pixelSize: 64
                                style: Text.Outline
                                styleColor: BasicConfig.finishedLyricsBorderColor
                            }

                            Label {
                                anchors.fill: previewText1
                                text: previewText1.text
                                font: previewText1.font

                                LinearGradient {
                                    anchors.fill: parent
                                    source: parent
                                    start: Qt.point(parent.width, 0)
                                    end: Qt.point(parent.width, parent.height)
                                    gradient: Gradient{
                                        GradientStop { position: 0; color: BasicConfig.finishedLyricsDownColor }
                                        GradientStop { position: 1; color: BasicConfig.finishedLyricsUpColor }
                                    }
                                }
                            }
                        }

                        Item {
                            anchors {
                                right: parent.right
                                top: parent.top
                                bottom: parent.bottom
                            }
                            width: parent.width / 2
                            clip: true

                            Label {
                                id: previewText2
                                anchors {
                                    right: parent.right
                                    verticalCenter: parent.verticalCenter
                                }
                                text: "云音乐"
                                font.family: BasicConfig.fontFamily
                                font.pixelSize: 64
                                style: Text.Outline
                                styleColor: BasicConfig.unFinishedLyricsBorderColor
                            }

                            Label {
                                anchors.fill: previewText2
                                text: previewText2.text
                                font: previewText2.font

                                LinearGradient {
                                    anchors.fill: parent
                                    source: parent
                                    start: Qt.point(parent.width, 0)
                                    end: Qt.point(parent.width, parent.height)
                                    gradient: Gradient{
                                        GradientStop { position: 0; color: BasicConfig.unFinishedLyricsDownColor }
                                        GradientStop { position: 1; color: BasicConfig.unFinishedLyricsUpColor }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    //分隔线
    Rectangle {
        id: lyricSplitLine
        width: tileSplitLine.width
        height: 1
        color: "#212127"
    }
}
