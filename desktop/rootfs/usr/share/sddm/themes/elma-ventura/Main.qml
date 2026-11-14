import QtQuick
import QtQuick.Controls
Item {
 id: root
 property string errorText: ""
 function enter() {
   if (users.currentIndex >= 0 && sessions.currentIndex >= 0)
     sddm.login(users.currentValue, secret.text, sessions.currentIndex)
 }
 Image { anchors.fill: parent; fillMode: Image.PreserveAspectCrop; source: "file:///usr/share/wallpapers/ElmaVentura/contents/images/1920x1080.svg" }
 Rectangle { anchors.fill: parent; color: "#22000000" }
 Text {
   id: clock
   anchors.right: parent.right; anchors.top: parent.top; anchors.margins: 12
   color: "white"; text: Qt.formatTime(new Date(), "hh:mm")
   Timer { interval: 1000; repeat: true; running: true; onTriggered: clock.text = Qt.formatTime(new Date(), "hh:mm") }
 }
 Column {
   anchors.horizontalCenter: parent.horizontalCenter
   y: parent.height * 0.347; spacing: 12
   Rectangle {
     anchors.horizontalCenter: parent.horizontalCenter
     width: Math.max(70, root.height * 0.125); height: width; radius: width / 2
     color: "#18171a"; border.color: "#aaffffff"
     Repeater {
       model: 12
       Rectangle {
         required property int index
         anchors.centerIn: parent
         width: parent.width * (0.28 + index * 0.055)
         height: width; radius: width / 2
         color: "transparent"; border.color: "#38ffffff"
       }
     }
     Rectangle {
       anchors.centerIn: parent
       width: parent.width * 0.27; height: width; radius: width / 2; color: "#bc2030"
       Rectangle { anchors.centerIn: parent; width: 4; height: 4; radius: 2; color: "#efdbc8" }
     }
   }
   Text { anchors.horizontalCenter: parent.horizontalCenter; visible: users.count === 1; text: users.currentText || users.currentValue || ""; color: "white"; font.pixelSize: 17; font.bold: true }
   ComboBox { id: users; anchors.horizontalCenter: parent.horizontalCenter; visible: count !== 1; model: userModel; textRole: "realName"; valueRole: "name"; currentIndex: userModel.lastIndex >= 0 ? userModel.lastIndex : (count ? 0 : -1) }
   Row {
     anchors.horizontalCenter: parent.horizontalCenter; spacing: 6
     TextField {
       id: secret; width: 144; height: 28; leftPadding: 12; focus: true
       color: "white"; placeholderText: "Parolayı girin"; placeholderTextColor: "#ddffffff"; echoMode: TextInput.Password
       background: Rectangle { radius: height / 2; color: "#60ffffff" }
       onAccepted: root.enter()
     }
     Button { text: "→"; width: 28; height: 28; onClicked: root.enter(); background: Rectangle { radius: height / 2; color: "#60ffffff" } }
   }
   Text { anchors.horizontalCenter: parent.horizontalCenter; text: root.errorText; color: "white"; visible: text.length > 0 }
   ComboBox { id: sessions; anchors.horizontalCenter: parent.horizontalCenter; visible: count > 1; model: sessionModel; textRole: "name"; currentIndex: sessionModel.lastIndex >= 0 ? sessionModel.lastIndex : (count ? 0 : -1) }
 }
 Row {
   anchors.horizontalCenter: parent.horizontalCenter; anchors.bottom: parent.bottom; anchors.bottomMargin: parent.height * 0.045; spacing: 14
   Repeater {
     model: [{symbol:"⏻", label:"Kapat", allowed:sddm.canPowerOff},
             {symbol:"↻", label:"Yeniden Başlat", allowed:sddm.canReboot},
             {symbol:"☾", label:"Uyku", allowed:sddm.canSuspend}]
     delegate: Button {
       required property int index
       required property var modelData
       text: modelData.label
       visible: modelData.allowed
       width: 91; height: 53
       background: Item {}
       contentItem: Column {
         spacing: 6
         Text { anchors.horizontalCenter: parent.horizontalCenter; text: modelData.symbol; color: "white"; font.pixelSize: 24 }
         Text { anchors.horizontalCenter: parent.horizontalCenter; text: modelData.label; color: "white"; font.pixelSize: 12 }
       }
       onClicked: {
         if (index === 0) sddm.powerOff()
         else if (index === 1) sddm.reboot()
         else sddm.suspend()
       }
     }
   }
 }
 Connections { target: sddm; function onLoginFailed() { root.errorText = "Giriş başarısız."; secret.clear(); secret.forceActiveFocus() } }
}
