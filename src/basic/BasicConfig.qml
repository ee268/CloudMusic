pragma Singleton
import QtQuick 2.15

QtObject {
    id: basicConfig
    property string fontFamily: "微软雅黑" //全局字体样式
    property bool searchTextFieldFocus: false //搜索框是否获取焦点
    property bool isWindowMax: false //窗口是否为最大化
    property string maxImgUrl: "qrc:/resources/title/max.png" //窗口最大化图标
    property int loginPopupCodeAniDuration: 200 // 登录弹窗二维码过渡动画持续时间    
    property int settingTitleRightMargin: 25 //设置页面item标题的右边距
    property int settingItemSplitLineTopMargin: 32 //设置页面item的分隔线上边距
    property color finishedLyricsUpColor: "#ee8784"                             //已播放歌词的上渐变颜色
    property color finishedLyricsDownColor: "#f3b3b1"                           //已播放歌词的下渐变颜色
    property color finishedLyricsBorderColor: "#ffff91"                         //已播放歌词的边框颜色
    property color unFinishedLyricsUpColor: "white"                             //未播放歌词的上渐变颜色
    property color unFinishedLyricsDownColor: "#ddd"                            //未播放歌词的下渐变颜色
    property color unFinishedLyricsBorderColor: "white"                         //未播放歌词的边框颜色
    property int openLyricColorPopupModel: 0 //打开已播放窗口-0，未播放窗口-1

    signal openLyricColorPopup() //打开歌词颜色选择弹窗
    signal closeLyricColorPopup() //关闭歌词颜色选择弹窗
    signal cancelFocus() //取消控件焦点
    signal openLoginPopup() //打开登录弹窗
    signal closeLoginPopup() //关闭登录弹窗
    signal changeLoginPopBgToQrCode() //改变登录弹窗背景为扫码登录
    signal changeLoginPopBgToOther() //改变登录弹窗背景为其他登录
}
