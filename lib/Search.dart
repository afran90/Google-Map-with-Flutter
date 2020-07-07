import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'place.dart';


class Search extends StatelessWidget{
 @override
  Widget build(BuildContext context) {
    final currentposition=Provider.of<Position>(context);
     final placesProvider = Provider.of<Future<List<Place>>>(context);
    return FutureProvider(
      create: (context) => placesProvider,
          child: Scaffold(
      body: (currentposition != null)
            ? Consumer<List<Place>>(
                builder: (_, places, __) {
                  return (places != null) ? Column(
                    children: <Widget>[Container(
          height: MediaQuery.of(context).size.height/2,
          width: MediaQuery.of(context).size.width,
          child: GoogleMap(
            initialCameraPosition: CameraPosition(target: LatLng(currentposition.latitude, currentposition.longitude), zoom: 12),
            zoomControlsEnabled: true,
            
            ),
        ), 
        SizedBox(
                        height: 10.0,
                      ),
                      Expanded(
                        child: ListView.builder(
                            itemCount: places.length,
                            itemBuilder: (context, index) {
                              return Card(
                                child: ListTile(
                                  title: Text(places[index].name),
                                 ),
                              );
                            }),
                      )
                    ],
                  ):CircularProgressIndicator();
                },
              )
      :Center(child: Center(child: CircularProgressIndicator()),
      ),
      
      

      ),
    );
  }

}