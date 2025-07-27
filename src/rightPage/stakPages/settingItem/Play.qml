import QtQuick 2.15
import QtQuick.Controls 2.15
import "../../../basic"
import "../../../commonUI"

Column {
    spacing: BasicConfig.settingItemSplitLineTopMargin

    Row {
        spacing: BasicConfig.settingTitleRightMargin

        Label {
            id: playTitleLabel
            text: "播放"
            width: 150
            font.pixelSize: 22
            font.bold: true
            font.family: BasicConfig.fontFamily
            color: "white"
        }
    }

    //分隔线
    Rectangle {
        id: playSplitLine
        width: tileSplitLine.width
        height: 1
        color: "#212127"
    }
}
