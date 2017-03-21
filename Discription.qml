import QtQuick 2.0

Item {

    property int bordernum: 1
    property string combat:if(theplacement.state == "reload") {"yellow"} else {"red"}

    /*property int destroyer1_power: 0
    property int destroyer2_power: 0
    property int carrier_power: 0
    property int support_power: 0
    property int scout1_power: 0
    property int scout2_power: 0 */


    Rectangle {
        anchors.fill: parent
        color:"black"
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

    Column {
        width:parent.width * 0.80
        height:parent.height * 0.90
        anchors.centerIn: parent
        spacing: parent.height * 0.02

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            text:"Your Fleet"
            font.pixelSize: parent.height * 0.05
            color:combat
        }

        Rectangle {
            width:parent.width
            height:parent.height * 0.03
            color:combat
        }

        Item {
            width:parent.width
            height:parent.height / 8


            Text {
                color:combat
                text:"Destroyer 1"
            }
            Text {
                color:combat
                text:destroyer1_power + "/3"
                anchors.bottom:parent.bottom
            }
        }
        Item {
            width:parent.width
            height:parent.height / 8
            Text {
                color:combat
                text:"Destroyer 2"
            }
            Text {
                color:combat
                text:destroyer2_power + "/3"
                anchors.bottom:parent.bottom
            }
        }
        Item {
            width:parent.width
            height:parent.height / 8
            Text {
                color:combat
                text:"Support"
            }
            Text {
                color:combat
                text:support_power + "/5"
                anchors.bottom:parent.bottom
            }
        }
        Item {
            width:parent.width
            height:parent.height / 8
            Text {
                color:combat
                text:"Carrier"
            }
            Text {
                color:combat
                text:carrier_power + "/6"
                anchors.bottom:parent.bottom
            }
        }
        Item {
            width:parent.width
            height:parent.height / 8
            Text {
                color:combat
                text:"Scout 1"
            }
            Text {
                color:combat
                text:scout1_power + "/1"
                anchors.bottom:parent.bottom
            }
        }
        Item {
            width:parent.width
            height:parent.height / 8
            Text {
                color:combat
                text:"Scout 2"
            }
            Text {
                color:combat
                text:scout2_power + "/1"
                anchors.bottom:parent.bottom
            }
        }

    }

}
