var component;
var tilenum = 0;




function mapgrid() {

   var tilenum = 0;

     //tiles = new Array(maxIndex);

   //Initialize Board

    if(gridcreated == 0) {
   for (var column = 0; column < maxColumn; column++) {
      for (var row = 0; row < maxRow; row++) {

           createBlock(column, row, tilenum,gridarea,"base");
            tilenum= tilenum +1;
       }
   }
   gridcreated = 1;
    }


}


function createBlock(column,row, num,area,type) {

    if (component == null)
       component = Qt.createComponent("./Tile.qml");


    if (component.status == Component.Ready) {
        var dynamicObject = component.createObject(area);
        if (dynamicObject == null) {
            console.log("error creating block");
            console.log(component.errorString());
            return false;
        }
        //var blockSizex = area.width /50.7;
       // var blockSizey = area.width /50.7;
        var blockSizex = area.height / maxRow;
         var blockSizey = area.height / maxRow;


        dynamicObject.x =(column * blockSizex);
        dynamicObject.y =(row * blockSizey);

        dynamicObject.width = blockSizex * 1.0;
        dynamicObject.height = blockSizey *1.0;

        dynamicObject.num = num;
        dynamicObject.row = row;
        dynamicObject.column = column;
        //dynamicObject.cw_tile = 0;
       // dynamicObject.cf_tile = 0;
       // dynamicObject.base_tile = 0;

       tiles[num] = dynamicObject;

    } else {
        console.log("error loading block component");
        console.log(component.errorString());
        return false;
    }

    return true;
}

function highlight (ship,center,rotation) {
  //  console.log(locations[center]);



    if(locations[center] == null) {
        visibleat = true;
        tiles[center].z = 5;
    switch(ship) {
    case "Destroyer1": tiles[center].baseopacity = 0.8;tiles[center-1].baseopacity = 0.8;tiles[center+1].baseopacity = 0.8;break;
    case "Destroyer2": tiles[center].baseopacity = 0.8;tiles[center-1].baseopacity = 0.8;tiles[center+1].baseopacity = 0.8;break;
    case "Support": tiles[center+maxRow].baseopacity = 0.8;tiles[center].baseopacity = 0.8;tiles[center-1].baseopacity = 0.8;
                    tiles[center+1].baseopacity = 0.8;tiles[center-maxRow].baseopacity = 0.8;break;
    case "Scout1": tiles[center].baseopacity = 0.8;break;
     case "Scout2": tiles[center].baseopacity = 0.8;break;
    case "Carrier": tiles[center].baseopacity = 0.8;tiles[center-1].baseopacity = 0.8;tiles[center+1].baseopacity = 0.8;
                    tiles[center+maxRow-1].baseopacity = 0.8;tiles[center+maxRow].baseopacity = 0.8;tiles[center+maxRow+1].baseopacity = 0.8;break;
    }

    }
}

function clear_highlight (ship,center,rotation) {

    if(locations[center] == null) {
         visibleat = false;
        tiles[center].z = 0;
    switch(ship) {
    case "Destroyer1": tiles[center].baseopacity = 0.2;tiles[center-1].baseopacity = 0.2;tiles[center+1].baseopacity = 0.2;break;
    case "Destroyer2": tiles[center].baseopacity = 0.2;tiles[center-1].baseopacity = 0.2;tiles[center+1].baseopacity = 0.2;break;
    case "Support": tiles[center+maxRow].baseopacity = 0.2;tiles[center].baseopacity = 0.2;tiles[center-1].baseopacity = 0.2;
                    tiles[center+1].baseopacity = 0.2;tiles[center-maxRow].baseopacity = 0.2;break;
    case "Scout1": tiles[center].baseopacity = 0.2;break;
    case "Scout2": tiles[center].baseopacity = 0.2;break;
    case "Carrier": tiles[center].baseopacity = 0.2;tiles[center-1].baseopacity = 0.2;tiles[center+1].baseopacity = 0.2;
        tiles[center+maxRow+1].baseopacity = 0.2;tiles[center+maxRow].baseopacity = 0.2;tiles[center+maxRow-1].baseopacity = 0.2;break;
    }
    }
}


function lockin (ship,center,rotation) {

   // visibleat = true;
    //tiles[center].z = 2;
    ships_placed[currentship]= ship;

    //console.log(ships_placed[currentship]);
    switch(ship) {
    case "Destroyer1": locations[center]=ship+"::"+"0::"+rotation;
                        locations[center-1]=ship+"::"+"1::"+rotation;
                        locations[center+1]=ship+"::"+"2::"+rotation;
                            break;
    case "Destroyer2": locations[center]=ship+"::"+"0::"+rotation;
                        locations[center-1]=ship+"::"+"1::"+rotation;
                        locations[center+1]=ship+"::"+"2::"+rotation;
                            break;
    case "Support": locations[center]=ship+"::"+"0::"+rotation;
                    locations[center-1]=ship+"::"+"1::"+rotation;
                    locations[center+1]=ship+"::"+"2::"+rotation;
                    locations[center-maxRow]=ship+"::"+"3::"+rotation;
                    locations[center+maxRow]=ship+"::"+"4::"+rotation;

            break;
    case "Scout1": locations[center]=ship+"::"+"0::"+rotation;break;
    case "Scout2": locations[center]=ship+"::"+"0::"+rotation;break;
    case "Carrier": locations[center]=ship+"::"+"0::"+rotation;
                    locations[center-1]=ship+"::"+"1::"+rotation;
                    locations[center+1]=ship+"::"+"2::"+rotation;
                    locations[center+maxRow]=ship+"::"+"3::"+rotation;
                    locations[center+maxRow-1]=ship+"::"+"4::"+rotation;
                    locations[center+maxRow+1]=ship+"::"+"5::"+rotation;

        break;
    }

   // check_fleet(2);

    //selectedrace = "";
    //selectedtype = "";

   // console.log(locations[center]);
}

function check_placement() {
    for(var num =0;num < 6;num = num +1) {
    //console.log(ships_placed[num])
        if(ships_placed[num] == null) {
            islocked = 1;
            break;
        } else {
          islocked = 0;
        }
    }
}

function mode_change(mode) {
    var num = 0;
    while(num < maxIndex) {
        tiles[num].mode = mode;
        //tiles[num].z = -1;
        num = num + 1;
    }
}

function targeting(target) {
        var num = 0;
    tiles[target].targeted = 1;

    while(num < maxIndex) {
        if(num !=target ) {
        tiles[num].targeted = 0;
        }
        num = num + 1;
    }
}

function fire() {

    var num = 0;

    while(num < maxIndex) {
        if(tiles[num].targeted == 1 ) {
                firedon[num] = 1;
            tiles[num].targeted = 0;
        }
            num = num + 1;
        }
    remap(1,"false");
    check_fleet(2);
}

function remap(mode,reload) {
        var num = 0;
    //tiles[target].targeted = 1;
    if(reload == "true") {
    for(var renum = 0;renum < maxIndex;renum = renum + 1) {
        tiles[renum].missed = 0;
        tiles[renum].hitted = 0;
    } }

    while(num < maxIndex) {
        //if(num !=target ) {
        if(mode == 1) {
            if (firedon[num] == 1) {
                if(enemy_locations[num] == null) {
                    tiles[num].missed = 1;
                } else {tiles[num].hitted = 1;}

            }
        } else {
            if (enemy_firedon[num] == 1) {
                if(locations[num] == null) {
                    tiles[num].missed = 1;
                } else {tiles[num].hitted = 1;}

            }
        }

        num = num + 1;
    }
}

function ai_create_spread() {

    var units = ["Destroyer1","Destroyer2","Scout1","Scout2","Carrier","Support"];
    var rotation = 0;
    var center = 0;

    for(var num =0;num < units.length;num = num +1) {
        switch(units[num]) {
          case "Destroyer1": center = Math.floor(Math.random() * (maxIndex-3));break;
          case "Destroyer2": center = Math.floor(Math.random() * (maxIndex-3));break;
          case "Support":center = Math.floor(Math.random() * (maxIndex-18));break;
          case "Scout1": center = Math.floor(Math.random() * (maxIndex));break;
          case "Scout2": center = Math.floor(Math.random() * (maxIndex));break;
          case "Carrier":center = Math.floor(Math.random() * (maxIndex-12));break;
            }

            //console.log("Placing "+units[num]+" at "+center);
        switch(units[num]) {
        case "Destroyer1": enemy_locations[center]=units[num]+"::"+"0::"+rotation;
                            enemy_locations[center-1]=units[num]+"::"+"1::"+rotation;
                            enemy_locations[center+1]=units[num]+"::"+"2::"+rotation;
                                break;
        case "Destroyer2": enemy_locations[center]=units[num]+"::"+"0::"+rotation;
                            enemy_locations[center-1]=units[num]+"::"+"1::"+rotation;
                            enemy_locations[center+1]=units[num]+"::"+"2::"+rotation;
                                break;
        case "Support": enemy_locations[center]=units[num]+"::"+"0::"+rotation;
                        enemy_locations[center-1]=units[num]+"::"+"1::"+rotation;
                        enemy_locations[center+1]=units[num]+"::"+"2::"+rotation;
                        enemy_locations[center-maxRow]=units[num]+"::"+"3::"+rotation;
                        enemy_locations[center+maxRow]=units[num]+"::"+"4::"+rotation;

                break;
        case "Scout1": enemy_locations[center]=units[num]+"::"+"0::"+rotation;break;
        case "Scout2": enemy_locations[center]=units[num]+"::"+"0::"+rotation;break;
        case "Carrier": enemy_locations[center]=units[num]+"::"+"0::"+rotation;
                        enemy_locations[center-1]=units[num]+"::"+"1::"+rotation;
                        enemy_locations[center+1]=units[num]+"::"+"2::"+rotation;
                        enemy_locations[center+maxRow]=units[num]+"::"+"3::"+rotation;
                        enemy_locations[center+maxRow-1]=units[num]+"::"+"4::"+rotation;
                        enemy_locations[center+maxRow+1]=units[num]+"::"+"5::"+rotation;

            break;
        }

    }
}

function ai_fired() {

    var num = 0;

    targeting(Math.floor(Math.random() * maxIndex));

    while(num < maxIndex) {
        if(tiles[num].targeted == 1 ) {
                enemy_firedon[num] = 1;
            tiles[num].targeted = 0;
        }
            num = num + 1;
        }
    remap(2,"false");

    check_fleet(1);

}

function check_fleet(mode) {

    if(mode == 1) {
        var fnum = 0;
        var totalpower = 0;
        var powerleft = 0;
        var damagetaken =0;
        while(fnum < maxIndex) {

            if( enemy_locations[fnum] != null ) {
                totalpower = totalpower +1;
                if(firedon[fnum] != null) {
                    damagetaken = damagetaken + 1;
                }
            }

            fnum = fnum + 1;
        }
        powerleft = totalpower - damagetaken

       // console.log("Enemy fleet has "+powerleft+" power left");

        if (powerleft == 0) {infoWindow.endinfo = 1;infoWindow.message ="The Winner is You";infoWindow.state = "Show";}
    }

    if (mode == 2) {

        var fnum1 = 0;
        var totalpower1 = 0;
        var powerleft1 = 0;
        var damagetaken1 =0;
        var s1damage = 0;
        var s2damage = 0;
        var supdamage = 0;
        var cardamage = 0;
        var dest1damage = 0;
        var dest2damage = 0;
        while(fnum1 < maxIndex) {

            if( locations[fnum1] != null ) {

                totalpower1 = totalpower1 +1;
                if(enemy_firedon[fnum1] != null) {
                    damagetaken1 = damagetaken1 + 1;

                }
            }

            fnum1 = fnum1 + 1;
        }
        powerleft1 = totalpower1 - damagetaken1;

        for(var fnum2 = 0;fnum2< maxIndex;fnum2 = fnum2+1) {
             if(locations[fnum2] != null ) {
                 if(enemy_firedon[fnum2] != null) {
                     //console.log(locations[fnum1].split("::")[0]);

                         switch (locations[fnum2].split("::")[0]) {
                            case "Destroyer1": dest1damage = dest1damage + 1;break;
                             case "Destroyer2": dest2damage = dest2damage + 1;break;
                             case "Scout1": s1damage = s1damage + 1;break;
                             case "Scout2": s2damage = s2damage + 1;break;
                             case "Carrier": cardamage = cardamage + 1;break;
                             case "Support": supdamage = supdamage + 1;break;
                           }

                      }
                }
        }
        destroyer1_power= dest1damage;
        destroyer2_power= dest2damage;
        carrier_power= cardamage;
        support_power= supdamage;
        scout1_power= s1damage;
        scout2_power= s2damage;

      //  console.log("Your fleet has "+powerleft1+" power left");

        if (powerleft1 == 0) {infoWindow.endinfo = 1;infoWindow.message ="The Winner is Them";infoWindow.state = "Show";}

    }
}
