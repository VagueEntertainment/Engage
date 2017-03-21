import QtQuick 2.0

Item {

    id:window_container

    property int bordernum: 1
    property int startframe: 1


    ListView {
        id:teamselector
       anchors.centerIn: parent
       width:parent.width * 0.8
       height:parent.height * 0.9
       orientation:Qt.Horizontal
       spacing:parent.height * 0.03

       model: ListModel {
           id:fleet

           ListElement {
               name:"Aquarian"
           }

           ListElement {
               name:"Gormok"
           }
       }

       delegate: Item {
                width:teamselector.width / 2
                height:teamselector.height

                Item {
                    id:fleetselect
                    transformOrigin: Item.Top
                    width:parent.width * 0.8
                    height:parent.height * 0.8
                    Rectangle {
                        anchors.centerIn: parent
                        width:parent.width
                        height:parent.height * 0.98
                        color:"#40404030"
                    }

                    Image {
                        anchors.top:parent.top
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.topMargin: parent.height * 0.05
                        source:"file:img/"+name+"/Seal.png"
                        width:parent.width * 0.94
                        height:parent.width * 0.94
                        fillMode: Image.PreserveAspectFit
                    }


                    Image {
                        source:"file:img/borders/border"+startframe+".png"

                        height:parent.height
                        anchors.right:parent.left
                        anchors.rightMargin: -parent.height * 0.08
                        //fillMode: Image.PreserveAspectFit
                    }

                    Text {
                        //anchors.centerIn: parent
                        anchors.bottom:parent.bottom
                        anchors.bottomMargin: parent.height * 0.05
                        anchors.horizontalCenter: parent.horizontalCenter
                        text:name
                        color:"yellow"
                        font.pixelSize: parent.height * 0.1
                    }

                    Image {
                        source: "file:img/borders/border"+startframe+".png"
                        height:parent.height
                        anchors.left:parent.right
                        mirror:true
                        anchors.leftMargin: -parent.height * 0.08
                        //fillMode: Image.PreserveAspectFit
                    }


                }
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: theplacement.race = name,theplacement.state = "reload",window_container.visible = false
                    //onEntered: fleetselect.height = parent.height * 0.9,fleetselect.width = parent.width * 0.9
                   // onExited: fleetselect.height = parent.height * 0.8,fleetselect.width = parent.width * 0.8
                }

       }

    }


    Item {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom:parent.bottom
        anchors.bottomMargin: parent.height * 0.01
        width:parent.width * 0.2
        height:parent.height * 0.1


        Text {
            anchors.centerIn: parent
            text:"Main Menu"
            color:"yellow"
            font.pixelSize: parent.height * 0.5
        }

        Image {
            source: "file:img/borders/border"+startframe+".png"
            height:parent.height
            anchors.left:parent.right
            mirror:true
            anchors.leftMargin: -parent.height * 0.08
            fillMode: Image.PreserveAspectFit
        }

        Image {
            source:"file:img/borders/border"+startframe+".png"

            height:parent.height
            anchors.right:parent.left
            anchors.rightMargin: -parent.height * 0.08
            fillMode: Image.PreserveAspectFit
        }

        MouseArea {
            anchors.fill: parent
            onClicked:window_container.visible = false,mainmenu.visible = true
        }

    }

}
