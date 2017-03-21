import QtQuick 2.0

Item {
    id:window_container
    property string splash: "file:img/splash.png"
    property int bordernum: 1
    states: [

        State {
            name:"Show"

            PropertyChanges {
                target: info
               // opacity: 1
                scale:1
                x:0
            }
        },

        State {
            name:"Hide"

                PropertyChanges {
                    target:info
                    //opacity:0
                    scale: 0
                    x:parent.height
                }
        },

        State {
            name:"Gone"

                PropertyChanges {
                    target:window_container
                    scale:0
                    opacity:0
                }

        }

    ]

    transitions: [

        Transition {
            from: "Show"
            to: "Hide"


            NumberAnimation {
                target: info
                property: "scale"
                duration: 800
                easing.type: Easing.InOutQuad
            }
        }

    ]

    onStateChanged: if(window_container.state =="Show") {fadeout.running = true}

    Timer {
        id:fadeout
        running:false
        repeat:false
        interval: 1000
        onTriggered:window_container.state = "Hide",getout.running = true
    }

    Timer {
        id:getout
        running:false
        repeat:false
        interval: 700
        onTriggered:window_container.state = "Gone"
    }

    Rectangle {
        anchors.fill: parent
        color:"black"
    }


    Image {
        id:info
        //anchors.fill: parent
        anchors.centerIn: parent
       width:parent.width * 0.5
        height:parent.height * 0.5
        fillMode:Image.PreserveAspectFit
        source:splash

        Image {
            anchors.left:parent.right
            source:"file:img/borders/border"+bordernum+".png"
            mirror:true
        }
        Image {
            anchors.right:parent.left
            source:"file:img/borders/border"+bordernum+".png"
        }
    }

}
