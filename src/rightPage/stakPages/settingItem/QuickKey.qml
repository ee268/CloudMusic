import QtQuick 2.15
import QtQuick.Controls 2.15
import "../../../basic"
import "../../../commonUI"

Column {
    spacing: BasicConfig.settingItemSplitLineTopMargin

    Row {
        spacing: BasicConfig.settingTitleRightMargin

        Label {
            id: quickKeyTitleLabel
            text: "快捷键"
            width: 150
            font.pixelSize: 22
            font.bold: true
            font.family: BasicConfig.fontFamily
            color: "white"
        }

        Column {
            id: optionsCol
            spacing: 40
            property int myColumnSpacing: 50

            Column {
                spacing: 20

                //标题
                Item {
                    id: titleItem
                    property int title1X: 0
                    property int title2X: 0
                    property int title3X: 0
                    width: parent.width
                    height: Math.max(title1.height, Math.max(title2.height, title3.height))

                    Label {
                        id: title1
                        x: parent.title1X
                        text: "功能说明"
                        font.pixelSize: 19
                        font.bold: true
                        font.family: BasicConfig.fontFamily
                        color: "white"
                    }
                    Label {
                        id: title2
                        x: parent.title2X
                        text: "快捷键"
                        font.pixelSize: 19
                        font.bold: true
                        font.family: BasicConfig.fontFamily
                        color: "white"
                    }
                    Label {
                        id: title3
                        x: parent.title3X
                        text: "全局快捷键"
                        font.pixelSize: 19
                        font.bold: true
                        font.family: BasicConfig.fontFamily
                        color: "white"
                    }
                }

                ListModel{
                    id:shotCutModel
                    ListElement{description:"播放/暂停";shotcut:"Ctrl + P";globalShotcut:"Ctrl + Alt + P"}
                    ListElement{description:"上一首";shotcut:"Ctrl + Left";globalShotcut:"Ctrl + Alt + Left"}
                    ListElement{description:"下一首";shotcut:"Ctrl + Right";globalShotcut:"Ctrl + Alt + Right"}
                    ListElement{description:"音量加";shotcut:"Ctrl + Up";globalShotcut:"Ctrl + Alt + Up"}
                    ListElement{description:"音量减";shotcut:"Ctrl + Down";globalShotcut:"Ctrl + Alt + Down"}
                    ListElement{description:"mini/完整模式";shotcut:"Ctrl + M";globalShotcut:"Ctrl + Alt + M"}
                    ListElement{description:"喜欢歌曲";shotcut:"Ctrl + L";globalShotcut:"Ctrl + Alt + L"}
                    ListElement{description:"打开/关闭歌词";shotcut:"Ctrl + D";globalShotcut:"Ctrl + Alt + D"}
                    ListElement{description:"翻译当前歌词";shotcut:"Ctrl + T";globalShotcut:"none"}
                }

                //快捷键修改
                Repeater {
                    id: rep
                    model: shotCutModel

                    delegate: Row {
                        spacing: optionsCol.myColumnSpacing

                        Label {
                            id: funcDesc
                            text: description
                            width: 120
                            font.pixelSize: 19
                            font.family: BasicConfig.fontFamily
                            color: "white"
                        }

                        CloudMusicKeyTextField {
                            id: quickKey
                            text: shotcut
                            height: 40
                            width: 200

                            onKeyPressed: function (key) {
                                // console.log(key)
                                shotCutModel.set(index, { description: description, shotcut: key, globalShotcut: globalShotcut })
                            }
                        }

                        CloudMusicKeyTextField {
                            visible: globalShotcut !== "none"
                            id: allQuickKey
                            text: globalShotcut
                            height: 40
                            width: 200

                            onKeyPressed: function (key) {
                                shotCutModel.set(index, { description: description, shotcut: shotcut, globalShotcut: key })
                            }
                        }

                        Component.onCompleted: {
                            titleItem.title1X = funcDesc.x
                            titleItem.title2X = quickKey.x
                            titleItem.title3X = allQuickKey.x
                        }
                    }
                }
            }

            ButtonGroup {
                id: shotcutBtnGrp
                exclusive: false
            }

            //启用全局快捷键
            CloudMusicRadioButton {
                text: "<span style=\"font-size: 20px;color: white;font-bold:true;\">启用全局快捷键</span>
                        <span style=\"font-size: 20px;color: #89898c;\">(云音乐在后台时也能响应)</span>"
                ButtonGroup.group: shotcutBtnGrp
            }

            Row {
                spacing: 90

                //使用系统媒体快捷键
                CloudMusicRadioButton {
                    anchors.verticalCenter: parent.verticalCenter
                    text: "<span style=\"font-size: 20px;color: white;font-bold:true;\">使用系统媒体快捷键</span>
                            <span style=\"font-size: 20px;color: #89898c;\">(播放/暂停、上一首、下一首、停止)</span>"
                    ButtonGroup.group: shotcutBtnGrp
                }

                CloudMusicButton {
                    anchors.verticalCenter: parent.verticalCenter
                    text: "恢复默认"
                }
            }
        }
    }

    //分隔线
    Rectangle {
        id: quickKeySplitLine
        width: tileSplitLine.width
        height: 1
        color: "#212127"
    }
}
