import QtQuick 2.7
import QtQuick.Window 2.2

Window {
    visible: true
    width: Screen.desktopAvailableWidth * 0.9
    height: Screen.desktopAvailableHeight * 0.9
    title: qsTr("Engage")
    color:"black"

    property string selectedrace: ""
    property string selectedtype: ""
    property var tiles: new Array(maxIndex);
    property var locations: new Array(maxIndex);
    property var enemy_locations: new Array(maxIndex);
    property var enemy_firedon: new Array(maxIndex);

    property var firedon: new Array(maxIndex);

    property var ships_placed: new Array(6);
    property int currentship: 0
    property int  maxColumn: 18;
    property int maxRow: 12;
    property int  maxIndex: maxRow * maxColumn;

    property int destroyer1_power: 0
    property int destroyer2_power: 0
    property int carrier_power: 0
    property int support_power: 0
    property int scout1_power: 0
    property int scout2_power: 0


Placement {
    id:theplacement
    anchors.fill: parent
    state:"unload"
}

Targeting {
    id:battlescreen
    anchors.fill:parent
    state:"unload"

    }

    EnMenu {
        id:mainmenu
        width:parent.width
        height:parent.height
    }

    FleetSelect {
        id:fleets
        width:parent.width
        height:parent.height
        visible: false
    }

/*Timer {
    interval: 2000
    running:true
    repeat:false
   // onTriggered: theplacement.state = "reload"
} */

    Info {
        id:infoWindow
        anchors.horizontalCenter: parent.horizontalCenter
        width:parent.width * 0.6
        height:parent.height * 0.3
        state:"Hide"
    }

Splash {
    anchors.fill: parent
    state:"Show"
}

}
