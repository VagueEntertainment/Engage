import QtQuick 2.0
import "main.js" as Scripts
import QtGraphicalEffects 1.0

Item {
    id:maptile
    property int num: 0
    property int row: 0
    property int column: 0
    property double baseopacity: 0.2
    property int mode: 0
    property bool visibleat: switch(mode) {
                            case 2: if(locations[num] == null || locations[num].split("::")[1] != "0") {false} else {true};break;
                            case 1: if(enemy_locations[num] == null || enemy_locations[num].split("::")[1] != "0") {false} else {true};break;
                            case 0: if(locations[num] == null || locations[num].split("::")[1] != "0") {false} else {true};break;
                             }

    property int targetnum: 1
    property int tnum: 0
    property int snum:0
    property int targeted: 0
    property int missed: 0
    property int hitted: 0

    property string therace: switch(mode) {
                             case 2: selectedrace;break;
                             case 1: if(selectedrace == "Aquarian") {"Gormok"} else {"Aquarian"};break;
                             case 0: selectedrace;break;
                             }

    Component.onCompleted: onload.start()

    onTargetedChanged: if(targeted == 1) {redicule.state = "active"} else {redicule.state = "idle"}
    onMissedChanged: if(missed == 1) {miss.state = "active"} else {miss.state = "idle"}
    onHittedChanged: if(hitted == 1) {hit.state = "active"} else {hit.state = "idle"}

    Timer {
        id:onload
        interval: 100+(num * 10)
        running:false
        repeat:false
        onTriggered:maptile.state = "loaded"
    }

    states: [

        State {
            name:"loaded"

            PropertyChanges {
                target:base
                opacity: baseopacity
                //scale:1
            }
    },
        State {
            name:"preload"

            PropertyChanges {
                target: base
                opacity: 0
                //scale: 2

            }
        }
    ]

    transitions: [

        Transition {
            from: "preload"
            to: "loaded"

            NumberAnimation {
                target: base
                properties: "opacity"
                duration: 400
                easing.type: Easing.InOutQuad
            }
        }


    ]

    state:"preload"

    Rectangle {
        id:base
        anchors.centerIn: parent
        width:parent.width * 0.98
        height:parent.height * 0.98
        color:"#020202020"
        opacity: baseopacity
        border.color: "white"
        border.width: 2
        //z:-10
    }

    Image {
          id:ship

          property var inspot: switch(mode) {
                               case 1: if(enemy_locations[num] == null) {selectedtype}
                                        else { if (enemy_locations[num].split("::")[1] == "0") {enemy_locations[num].split("::")[0]}};break;
                               case 2: if(locations[num] == null) {selectedtype}
                                        else { if (locations[num].split("::")[1] == "0") { locations[num].split("::")[0]}};break;
                               case 0: if(locations[num] == null) {selectedtype}
                                        else { if (locations[num].split("::")[1] == "0") { locations[num].split("::")[0]}};break;
                               }
          anchors.horizontalCenter: parent.horizontalCenter
          anchors.verticalCenter: parent.verticalCenter
          anchors.horizontalCenterOffset:switch(inspot) {
                                                    case "Carrier":parent.width * 0.5;break;

                                                    default:0;break
                                                 }




          width: switch (inspot) {
                case "Destroyer1":
                    switch(therace) {
                        case "Gormok": parent.width*1.5;break;
                        case "Aquarian":parent.width;break;
                    }break;
                case "Destroyer2":
                     switch(therace) {
                         case "Gormok": parent.width*1.5;break;
                         case "Aquarian":parent.width;break;
                    }break;
                case "Support":
                     switch(therace) {
                        case "Gormok": parent.width*3;break;
                        case "Aquarian":parent.width*3;break;
                    }break;
                case "Carrier":
                     switch(therace) {
                        case "Gormok": parent.width*2.4;break;
                        case "Aquarian":parent.width*1.8;break;
                    }break;

                default:parent.width;break;
                 }

          fillMode:Image.PreserveAspectFit
          source:switch(mode) {
                 case 1: if(enemy_locations[num] == null) {"file:img/"+therace+"/"+selectedtype+"/0Damage0001.png"}
                    else {"file:img/"+therace+"/"+enemy_locations[num].split("::")[0]+"/0Damage0001.png"};break;
                 case 2: if(locations[num] == null) {"file:img/"+therace+"/"+selectedtype+"/0Damage0001.png"}
                    else {"file:img/"+therace+"/"+locations[num].split("::")[0]+"/0Damage0001.png"};break;
                 case 0: if(locations[num] == null) {"file:img/"+therace+"/"+selectedtype+"/0Damage0001.png"}
                    else {"file:img/"+therace+"/"+locations[num].split("::")[0]+"/0Damage0001.png"};break;

                 }
          visible: switch(mode)  {
                      case 0:visibleat;break;
                      case 1: false;break;
                      case 2: visibleat;break;

                   }


         /* Timer {
              running:true
              //repeat: if(tnum < 74) {true} else {false}
              repeat:true
              interval: 50
              onTriggered: { if(snum < 75) {snum = snum + 1;} else {snum = 1}
                  if(snum < 10) {switch(mode) {
                      case 1: if(enemy_locations[num] == null) {ship.source = "file:img/"+therace+"/"+selectedtype+"/0Damage000"+snum+".png"}
                         else {ship.source = "file:img/"+therace+"/"+enemy_locations[num].split("::")[0]+"/0Damage000"+snum+".png"};break;
                      case 2: if(locations[num] == null) {ship.source = "file:img/"+therace+"/"+selectedtype+"/0Damage000"+snum+".png"}
                         else {ship.source = "file:img/"+therace+"/"+locations[num].split("::")[0]+"/0Damage000"+snum+".png"};break;
                      case 0: if(locations[num] == null) {ship.source = "file:img/"+therace+"/"+selectedtype+"/0Damage000"+snum+".png"}
                         else {ship.source = "file:img/"+therace+"/"+locations[num].split("::")[0]+"/0Damage000"+snum+".png"};break;

                      }}
                              else { switch(mode) {
                      case 1: if(enemy_locations[num] == null) {ship.source ="file:img/"+therace+"/"+selectedtype+"/0Damage00"+snum+".png"}
                         else {ship.source ="file:img/"+therace+"/"+enemy_locations[num].split("::")[0]+"/0Damage00"+snum+".png"};break;
                      case 2: if(locations[num] == null) {ship.source ="file:img/"+therace+"/"+selectedtype+"/0Damage00"+snum+".png"}
                         else {ship.source ="file:img/"+therace+"/"+locations[num].split("::")[0]+"/0Damage00"+snum+".png"};break;
                      case 0: if(locations[num] == null) {ship.source ="file:img/"+therace+"/"+selectedtype+"/0Damage00"+snum+".png"}
                         else {ship.source ="file:img/"+therace+"/"+locations[num].split("::")[0]+"/0Damage00"+snum+".png"};break;}

              }
          } } */



         //z:-1

    }

    Image {
        id:redicule

        source:"file:img/Grid/Target"+targetnum+"0001.png"
        anchors.centerIn: parent
        //visible:false
        width:parent.width * 2
        z:6
        fillMode: Image.PreserveAspectFit

        states: [
            State {
                name:"idle"
                PropertyChanges {
                    target: redicule
                    width:parent.width * 2
                    opacity:0

                }
            },
            State {
                name:"active"

                PropertyChanges {
                    target: redicule
                    width:parent.width
                    opacity:1

                }
            }

        ]

        transitions: [
            Transition {
                from: "idle"
                to: "active"


                NumberAnimation {
                    target: redicule
                    properties:"opacity,width"
                    duration: 400
                    easing.type: Easing.InOutQuad
                }



            }

        ]

        state:"idle"

        Timer {
            running:if(redicule.state == "active") {true} else {false}
            //repeat: if(tnum < 74) {true} else {false}
            repeat:true
            interval: 20
            onTriggered: { if(tnum < 75) {tnum = tnum + 1;} else {tnum = 1}
                if(tnum < 10) {redicule.source = "file:img/Grid/Target"+targetnum+"000"+tnum+".png"}
                            else { redicule.source = "file:img/Grid/Target"+targetnum+"00"+tnum+".png"}

            }
        }
    }

    Image {
        id:hit

        source:"file:img/Grid/Hit"+targetnum+"0001.png"
        anchors.centerIn: parent
        //visible:false
        width:parent.width * 2
        z:50
        fillMode: Image.PreserveAspectFit

        states: [
            State {
                name:"idle"
                PropertyChanges {
                    target: hit
                    width:parent.width * 2
                    opacity:0

                }
            },
            State {
                name:"active"

                PropertyChanges {
                    target: hit
                    width:parent.width
                    opacity:1

                }
            }

        ]

        transitions: [
            Transition {
                from: "idle"
                to: "active"


                NumberAnimation {
                    target: hit
                    properties:"opacity,width"
                    duration: 400
                    easing.type: Easing.InOutQuad
                }



            }

        ]

        state:"idle"

        Timer {
            running:if(hit.state == "active") {true} else {false}
            //repeat: if(tnum < 74) {true} else {false}
            repeat:if(tnum == 75) {false} else{true}
            interval: 10
            onTriggered: { if(tnum < 75) {tnum = tnum + 1;} else {tnum = 1}
                if(tnum < 10) {hit.source = "file:img/Grid/Hit"+targetnum+"000"+tnum+".png"}
                            else { hit.source = "file:img/Grid/Hit"+targetnum+"00"+tnum+".png"}

            }
        }
    }


    Image {
        id:miss

        source:"file:img/Grid/Miss"+targetnum+"0001.png"
        anchors.centerIn: parent
        //visible:false
        width:parent.width * 2
        fillMode: Image.PreserveAspectFit

        states: [
            State {
                name:"idle"
                PropertyChanges {
                    target: miss
                    width:parent.width * 2
                    opacity:0

                }
            },
            State {
                name:"active"

                PropertyChanges {
                    target: miss
                    width:parent.width
                    opacity:1

                }
            }

        ]

        transitions: [
            Transition {
                from: "idle"
                to: "active"


                NumberAnimation {
                    target: miss
                    properties:"opacity,width"
                    duration: 400
                    easing.type: Easing.InOutQuad
                }



            }

        ]

        state:"idle"

        Timer {
            running:if(miss.state == "active") {true} else {false}
            //repeat: if(tnum < 74) {true} else {false}
            repeat:true
            interval: 20
            onTriggered: { if(tnum < 75) {tnum = tnum + 1;} else {tnum = 1}
                if(tnum < 10) {miss.source = "file:img/Grid/Miss"+targetnum+"000"+tnum+".png"}
                            else { miss.source = "file:img/Grid/Miss"+targetnum+"00"+tnum+".png"}

            }
        }
    }



    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onEntered: if(mode == 0) {if(ships_placed[currentship] == null) {Scripts.highlight(selectedtype,num,0)} }
                   else {base.opacity = 0.8}
        onExited: if(mode == 0) {if(locations[num] == null) {Scripts.clear_highlight(selectedtype,num,0)} }
                  else {base.opacity = 0.2}
        onClicked: switch(mode) {
                   case 0:Scripts.lockin(selectedtype,num,0);break;
                   case 1: Scripts.targeting(num);break;
                   case 2: console.log("Not enabled yet");break;
                   }
    }

}
