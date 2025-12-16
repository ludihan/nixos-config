import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Pipewire
import Quickshell.Wayland

PanelWindow {
    WlrLayershell.layer: WlrLayer.Overlay
    implicitWidth: 800
    implicitHeight: 800
    // match the system theme background color
    color: "#1A1A1A"
    ScrollView {
        anchors.fill: parent
        contentWidth: availableWidth
        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 10


            Rectangle {
                Layout.fillWidth: true
                color: palette.active.text
                implicitHeight: 1
            }

            Repeater {
                model: DesktopEntries.applications

                Entry {
                    required property DesktopEntry modelData

                    entry: modelData
                }
            }
        }
    }
}
