//@ pragma UseQApplication
import QtQuick
import Quickshell
import Quickshell.Io
import qs.Bar
import qs.AudioOSD
import qs.Background
import qs.Mixer
import qs.Launcher
import qs.ReloadPopup
import qs.Lock
import qs.NotificationPopup


ShellRoot {
    Loader {
        id: audioOSD
        sourceComponent: AudioOSD {}
    }
    Loader {
        sourceComponent: Bar {}
    }
    Loader {
        sourceComponent: Background {}
    }

    Loader {
        id: mixer

        sourceComponent: Mixer {}
        Component.onCompleted: {
            mixer.item.visible = false;
        }
    }

    Loader {
        id: launcher

        sourceComponent: Launcher {}
        Component.onCompleted: {
            launcher.item.visible = false;
        }
    }

    Loader {
        id: lock
        sourceComponent: Lock {}
    }

    Loader {
        id: notificationPopup
        sourceComponent: NotificationPopup {}
    }

    IpcHandler {
        target: "mixer"

        function open() {
            audioOSD.active = !audioOSD.active;
            launcher.item.visible = false;
            mixer.item.visible = !mixer.item.visible;
        }
    }

    IpcHandler {
        target: "launcher"

        function open() {
            launcher.item.clear();
            mixer.item.visible = false;
            launcher.item.visible = !launcher.item.visible;
        }
    }

    IpcHandler {
        target: "lock"

        function lock() {
            lock.item.lock();
        }
    }
}
