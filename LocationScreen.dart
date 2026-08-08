import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';



class LocationScreen extends StatefulWidget {
  const LocationScreen({key}) : super(key: key);

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class UserLocation{

  double lat;
  double long;

  UserLocation(this.lat, this.long);
}

class _LocationScreenState extends State<LocationScreen> {

  Set<Marker> _markers = {};

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Select Location',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        body: Column(
          children: [
            Stack(
              children: [

                Container(
                    height: 600,
                    child: GoogleMap(
                        myLocationEnabled :true,
                        onMapCreated: onMapCreated,
                        markers: _markers,
                        initialCameraPosition: CameraPosition(target:LatLng(9.0079,38.7678),
                            zoom:15,
                        ))),
                Container(
                    margin: EdgeInsets.fromLTRB(15,55,0,0),
                    child: IconButton(icon:Icon(Icons.arrow_back), iconSize: 35, onPressed:(){
                      Navigator.pop(context);
                    } ,)),

              ],
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  TextFormField(
                    initialValue: "9.0079" ,
                    decoration: const InputDecoration(
                        labelText: 'Latitude'
                    ),
                  ),

                  TextFormField(
                    initialValue: "38.7678",
                    decoration: const InputDecoration(
                        labelText: 'Longitude'
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.only(top:5),
                    child: RaisedButton(
                      color: Color.fromRGBO(75, 132, 241,1),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14)),
                      onPressed:(){
                        Navigator.pop(context);
                      },
                      child: Text("Save", style:TextStyle(color:Colors.white),)
                    ),
                  )



                ],
              ),
            ),








      /*Container(

                 height: double.infinity,
                 width: double.infinity,
                 decoration: BoxDecoration(
                     color: Colors.black,
                     borderRadius: BorderRadius.all(Radius.circular(20))
                 ),
                ),*/

          ],
        ),
      ),
    );
    
  }

  void onMapCreated(GoogleMapController controller) {
    setState((){
      _markers.add(
      Marker(markerId: MarkerId('id-1'), position: LatLng(9.0079,38.7678)));
    });

  }
}
