import QtQuick 2.0
Item {

    property int bordernum: 1
    property string label: ""
    property int startframe:1
    property int entered:0

    Timer {
        id:spinner
        interval: 20
        running: false
        repeat:false
        onTriggered: if (startframe != 30) {spinner.running = true, startframe = startframe + 1} else {spinner.running = false, startframe = 1}
    }

    onEnteredChanged: spinner.start()

    Image {
        source:if(startframe >= 10) {"file:img/borders/menuItem/menu"+bordernum+"00"+startframe+".png"}
                                else {"file:img/borders/menuItem/menu"+bordernum+"000"+startframe+".png"}
        height:parent.height
        anchors.right:parent.left
        fillMode: Image.PreserveAspectFit
    }

    Text {
        anchors.centerIn: parent
        text:label
        color:if(bordernum == 1) {"yellow"} else {"red"}

        font.pixelSize: parent.height * 0.4
    }

    Image {
        source:if(startframe >= 10) {"file:img/borders/menuItem/menu"+bordernum+"00"+startframe+".png"}
                                else {"file:img/borders/menuItem/menu"+bordernum+"000"+startframe+".png"}
        height:parent.height
        anchors.left:parent.right
        mirror:true
        fillMode: Image.PreserveAspectFit
    }
}
