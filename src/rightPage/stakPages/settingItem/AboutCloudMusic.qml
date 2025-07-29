import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15
import "../../../basic"
import "../../../commonUI"

Column {
    spacing: BasicConfig.settingItemSplitLineTopMargin

    Row {
        spacing: BasicConfig.settingTitleRightMargin

        Label {
            id: aboutTitleLabel
            text: "关于云音乐"
            width: 150
            font.pixelSize: 22
            font.bold: true
            font.family: BasicConfig.fontFamily
            color: "white"
        }

        Column {
            Row {
                spacing: 10

                Image {
                    id: siteIcon
                    anchors.verticalCenter: parent.verticalCenter
                    source: "qrc:/resources/setting/github.png"
                    layer.enabled: true
                    layer.effect: ColorOverlay {
                        source: siteIcon
                        color: "white"
                    }
                }

                FontGrade {
                    anchors.verticalCenter: parent.verticalCenter
                    info: "https://github.com/ee268/CloudMusic"

                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor

                        onClicked: {
                            Qt.openUrlExternally("https://github.com/ee268/CloudMusic")
                        }
                    }
                }
            }
        }
    }

    // //分隔线
    // Rectangle {
    //     id: aboutSplitLine
    //     width: tileSplitLine.width
    //     height: 1
    //     color: "#212127"
    // }
}
