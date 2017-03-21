import QtQuick 2.0
import QtGraphicalEffects 1.0

Item {
    id:window_container

    property string message: ""
    property int played: 0
    property int bordernum: 1
    property int endinfo: 0

    states: [
        State {
            name: "Hide"
            PropertyChanges {
                target: window_container
                y:parent.height * 1.2

            }
        },

        State {
            name:"Show"
            PropertyChanges {
                target: window_container
                y:parent.height /2 - (window_container.height /2)
            }
        }

    ]

    transitions: [
        Transition {
            from: "Hide"
            to: "Show"
            reversible: true

            NumberAnimation {
                target: window_container
                property: "y"
                duration: 400
                easing.type: Easing.InOutQuad
            }
        }
    ]

    onStateChanged: if(endinfo == 0) { if(state == "Show") {starttext.running = true} }
                    else { }


    Timer {
        id:starttext
        running:false
        repeat:false
        interval: 2000
        onTriggered:message = "Start",hide.running = true
    }

    Timer {
        id:hide
        running:false
        repeat:false
        interval:400
        onTriggered: window_container.state = "Hide",played = 1
    }



    Rectangle {
        id:backing
        anchors.fill: parent
        color:"black"
        //opacity:0.5


    }

    Text {
        id:textinfo
        anchors.centerIn: parent
        font.family: pixeltext.name
        font.pixelSize: parent.height * 0.28
        text:message
        color:"White"
    }

    Text {
        id:backmenu
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom:parent.bottom
        text:"Main Menu"
        color:"white"
        font.pixelSize: parent.height * 0.15
        visible: if(endinfo == 1) {true} else {false}
        MouseArea {
            anchors.fill: parent
            onClicked: battlescreen.state = "unload",hide.running = true, mainmenu.visible = true,theplacement.state = "unload"
        }
    }

    Image {
        anchors.right:parent.left
        anchors.rightMargin:-parent.height * 0.1
        source:"file:img/borders/border"+bordernum+".png"
        height:parent.height

    }

    Image {
        anchors.left:parent.right
        mirror:true
        anchors.leftMargin:-parent.height * 0.1
        source:"file:img/borders/border"+bordernum+".png"
        height:parent.height

    }



}
