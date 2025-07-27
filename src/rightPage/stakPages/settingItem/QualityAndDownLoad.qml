import QtQuick 2.15
import QtQuick.Controls 2.15
import Qt.labs.platform 1.1
import "../../../basic"
import "../../../commonUI"

Column {
    spacing: BasicConfig.settingItemSplitLineTopMargin

    Row {
        spacing: BasicConfig.settingTitleRightMargin

        Label {
            id: qualityTitleLabel
            text: "音质与下载"
            width: 150
            font.pixelSize: 22
            font.bold: true
            font.family: BasicConfig.fontFamily
            color: "white"
        }

        Column {
            spacing: 40

            //音质选择
            Repeater {
                model: [ "音质播放设置", "音质下载设置" ]

                delegate: Row {
                    spacing: 30

                    Label {
                        text: modelData
                        font.pixelSize: 20
                        font.bold: true
                        font.family: BasicConfig.fontFamily
                        color: "white"
                    }

                    ButtonGroup {
                        id: qualityBtnGrp
                        exclusive: true
                    }

                    Grid {
                        columns: 3
                        rowSpacing: 30
                        columnSpacing: 100

                        Repeater {
                            id: qualityRep
                            model: ["沉静环绕声","超声母带","高清臻音","高解析度无损","无损","极高","标准"]

                            delegate: CloudMusicRadioButton2 {
                                text: modelData
                                checked: index === qualityRep.model.length - 1
                                textColor: "white"
                                iconSrc: {
                                    if (index < 2) {
                                        return "qrc:/resources/setting/svip.png"
                                    }
                                    else if (index < qualityRep.model.length - 2) {
                                        return "qrc:/resources/setting/vip.png"
                                    }
                                    else {
                                        return ""
                                    }
                                }
                                ButtonGroup.group: qualityBtnGrp
                            }
                        }
                    }
                }
            }

            //了解音质
            Label {
                text: "了解音质>"
                font.pixelSize: 20
                font.family: BasicConfig.fontFamily
                color: "#5E7CBD"

                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor

                    onClicked: {
                        Qt.openUrlExternally("https://y.music.163.com/m/at/648fba3cbe7c73d87cbc2e81")
                    }
                }
            }

            //更改下载目录
            Column {
                id: downloadRow
                spacing: 12

                Label {
                    text: "
                        <span style=\"font-size: 20px;color: white;font-bold:true;\">下载目录</span>
                        <span style=\"font-size: 20px;color: #89898c;\">(默认将音乐文件下载在该文件夹中)</span>
                    "
                    font.bold: true
                    textFormat: Text.RichText
                    font.family: BasicConfig.fontFamily
                }

                Row {
                    spacing: 16

                    Label {
                        id: downloadPath
                        text: "C:\\123\\123"
                        anchors.verticalCenter: parent.verticalCenter
                        font.pixelSize: 19
                        font.family: BasicConfig.fontFamily
                        color: "white"
                    }

                    FolderDialog {
                        id: folderDialog

                        //点击接收时
                        onAccepted: {
                            //获取当前文件夹路径
                            let s = String(folderDialog.currentFolder)
                            downloadPath.text = s.slice(8, s.length)
                        }
                    }

                    CloudMusicButton {
                        text: "更改目录"
                        anchors.verticalCenter: parent.verticalCenter

                        MouseArea {
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor

                            onClicked: {
                                folderDialog.open()
                            }
                        }
                    }
                }
            }

            //更改缓存目录
            Column {
                id: cacheRow
                spacing: 12

                Label {
                    text: "缓存目录"
                    font.bold: true
                    font.pixelSize: 20
                    color: "white"
                    textFormat: Text.RichText
                    font.family: BasicConfig.fontFamily
                }

                Row {
                    spacing: 16

                    Label {
                        id: cachePath
                        text: "C:\\123\\123"
                        anchors.verticalCenter: parent.verticalCenter
                        font.pixelSize: 19
                        font.family: BasicConfig.fontFamily
                        color: "white"
                    }

                    FolderDialog {
                        id: cacheFolderDialog

                        //点击接收时
                        onAccepted: {
                            //获取当前文件夹路径
                            let s = String(cacheFolderDialog.currentFolder)
                            cachePath.text = s.slice(8, s.length)
                        }
                    }

                    CloudMusicButton {
                        text: "更改目录"
                        anchors.verticalCenter: parent.verticalCenter

                        MouseArea {
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor

                            onClicked: {
                                cacheFolderDialog.open()
                            }
                        }
                    }
                }
            }

            //缓存最大占用
            Row {
                spacing: 16

                Label {
                    anchors.verticalCenter: parent.verticalCenter
                    text: "缓存最大占用"
                    color: "white"
                    font.pixelSize: 20
                    font.family: BasicConfig.fontFamily
                }

                CloudMusicSlider {
                    id: cacheSlider
                    anchors.verticalCenter: parent.verticalCenter
                    width: 400
                    height: 30
                    from: 10
                    to: 50

                    //监听value的变化
                    onValueChanged: {
                        cacheVolume.text = value.toFixed(1).toString() + "G"
                    }

                    Component.onCompleted: {
                        value = 20
                    }
                }

                Label {
                    id: cacheVolume
                    anchors.verticalCenter: parent.verticalCenter
                    text: "20G"
                    color: "white"
                    font.pixelSize: 20
                    font.family: BasicConfig.fontFamily
                }

                CloudMusicButton {
                    anchors.verticalCenter: parent.verticalCenter
                    text: "清除缓存"
                }
            }

            //歌曲命名格式
            Row {
                spacing: 16

                Label {
                    text: "音乐命名格式"
                    anchors.verticalCenter: parent.verticalCenter
                    font.pixelSize: 20
                    font.family: BasicConfig.fontFamily
                    color: "white"
                }

                Row {
                    spacing: 80
                    anchors.verticalCenter: parent.verticalCenter

                    Repeater {
                        model: ["歌曲名", "歌手-歌曲名", "歌曲名-歌手"]

                        delegate: CloudMusicRadioButton2 {
                            text: modelData
                            checked: index === 0
                        }
                    }
                }
            }

            //文件智能分类
            Row {
                spacing: 16

                Label {
                    text: "文件智能分类"
                    anchors.verticalCenter: parent.verticalCenter
                    font.pixelSize: 20
                    font.family: BasicConfig.fontFamily
                    color: "white"
                }

                Row {
                    spacing: 80
                    anchors.verticalCenter: parent.verticalCenter

                    Repeater {
                        model: ["不分文件夹", "按歌手分文件夹", "按歌手\专辑分文件夹"]

                        delegate: CloudMusicRadioButton2 {
                            text: modelData
                            checked: index === 0
                        }
                    }
                }
            }
        }
    }

    //分隔线
    Rectangle {
        id: qualitySplitLine
        width: tileSplitLine.width
        height: 1
        color: "#212127"
    }
}
