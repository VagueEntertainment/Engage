import QtQuick 2.0

Item {

    property string race: ""
    property string type: ""
    property int bordernum:1
    property int frame: 0

    Timer {
        id:test
        interval: 1000
        onTriggered: playanimation.start()
        running:if(race != "" && type != "") {true} else {false}
        repeat: false
    }

    Timer {
        id:playanimation
        interval: 100
        onTriggered: if(frame != 75) {frame = frame + 1} else {frame = 1}
        repeat: if(race != "" && type != "") {true} else {false}
        running:false
    }

    Rectangle {
        anchors.fill: parent
        color:"black"
    }

    Image {
        anchors.fill: parent
        source:if (type=="seal") {"file:img/"+race+"/Seal.png"} else {
                    if(frame >= 10) {"file:img/"+race+"/"+type+"/Info00"+frame+".png"}
                            else {"file:img/"+race+"/"+type+"/Info000"+frame+".png"}
                    }
        fillMode: Image.PreserveAspectFit
    }

    Image {
        anchors.right:parent.left
        anchors.rightMargin:-parent.height * 0.2
        source:"file:img/borders/border"+bordernum+".png"
        height:parent.height

    }

    Image {
        anchors.left:parent.right
        mirror:true
        anchors.leftMargin:-parent.height * 0.2
        source:"file:img/borders/border"+bordernum+".png"
        height:parent.height

    }

}
