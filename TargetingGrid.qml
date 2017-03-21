import QtQuick 2.0
import "main.js" as Scripts

Item {
    clip:true
    property int bordernum: 2
    property int gridcreated: 0
    property int mode: 1
    onModeChanged: if(mode == 2) {Scripts.mapgrid(),Scripts.mode_change(2)} else {Scripts.mapgrid(),Scripts.mode_change(1)}
    onScaleChanged: if(scale == 1) {Scripts.mapgrid(),Scripts.mode_change(1)}

    Background {
        anchors.fill: parent
        clip:true
    }

    Item {
        id:gridarea
        anchors.left:parent.left
        anchors.leftMargin: parent.height * 0.03
        width:parent.width
        height:parent.height

    }

    Image {
        anchors.right:parent.left
        anchors.rightMargin:-parent.height * 0.07
        source:"file:img/borders/border"+bordernum+".png"
        height:parent.height
    }

    Image {
        anchors.left:parent.right
        mirror:true
        anchors.leftMargin:-parent.height * 0.07
        source:"file:img/borders/border"+bordernum+".png"
        height:parent.height

    }




}
