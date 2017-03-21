import QtQuick 2.0
import QtQuick.Layouts 1.3

Item {
    property int bordernum:1
    property int counter: 6

    Rectangle {
        anchors.fill: parent
        color:"black"
    }

    Row {
        width:parent.width
        height:parent.height
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: parent.height * 0.1
        Repeater {
            model:counter

            Rectangle {
                anchors.verticalCenter: parent.verticalCenter
                width:parent.width / counter
                height:parent.height * 0.9
                color:"green"
            }
        }
    }

    Image {
        anchors.right:parent.left
        anchors.rightMargin:-parent.height * 1.2
        source:"file:img/borders/border"+bordernum+".png"
        height:parent.height

    }

    Image {
        anchors.left:parent.right
        mirror:true
        anchors.leftMargin:-parent.height * 1.2
        source:"file:img/borders/border"+bordernum+".png"
        height:parent.height

    }

}
