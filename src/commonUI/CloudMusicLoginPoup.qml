import QtQuick 2.15
import QtQuick.Controls 2.15
import "../basic"
import "./loginPopupBg"

Popup {
    id: loginPopup
    width: 456
    height: 638
    clip: true
    closePolicy: Popup.NoAutoClose

    Connections {
        target: BasicConfig
        //处理改变背景为扫码登录
        function onChangeLoginPopBgToQrCode() {
            loaderBg.sourceComponent = popupCodeBg

        }

        //处理改变背景为其他登录
        function onChangeLoginPopBgToOther() {
            loaderBg.sourceComponent = popupOtherBg
        }
    }

    background: Item {
        id: popupBg
        anchors.fill: parent

        Component {
            id: popupCodeBg
            QrCodeBg {}
        }

        Component {
            id: popupOtherBg
            OtherLoginBg {}
        }

        Loader {
            id: loaderBg
            sourceComponent: popupCodeBg
            anchors.fill: parent
        }

        //可拖动弹窗
        // MouseArea {
        //     anchors.fill: parent
        //     propagateComposedEvents: true
        //     property point clickPos: "0, 0"

        //     onPressed: function(mouse) {
        //         clickPos = Qt.point(mouse.x, mouse.y)
        //         // console.log(clickPos)
        //         // mouse.accepted = false
        //     }

        //     onPositionChanged: function(mouse) {
        //         let delta = Qt.point(mouse.x - clickPos.x, mouse.y - clickPos.y)

        //         loginPopup.x += delta.x
        //         loginPopup.y += delta.y
        //     }
        // }
    }

    onClosed: {
        loaderBg.sourceComponent = popupCodeBg
    }
}
