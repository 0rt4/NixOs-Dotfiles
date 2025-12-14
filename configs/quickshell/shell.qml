// @ pragma UseQApplication

import QtQuick
import Quickshell
import "./modules/bar/"
import "./modules/workspaces/"


ShellRoot {
    id: root

    Loader {
        active:true
        sourceComponent: Bar {} 
    }
    //Workspaces{}
}