import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Notifications
import Quickshell.Wayland
import qs

Scope {
    id: root
    NotificationServer {
        id: server
        onNotification: n => {
            n.tracked = true;
        }
    }

    PanelWindow {
        WlrLayershell.layer: WlrLayer.Top
        anchors.top: true
        anchors.right: true
        margins.top: 10
        margins.right: 10
        implicitWidth: 300
        implicitHeight: 350
        color: "transparent"
        exclusiveZone: 0

        Item {
            anchors.fill: parent

            Repeater {
                model: server.trackedNotifications.values.slice(0, 5)
                Rectangle {
                    x: 0
                    y: index * 60
                    width: 300
                    height: 50
                    border.width: 1
                    border.color: "#666666"
                    color: "#222222"

                    MouseArea {
                        anchors.fill: parent
                        ColumnLayout {
                            anchors.fill: parent
                            anchors.margins: 5
                            Text {
                                Layout.fillWidth: true
                                font.pixelSize: 16
                                color: "white"
                                font.family: Config.fontFamily
                                text: ` ${modelData.appName} - ${modelData.summary}`
                                elide: Text.ElideRight
                                maximumLineCount: 1
                            }
                            Text {
                                Layout.fillWidth: true
                                font.pixelSize: 14
                                color: "white"
                                font.family: Config.fontFamily
                                text: " " + modelData.body
                                elide: Text.ElideRight
                                maximumLineCount: 2
                            }
                        }
                        onClicked: mouse => {
                            modelData.dismiss();
                        }
                    }
                    Timer {
                        interval: 5000
                        running: true
                        repeat: false
                        onTriggered: {
                            modelData.expire();
                        }
                    }
                }
            }

            Rectangle {
                visible: server.trackedNotifications.values.length > 5
                x: 0
                y: server.trackedNotifications.values.slice(0, 5).length * 60
                width: 300
                height: 50
                border.width: 1
                color: "#222222"
                border.color: "#666666"
                Text {
                    color: "white"
                    font.pixelSize: 14
                    anchors.fill: parent
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.family: Config.fontFamily
                    text: `${server.trackedNotifications.values.length - 5}+ more notifications`
                }
            }
        }
    }
}
