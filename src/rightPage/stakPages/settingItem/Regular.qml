import QtQuick 2.15
import QtQuick.Controls 2.15
import "../../../basic"
import "../../../commonUI"

//常规设置
Column {
    spacing: BasicConfig.settingItemSplitLineTopMargin

    Row {
        spacing: BasicConfig.settingTitleRightMargin

        Label {
            id: regularTitleLabel
            text: "常规"
            width: 150
            font.pixelSize: 22
            font.bold: true
            font.family: BasicConfig.fontFamily
            color: "white"
        }

        Column {
            spacing: 40

            //字体选择，下拉单选框
            Column {
                id: fontSelectorCol
                spacing: 12

                Label{
                    id: regularDiscriptionLabel
                    font.pixelSize: 18
                    font.family: BasicConfig.fontFamily
                    color:"#e8e8e8"
                    textFormat: Text.RichText
                    text: "<span style=\"font-size: 20px;color: white;font-bold:true;\">字体选择</span>
                           <span style=\"font-size: 20px;color: #89898c;\">(如果字体显示不清晰，请在控制面板-字体设置中启动系统Clear Type设置)</span>"
                }

                CloudMusicSettingComboBox {
                    id: fontSelctorCbx
                    //下拉框内容
                    model: ["默认","仿宋","华文中宋","华文仿宋","华文宋体","华文新魏","华文楷体","华文细黑","华文行书"
                        ,"华文楷书","宋体","幼圆","微软雅黑","微软雅黑 Light","新宋体","方正姚体","方正舒体"]
                }
            }

            Repeater {
                id: otherOptionsRep
                model: ["<span style=\"font-size: 20px;color: #fff;font-family:'微软雅黑';font-bold:true;\">开机自动运行</span>",
                    "<span style=\"font-size: 20px;color: #fff;font-family:'微软雅黑';font-bold:true;\">将云音乐设为默认播放器</span>",
                    "<span style=\"font-size: 20px;color: #fff;font-family:'微软雅黑';font-bold:true;\">开启GPU加速</span><span style=\"font-size: 20px;color: #89898c;font-family:'微软雅黑';\">(若软件黑屏，请关闭GPU加速尝试解决)</span>",
                    "<span style=\"font-size: 20px;color: #fff;font-family:'微软雅黑';font-bold:true;\">禁用动画效果</span><span style=\"font-size: 20px;color: #89898c;font-family:'微软雅黑';\">(减少部分资源占用)</span>",
                    "<span style=\"font-size: 20px;color: #fff;font-family:'微软雅黑';font-bold:true;\">禁用系统缩放比例</span><span style=\"font-size: 20px;color: #89898c;font-family:'微软雅黑';\">(减少部分资源占用)</span><br><span>*高清屏适配，禁用后建议重启软件</span>"]

                delegate: Row {
                    id: optionsRow
                    spacing: 70
                    property int curIndex: index

                    CloudMusicRadioButton {
                        id: rdBtn
                        text: modelData
                        isAlignTop: true

                        onCheckedChanged: {
                            if (!rdBtn.checked) {
                                minisizeShow.checked = false
                                frontShow.checked = false
                            }
                            else {
                                minisizeShow.checked = true
                            }
                        }
                    }

                    ButtonGroup {
                        id: btnGrp
                        exclusive: true
                    }

                    CloudMusicRadioButton2 {
                        id: minisizeShow
                        text: "最小化展示"
                        ButtonGroup.group: btnGrp
                        opacity: rdBtn.checked ? 1 : 0.3
                        visible: optionsRow.curIndex === 0
                        anchors.verticalCenter: rdBtn.verticalCenter

                        MouseArea {
                            anchors.fill: parent
                            cursorShape: rdBtn.checked ? Qt.PointingHandCursor : Qt.ForbiddenCursor

                            onClicked: {
                                if (rdBtn.checked) {
                                    minisizeShow.checked = !minisizeShow.checked
                                }
                            }
                        }
                    }

                    CloudMusicRadioButton2 {
                        id: frontShow
                        text: "前台展示"
                        ButtonGroup.group: btnGrp
                        opacity: rdBtn.checked ? 1 : 0.3
                        visible: optionsRow.curIndex === 0
                        anchors.verticalCenter: rdBtn.verticalCenter

                        MouseArea {
                            anchors.fill: parent
                            cursorShape: rdBtn.checked ? Qt.PointingHandCursor : Qt.ForbiddenCursor

                            onClicked: {
                                if (rdBtn.checked) {
                                    frontShow.checked = !frontShow.checked
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
        id: regularSplitLine
        width: tileSplitLine.width
        height: 1
        color: "#212127"
    }
}
