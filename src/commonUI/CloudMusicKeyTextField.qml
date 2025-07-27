import QtQuick 2.15
import QtQuick.Controls 2.15
import "../basic"

TextField {
    id: quickKeyTextField
    text: ""
    color: "#B7B7B9"
    focus: false
    readOnly: true
    cursorVisible: true
    font.pixelSize: 20
    font.family: BasicConfig.fontFamily

    signal keyPressed(string key)

    background: Rectangle {
        id: bgRect
        color: "#1A1A21"
        border {
            width: 1
            color: "#222228"
        }
        radius: height / 2

        //模拟光标
        Rectangle {
            id:focusRect
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.topMargin: 8
            anchors.bottomMargin: 8
            width: 1
            visible: quickKeyTextField.focus
            anchors.leftMargin: quickKeyTextField.implicitWidth
        }

        //光标闪烁动画
        SequentialAnimation{
            id:focusAnimation
            running: quickKeyTextField.focus
            loops: Animation.Infinite
            PropertyAnimation {
                target: focusRect
                property: "opacity"
                from:1
                to:0
                duration: 300
            }

            PropertyAnimation {
                target: focusRect
                property: "opacity"
                from:0
                to:1
                duration: 300
            }
        }

        MouseArea {
            anchors.fill: parent
            propagateComposedEvents: true
            cursorShape: Qt.IBeamCursor
            hoverEnabled: true

            onEntered: {
                if (quickKeyTextField.focus) {
                    bgRect.border.width = 1
                }
                else {
                    bgRect.border.width = 0
                }
            }

            onExited: {
                if (quickKeyTextField.focus) {
                    bgRect.border.width = 1
                }
                else {
                    bgRect.border.width = 1
                }
            }

            onClicked: {
                // quickKeyTextField.focus = true
                quickKeyTextField.forceActiveFocus()
                bgRect.border.width = 1
            }
        }
    }

    //onActiveFocusChanged: console.log("Focus changed:", activeFocus)

    Keys.onPressed: {
        // console.log(event.key)
        if (!focus) return

        let str = ""
        if (event.modifiers & Qt.ControlModifier) {
            str += "Ctrl + "
        }
        if (event.modifiers & Qt.ShiftModifier) {
            str += "Shift + "
        }
        if (event.modifiers & Qt.AltModifier) {
            str += "Alt + "
        }
        str += String.fromCharCode(event.key)
        keyPressed(str)
    }
}
