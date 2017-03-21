import QtQuick 2.0
import "main.js" as Scripts

Item {
    id:window_container
    property int bordernum: 2
    property string race: if(workGrid.mode ==1) {selectedrace} else {if(selectedrace == "Aquarian") {"Gormok"} else {"Aquarian"}}
    property int islocked: 1
    property int mode: 1

    onRaceChanged: shipview.race = race,shipview.type = "seal"

    //onModeChanged: if(mode == 2) {window_container.state = "unload",fleetscreen.mode = 2,fleetscreen.state = "reload"}

    Timer {
        id:switchscreen
        interval: 2000
        running:false
        repeat:false
        onTriggered: { if(workGrid.mode == 1) { Scripts.remap(2,"true"),workGrid.mode = 2,ai_pause.running = true }
                    else {Scripts.remap(1,"true"),workGrid.mode = 1}

        }
    }

    Timer {
        id:ai_pause
        interval: 2500
        running:false
        repeat: false
        onTriggered: Scripts.ai_fired(),switchscreen.running = true
    }


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

    onStateChanged: if(window_container.state == "reload") {infoWindow.bordernum = 2,infoWindow.message ="Battle Phase:",infoWindow.state = "Show"}

    TargetingGrid {
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
        bordernum: 2
    }

    DamageCounters {
        id:damagecounters
        anchors.top:shipview.bottom
        anchors.topMargin: parent.height * 0.01
        anchors.right:shipview.right
        anchors.left:shipview.left
        height:parent.height * 0.05
        bordernum: 2

    }

    Discription {
        id:thediscription
        anchors.top:damagecounters.bottom
        anchors.topMargin: parent.height * 0.01
        anchors.right:damagecounters.right
        anchors.left:damagecounters.left
        anchors.bottom:parent.bottom
        anchors.bottomMargin: parent.height * 0.01
        bordernum: 2
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
                            source:"file:img/"+selectedrace+"/"+type+"/Info0001.png"
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
                            //onClicked: if(ships_placed[index] == null) { shipview.type = type,shipview.race = race,selectedrace = race,selectedtype = type,
                                //       currentship = index,locked.visible = true,Scripts.check_placement()}
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
         bordernum: 2

         label:if(workGrid.mode == 1) {"Fire!"} else {"Please Wait"}


         MouseArea {

             anchors.fill: parent
             hoverEnabled: true
             onEntered: Scripts.check_placement(),parent.entered = 1
             onExited: parent.entered = 0
            // onClicked: if(islocked == 0) {console.log("READY"),window_container.state = "unload"} else {false}
            // onClicked: if(workGrid.mode == 1) { Scripts.fire(),workGrid.mode = 2 }
                //        else {Scripts.remap(), workGrid.mode = 1}
               onClicked: Scripts.fire(),switchscreen.running = true
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
