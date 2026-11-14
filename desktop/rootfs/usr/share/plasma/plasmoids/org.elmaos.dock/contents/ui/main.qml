import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import org.kde.plasma.plasmoid
import org.kde.taskmanager as TaskManager

PlasmoidItem {
    id: root
    preferredRepresentation: fullRepresentation
    Layout.preferredWidth: tasks.count * 57 + 12
    Layout.minimumWidth: Layout.preferredWidth
    TaskManager.TasksModel {
        id: tasks
        groupMode: TaskManager.TasksModel.GroupDisabled
        launcherList: ["applications:elma-dosyalar.desktop", "applications:elma-tarayici.desktop",
                       "applications:elma-terminal.desktop", "applications:elma-notlar.desktop",
                       "applications:elma-magaza.desktop", "applications:elma-ayarlar.desktop",
                       "applications:elma-hesap.desktop"]
    }
    fullRepresentation: Row {
        id: row
        property int hovering: -20
        leftPadding: 6
        rightPadding: 6
        Repeater {
            model: tasks
            delegate: Item {
                id: slot
                required property int index
                required property var model
                width: 57
                height: root.height
                z: row.hovering === index ? 2 : 1
                readonly property string launcher: String(model.LauncherUrlWithoutIcon || "")
                readonly property string key: (launcher.match(/elma-([a-z]+)\.desktop/) || ["", ""])[1]
                readonly property real grow: row.hovering === index ? 1.34 : Math.abs(row.hovering-index) === 1 ? 1.13 : 1
                function activate() {
                    const item = tasks.index(index, 0)
                    if (model.IsWindow && model.IsActive) tasks.requestToggleMinimized(item)
                    else tasks.requestActivate(item)
                }
                ToolButton {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 12 + (slot.grow - 1) * 18
                    width: 52; height: 52
                    icon.width: 50; icon.height: 50
                    icon.source: slot.key ? "file:///usr/share/pixmaps/elma-" + (slot.key === "dosyalar" ? "files" : slot.key) + ".svg" : ""
                    icon.name: slot.key ? "" : String(slot.model.decoration || "application-x-executable")
                    Accessible.name: slot.model.display || slot.key
                    scale: slot.grow
                    Behavior on scale { NumberAnimation { duration: 125; easing.type: Easing.OutCubic } }
                    background: Item {}
                    onClicked: slot.activate()
                    ToolTip.visible: hover.hovered
                    ToolTip.text: Accessible.name
                    ToolTip.delay: 450
                    HoverHandler {
                        id: hover
                        onHoveredChanged: {
                            if (hovered) row.hovering = slot.index
                            else if (row.hovering === slot.index) row.hovering = -20
                        }
                    }
                }
                Rectangle {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 5
                    width: 4; height: 4; radius: 2
                    color: Qt.rgba(0.12, 0.12, 0.15, 0.85)
                    visible: !!slot.model.IsWindow
                }
            }
        }
    }
}
