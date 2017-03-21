import QtQuick 2.0
import "main.js" as Scripts

Item {
    id:window_container
    property int bordernum: 1
    property string race: ""
    property int islocked: 1

    onRaceChanged: shipview.race = race,shipview.type = "seal"
    states: [

        State {
            name: "unload"

            PropertyChanges {
                target: workGrid
                opacity: 0
                scale:0
                //y: -workGrid.height

            }

            PropertyChanges {
                target: shipview
                opacity: 0
                scale:0
                //y: -shipview.height

            }

            PropertyChanges {
                target: thediscription
                opacity: 0
                //y:0
                scale:0

            }

            PropertyChanges {
                target: damagecounters
                opacity: 0
             //   y:0
                scale:0

            }

            PropertyChanges {
                target: shipselector
                opacity: 0
               // y:0
                scale:0

            }
            PropertyChanges {
                target: readyup
                opacity: 0
              //  y:0
                scale:0

            }


        },
        State {
            name: "reload"

            PropertyChanges {
                target: workGrid
                opacity: 1
               // y:0
                scale:1

            }
            PropertyChanges {
                target: shipview
                opacity: 1
               // y:0
                scale:1

            }

            PropertyChanges {
                target: thediscription
                opacity: 1
               // y:0
                scale:1

            }

            PropertyChanges {
                target: damagecounters
                opacity: 1
               // y:0
                scale:1

            }

            PropertyChanges {
                target: shipselector
                opacity: 1
               // y:0
                scale:1

            }

            PropertyChanges {
                target: readyup
                opacity: 1
               // y:0
                scale:1

            }
        }
    ]

    transitions: [

        Transition {
            from: "unload"
            to: "reload"
            reversible: true

            NumberAnimation {
                target: workGrid
                property: "scale"
                duration: 500
                easing.type: Easing.InOutQuad
            }

            NumberAnimation {
                target: shipview
                property: "scale"
                duration: 750
                easing.type: Easing.InOutQuad
            }

            NumberAnimation {
                target: thediscription
                property: "scale"
                duration: 850
                easing.type: Easing.InOutQuad
            }

            NumberAnimation {
                target: damagecounters
                property: "scale"
                duration: 650
                easing.type: Easing.InOutQuad
            }

            NumberAnimation {
                target: shipselector
                property: "opacity"
                duration: 650
                easing.type: Easing.InOutQuad
            }

            NumberAnimation {
                target: readyup
                property: "opacity"
                duration: 650
                easing.type: Easing.InOutQuad
            }
        }

    ]

    state:"unload"

    onStateChanged: if(window_container.state == "reload") {infoWindow.message ="Placement Phase:",infoWindow.state = "Show"}

    PlacementGrid {
      id:workGrid
        anchors.top: parent.top
        anchors.left:parent.left
        anchors.margins: parent.height * 0.01
        width:parent.width * 0.80
        height:parent.height * 0.9
        opacity: 0
    }

    ShipInfoSmall {
        id:shipview
        anchors.right:parent.right
        anchors.top: parent.top
        anchors.margins: parent.height * 0.01
        width:parent.height * 0.3
        height:parent.height * 0.3
        opacity: 0
        race:race
    }

    DamageCounters {
        id:damagecounters
        anchors.top:shipview.bottom
        anchors.topMargin: parent.height * 0.01
        anchors.right:shipview.right
        anchors.left:shipview.left
        height:parent.height * 0.05

    }

    Discription {
        id:thediscription
        anchors.top:damagecounters.bottom
        anchors.topMargin: parent.height * 0.01
        anchors.right:damagecounters.right
        anchors.left:damagecounters.left
        anchors.bottom:parent.bottom
        anchors.bottomMargin: parent.height * 0.01
    }

     ListView {
         id:shipselector
        anchors.top:workGrid.bottom
        anchors.bottom:parent.bottom
        anchors.margins: parent.height * 0.01
        anchors.left:workGrid.left
        width:workGrid.width * 0.90
        orientation:Qt.Horizontal
        spacing:parent.height * 0.03

        model: ships

        delegate: Item {
                        width:shipselector.height
                        height:shipselector.height

                    Item {
                        anchors.centerIn: parent
                        width:parent.height * 0.90
                        height:parent.height * 0.90


                        Image {
                            source:"file:img/"+race+"/"+type+"/Info0001.png"
                            anchors.fill: parent
                            fillMode: Image.PreserveAspectFit
                        }

                        Image {
                            id:locked
                            visible: false
                            source:"file:img/"+race+"/Seal.png"
                            anchors.fill: parent
                            fillMode: Image.PreserveAspectFit
                        }

                        Image {
                            source:"file:img/borders/border"+bordernum+".png"
                            height:parent.height
                            anchors.right:parent.left
                            fillMode: Image.PreserveAspectFit
                        }

                        Image {
                            source:"file:img/borders/border"+bordernum+".png"
                            height:parent.height
                            anchors.left:parent.right
                            mirror:true
                            fillMode: Image.PreserveAspectFit
                        }



                        MouseArea {
                            anchors.fill:parent
                            hoverEnabled: true

                            onEntered: parent.width = shipselector.height,parent.height = shipselector.height
                            onExited: parent.width = shipselector.height * 0.9, parent.height = shipselector.height * 0.9
                            onClicked: if(ships_placed[index] == null) { shipview.type = type,shipview.race = race,selectedrace = race,selectedtype = type,
                                       currentship = index,locked.visible = true,Scripts.check_placement()}
                        }

                    }

        }

    }

     EnButton {
         id:readyup
         anchors.top:workGrid.bottom
         anchors.right:workGrid.right
         anchors.margins: parent.height * 0.01
         width:shipselector.width * 0.2
         height:shipselector.height

         label:"Ready"


         MouseArea {

             anchors.fill: parent
             hoverEnabled: true
             onEntered: Scripts.check_placement(),parent.entered = 1
             onExited: parent.entered = 0
             onClicked: if(islocked == 0) {Scripts.ai_create_spread(),window_container.state = "unload",battlescreen.state = "reload"} else {false}
         }

     }

     ListModel {
         id:ships

         ListElement {
             type:"Destroyer1"


         }

         ListElement {
             type:"Destroyer2"


         }

         ListElement {
             type:"Support"


         }
         ListElement {
             type:"Carrier"


         }
         ListElement {
             type:"Scout1"


         }
         ListElement {
             type:"Scout2"


         }
     }

}
