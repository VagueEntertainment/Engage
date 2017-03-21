import QtQuick 2.0



Item {
    id:window_container

    property string title: "file:img/title.png"

    Image {
        id:thetitle
        anchors.horizontalCenter: parent.horizontalCenter
        source:title
        height: parent.height * 0.4
        fillMode:Image.PreserveAspectFit
    }

    ListView {
        clip:true
        anchors.top:thetitle.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        width:thetitle.width
        height:parent.height * 0.7
        spacing:parent.height * 0.05
        model: ListModel {
            ListElement {
                thelabel:"Single Player"
            }
            ListElement {
                thelabel:"Multi Player"
            }
        }

        delegate: EnButton {
            anchors.horizontalCenter: parent.horizontalCenter
            width:thetitle.width * 0.8
            height:thetitle.height * 0.4
            label:thelabel

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onEntered: parent.entered = 1
                onExited: parent.entered = 0
                onClicked: fleets.visible = true,window_container.visible = false
            }

        }

    }


}
