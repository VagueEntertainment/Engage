import QtQuick 2.0

Item {
     width:parent.width
     height:parent.height
     property int starframe: 1


     Timer {
         id:test
         interval: 1000
         onTriggered: zoomin.start()
         running:true
         repeat: false
     }

     Timer {
         id:zoomin
         interval: 45
         onTriggered: if(starframe != 45) {starframe = starframe + 1} else {zoomin.stop()}
         repeat: true
         running:false
     }

     Rectangle {
         anchors.fill: parent
         color:"black"
     }

     Image {
         anchors.fill: parent
         source:if(starframe >= 10) {"file:img/backgrounds/star1/00"+starframe+".png"} else {"file:img/backgrounds/star1/000"+starframe+".png"}
         opacity: 0.7
         //fillMode: Image.TileHorizontally
     }



}
