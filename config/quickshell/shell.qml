//@ pragma UseQApplication
import QtQuick
import Quickshell
import qs.Bar
import qs.AudioOSD
import qs.Background

ShellRoot {
    Loader {
        sourceComponent: AudioOSD {}
    }
    Loader {
        sourceComponent: Bar {}
    }
    Loader {
        sourceComponent: Background {}
    }
}
