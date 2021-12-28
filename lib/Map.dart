import 'dart:async';
import 'package:firstapp/DBTourism.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'DBHelper.dart';

class Map extends StatefulWidget {
  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {
  
  Completer<GoogleMapController> _controller = Completer();
  static const LatLng _center = const LatLng(36.1911613,43.9999327);
  final Set<Marker> marker = {};
  LatLng lastPosistion = _center;
  MapType mapType = MapType.normal;

  DBHelper dbHelper;


  _OnMaoCreate(GoogleMapController controller){
    _controller.complete(controller);
  }

  _OnCameraMove(CameraPosition cameraPosition){
    lastPosistion = cameraPosition.target;
    this.setState(() {
      marker.add(Marker(markerId: MarkerId(_center.toString()),
        position: _center,
        infoWindow: InfoWindow(
          title: 'this is castle',
            snippet: 'castel of center erbil'
        )
      ));
    });

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dbHelper = DBHelper.dbInstance;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[

         GoogleMap(
             onMapCreated: _OnMaoCreate,
             initialCameraPosition: CameraPosition(
               target: _center,
               zoom: 13
         ),
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          mapType: mapType,
           markers: marker,
           onCameraMove: _OnCameraMove,
         ),
          Padding(
            padding: EdgeInsets.only(right: 16 , bottom: 100),
            child: Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                onPressed: (){
                  dialog();
                },
                backgroundColor: Colors.blue,
                child: Icon(Icons.add_location),
              ),
            ),
          )
        ],
      ),
    );
  }

  bool hotels = false;
  bool restuarants = false;
  bool torisms = false;
  bool shops = false;

  void dialog(){
    Alert(
      context: context,
      title: "Select palces",
      content: StatefulBuilder(
        builder: (context , setState2) => Column(
          children: <Widget>[
             CheckboxListTile(
               title: Text("List All Hotels"),
                value: hotels,
               onChanged: (value){
                 setState2(() {
                   hotels = value;
                   print(value);
                   if(value == true){
                     hotel();
                   }
                 });

               },
              ),
            CheckboxListTile(
              title: Text("List All Restuarants"),
              value: restuarants,
              onChanged: (value){
                setState2(() {
                  restuarants = value;
                  if(value == true){
                    resturant();
                  }
                });
              },
            ),
            CheckboxListTile(
              title: Text("List All Torisms"),
              value: torisms,
              onChanged: (value){
                setState2(() {
                  torisms = value;
                  if(value == true){
                    tourism();
                  }
                });
              },
            ),
            CheckboxListTile(
              title: Text("List All Shops"),
              value: shops,
              onChanged: (value){
                setState2(() {
                 shops = value;
                 if(value == true){
                   shop();
                 }
                });
              },
            )
          ],
        ),
      ),
    ).show();

  }

  Future<void> hotel() async{
    List<DBTourism> hotels = await dbHelper.getData("Hotel");
    setState(() {
      for(int i =0 ; i < hotels.length ; i++){
        marker.add(Marker(
            markerId: MarkerId(hotels[i].name),
            position: LatLng(hotels[i].lat , hotels[i].lang),
            infoWindow: InfoWindow(
                title: hotels[i].name,
                snippet: hotels[i].address
            ),
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueAzure
            )
        ));
      }
    });
  }
  Future<void> resturant() async{
    List<DBTourism> hotels = await dbHelper.getData("Restuarant");
    setState(() {
      for(int i =0 ; i < hotels.length ; i++){
        marker.add(Marker(
            markerId: MarkerId(hotels[i].name),
            position: LatLng(hotels[i].lat , hotels[i].lang),
            infoWindow: InfoWindow(
                title: hotels[i].name,
                snippet: hotels[i].address
            ),
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueAzure
            )
        ));
      }
    });
  }
  Future<void> tourism() async{
    List<DBTourism> hotels = await dbHelper.getData("Tourism");
    setState(() {
      for(int i =0 ; i < hotels.length ; i++){
        marker.add(Marker(
            markerId: MarkerId(hotels[i].name),
            position: LatLng(hotels[i].lat , hotels[i].lang),
            infoWindow: InfoWindow(
                title: hotels[i].name,
                snippet: hotels[i].address
            ),
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueAzure
            )
        ));
      }
    });
  }
  Future<void> shop() async{
    List<DBTourism> hotels = await dbHelper.getData("Shop");
    setState(() {
      for(int i =0 ; i < hotels.length ; i++){
        marker.add(Marker(
            markerId: MarkerId(hotels[i].name),
            position: LatLng(hotels[i].lat , hotels[i].lang),
            infoWindow: InfoWindow(
                title: hotels[i].name,
                snippet: hotels[i].address
            ),
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueAzure
            )
        ));
      }
    });
  }

}
