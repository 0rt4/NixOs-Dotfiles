import QtQuick
import Quickshell

PanelWindow{
    id: workspacePanel
    anchors{
        left: true
        
    }
    exclusionMode: ExclusionMode.Ignore
    implicitWidth: 50
    Rectangle{
        id:workspaces
        color: "#0a0a0aff"
    }
}