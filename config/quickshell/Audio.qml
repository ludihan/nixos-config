import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Pipewire
import Quickshell.Widgets
import Quickshell.Wayland

Scope {
    id: root

    PwObjectTracker {
        objects: [
            Pipewire.defaultAudioSink,
            Pipewire.defaultAudioSource
        ]
    }

    //
    // SPEAKER
    //
    property bool showVolOsd: false

    Connections {
        target: Pipewire.defaultAudioSink?.audio

        function onVolumeChanged() {
            root.showVolOsd = true
            volHideTimer.restart()
        }

        function onMuteChanged() {
            root.showVolOsd = true
            volHideTimer.restart()
        }
    }

    Timer {
        id: volHideTimer
        interval: 1200
        onTriggered: root.showVolOsd = false
    }

    //
    // MICROPHONE
    //
    property bool showMicOsd: false

    Connections {
        target: Pipewire.defaultAudioSource?.audio

        function onVolumeChanged() {
            root.showMicOsd = true
            micHideTimer.restart()
        }

        function onMuteChanged() {
            root.showMicOsd = true
            micHideTimer.restart()
        }
    }

    Timer {
        id: micHideTimer
        interval: 1200
        onTriggered: root.showMicOsd = false
    }

    //
    // SPEAKER OSD
    //
    LazyLoader {
        active: root.showVolOsd

        PanelWindow {
            WlrLayershell.layer: WlrLayer.Overlay
            focusable: false

            anchors.bottom: true
            margins.bottom: screen.height / 8
            implicitWidth: 400
            implicitHeight: 60
            color: "transparent"
            mask: Region {}
            exclusiveZone: 0

            property var audio: Pipewire.defaultAudioSink?.audio
            property bool muted: audio?.muted ?? false
            property real vol: audio?.volume ?? 0

            Rectangle {
                anchors.fill: parent
                radius: height / 2
                color: "#80000000"

                RowLayout {
                    anchors.fill: parent
                    anchors.leftMargin: 14
                    anchors.rightMargin: 20
                    spacing: 12

                    Text {
                        text: "VOL"
                        color: "white"
                        font.pixelSize: parent.height * 0.3
                        font.family: "Iosevka"
                    }

                    Rectangle {
                        Layout.fillWidth: true
                        implicitHeight: 10
                        radius: 20
                        color: "#50ffffff"

                        Rectangle {
                            anchors.fill: undefined
                            anchors.left: parent.left
                            anchors.top: parent.top
                            anchors.bottom: parent.bottom

                            implicitWidth: parent.width * vol
                            color: muted ? "#ff5555" : "white"
                            radius: parent.radius
                        }
                    }
                }
            }
        }
    }

    //
    // MICROPHONE OSD
    //
    LazyLoader {
        active: root.showMicOsd

        PanelWindow {
            WlrLayershell.layer: WlrLayer.Overlay
            focusable: false

            anchors.bottom: true
            margins.bottom: screen.height / 5
            implicitWidth: 400
            implicitHeight: 60
            color: "transparent"
            mask: Region {}
            exclusiveZone: 0

            property var audio: Pipewire.defaultAudioSource?.audio
            property bool muted: audio?.muted ?? false
            property real vol: audio?.volume ?? 0

            Rectangle {
                anchors.fill: parent
                radius: height / 2
                color: "#80000000"

                RowLayout {
                    anchors.fill: parent
                    anchors.leftMargin: 14
                    anchors.rightMargin: 20
                    spacing: 12

                    Text {
                        text: "MIC"
                        color: "white"
                        font.pixelSize: parent.height * 0.3
                        font.family: "Iosevka"
                    }

                    Rectangle {
                        Layout.fillWidth: true
                        implicitHeight: 10
                        radius: 20
                        color: "#50ffffff"

                        Rectangle {
                            anchors.left: parent.left
                            anchors.top: parent.top
                            anchors.bottom: parent.bottom

                            implicitWidth: parent.width * vol
                            color: muted ? "#ff5555" : "white"
                            radius: parent.radius
                        }
                    }
                }
            }
        }
    }
}
