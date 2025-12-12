import QtQuick
import Quickshell
import Quickshell.Io

Item {
    id: root
    function sendSocketCommand(sock, command) {
        sock.write(JSON.stringify(command) + "\n");
        sock.flush();
    }
    Socket {
        id: niriEventStream
        connected: false
        path: Quickshell.env("NIRI_SOCKET")
        parser: SplitParser {
            onRead: message => console.log(`read message from socket: ${message}`)
        }
    }

    Socket {
        id: niriCommandSocket
        connected: false
        path: Quickshell.env("NIRI_SOCKET")
        parser: SplitParser {
            onRead: message => console.log(`read message from socket: ${message}`)
        }
    }
    Component.onCompleted: {
        niriEventStream.connected = true;
        niriCommandSocket.connected = true;
        root.sendSocketCommand(niriEventStream, "EventStream");
    }
}
