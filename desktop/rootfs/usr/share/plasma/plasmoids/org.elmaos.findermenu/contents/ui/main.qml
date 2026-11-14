import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtCore
import org.kde.taskmanager as TaskManager
import org.kde.plasma.plasmoid

PlasmoidItem {
    id: root
    preferredRepresentation: fullRepresentation
    readonly property bool finderActive: {
        const active = windows.activeTask
        if (!active.valid) return true
        const id = String(windows.data(active, TaskManager.AbstractTasksModel.AppId)).toLowerCase()
        return id.includes("dolphin") || id.includes("elma-dosyalar")
    }
    TaskManager.TasksModel { id: windows }
    Layout.minimumWidth: finderActive ? 300 : 0
    Layout.preferredWidth: Layout.minimumWidth
    fullRepresentation: Row {
        visible: root.finderActive
        spacing: 1
        Repeater {
            model: [
                {name: "Finder", items: ["Ev klasörü", "Masaüstü"], urls: [StandardPaths.writableLocation(StandardPaths.HomeLocation), StandardPaths.writableLocation(StandardPaths.DesktopLocation)]},
                {name: "Dosya", items: ["Belgeler"], urls: [StandardPaths.writableLocation(StandardPaths.DocumentsLocation)]},
                {name: "Görünüm", items: ["Resimler"], urls: [StandardPaths.writableLocation(StandardPaths.PicturesLocation)]},
                {name: "Git", items: ["İndirilenler", "Bilgisayar"], urls: [StandardPaths.writableLocation(StandardPaths.DownloadLocation), "file:///"]},
                {name: "Yardım", items: ["ElmaOS"], urls: ["https://github.com/canbey123x/ElmaOS"]}
            ]
            delegate: ToolButton {
                id: entry
                required property var modelData
                text: modelData.name
                font.bold: text === "Finder"
                height: root.height
                onClicked: popup.open()
                Menu {
                    id: popup
                    y: entry.height
                    Repeater {
                        model: entry.modelData.items
                        delegate: MenuItem {
                            required property int index
                            required property string modelData
                            text: modelData
                            onTriggered: Qt.openUrlExternally(entry.modelData.urls[index])
                        }
                    }
                }
            }
        }
    }
}
