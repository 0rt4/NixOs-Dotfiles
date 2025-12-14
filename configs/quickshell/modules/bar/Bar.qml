import QtQuick
import Quickshell

PanelWindow {
    id: panel

    readonly property string fontStyle: "inter"
    readonly property int fontSize: 15
    anchors {
        top: true
        left: true
        right: true
    }

    color: "transparent"
    implicitHeight: 40
    margins {
        top: 2
        left: 2
        right: 2
    }

    Rectangle { 
        id: bar
        anchors.fill: parent
        color: "#000000ff" 
        radius: 15

        Row { 
            id: tasksRow

            anchors {
                left: parent.left
                verticalCenter: parent.verticalCenter 
                leftMargin: 16
            }
            spacing: 8
            Rectangle {
                width: 50
                height: 35
                color: "#1a1a1a"
                radius: 8
                border.color: "#333333"
                border.width: 1
                Text {
                    anchors.centerIn: parent
                    text:""
                    color:"#5c53ff"
                    font.pixelSize: 30
                }
            }
        }

        // Row contenedor para fecha y hora
        Row {
            anchors {
                right: parent.right
                verticalCenter: parent.verticalCenter
                rightMargin: 16
            }
            spacing: 8

            // Rectangle para la fecha
            Rectangle {
                width: dateText.width + 16
                height: 28
                color: "#1a1a1a"
                radius: 8
                border.color: "#333333"
                border.width: 1

                Text {
                    id: dateText
                    anchors.centerIn: parent
                    property string currentDate: ""
                    text: currentDate
                    color: "#ffffff"
                    font.pixelSize: fontSize
                    font.family: fontStyle
                }
            }

            // Rectangle para la hora
            Rectangle {
                width: timeText.width + 16
                height: 28
                color: "#1a1a1a"
                radius: 8
                border.color: "#333333"
                border.width: 1

                Text {
                    id: timeText
                    anchors.centerIn: parent
                    property string currentTime: ""
                    text: currentTime
                    color: "#ffffff"
                    font.pixelSize: fontSize
                    font.family: fontStyle
                }
            }
        }

        // Timer para actualizar fecha y hora
        Timer {
            interval: 1000
            running: true
            repeat: true
            onTriggered: {
                var now = new Date()
                // Usar locale español explícitamente
                dateText.currentDate = now.toLocaleDateString(Qt.locale("es_MX"), "MMMM dd")
                timeText.currentTime = now.toLocaleTimeString(Qt.locale("es_MX"), "h:mm AP")
            }
        }

        Component.onCompleted: {
            var now = new Date()
            // Usar locale español explícitamente
            dateText.currentDate = now.toLocaleDateString(Qt.locale("es_MX"), "MMMM dd")
            timeText.currentTime = now.toLocaleTimeString(Qt.locale("es_MX"), "h:mm AP")
        }
    }
}