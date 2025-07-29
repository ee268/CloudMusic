import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15
import "../basic"

Item {
   id: fontGrade
   width: name.implicitWidth
   height: name.implicitHeight
   property string info: "hello world"
   property int idxx: 1
   Label {
       id: name
       text: info
       anchors.fill: parent
       font.pixelSize: 20
       // font.bold: true
       font.family: BasicConfig.fontFamily
   }
   LinearGradient  {
       anchors.fill: name
       source: name
       start: Qt.point(0, 0)  // start 和 end主要作用是从左往右
       end: Qt.point(fontGrade.width, 0)
       gradient: Gradient {
           GradientStop { position: 0.0; color: Qt.hsva((15 - (((idxx + 10) > 15) ? idxx - 15 + 10:idxx + 10)) * 16/255, 1, 1,1) }
           GradientStop { position: 0.1; color: Qt.hsva((15 - (((idxx + 9) > 15) ? idxx - 15 + 9:idxx + 9)) * 16/255, 1, 1,1) }
           GradientStop { position: 0.2; color: Qt.hsva((15 - (((idxx + 8) > 15) ? idxx - 15 + 8:idxx + 8)) * 16/255, 1, 1,1) }
           GradientStop { position: 0.3; color: Qt.hsva((15 - (((idxx + 7) > 15) ? idxx - 15 + 7:idxx + 7)) * 16/255, 1, 1,1) }
           GradientStop { position: 0.4; color: Qt.hsva((15 - (((idxx + 6) > 15) ? idxx - 15 + 6:idxx + 6)) * 16/255, 1, 1,1) }
           GradientStop { position: 0.5; color: Qt.hsva((15 - (((idxx + 5) > 15) ? idxx - 15 + 5:idxx + 5)) * 16/255, 1, 1,1) }
           GradientStop { position: 0.6; color: Qt.hsva((15 - (((idxx + 4) > 15) ? idxx - 15 + 4:idxx + 4)) * 16/255, 1, 1,1) }
           GradientStop { position: 0.7; color: Qt.hsva((15 - (((idxx + 3) > 15) ? idxx - 15 + 3:idxx + 3)) * 16/255, 1, 1,1) }
           GradientStop { position: 0.8; color: Qt.hsva((15 - (((idxx + 2) > 15) ? idxx - 15 + 2:idxx + 2)) * 16/255, 1, 1,1) }
           GradientStop { position: 0.9; color: Qt.hsva((15 - (((idxx + 1) > 15) ? idxx - 15 + 1:idxx + 1)) * 16/255, 1, 1,1) }
           GradientStop { position: 1.0; color: Qt.hsva((15 - (((idxx) > 15) ? idxx - 15:idxx)) * 16/255, 1, 1,1) }
       }
   }

   SequentialAnimation {
       running: true  // 默认启动
       loops:Animation.Infinite  // 无限循环
       NumberAnimation {
           target: fontGrade  // 目标对象
           property: "idxx"  // 目标对象中的属性
           duration: 1000 // 变化时间
           to: 15  // 目标值
       }
   }
}
