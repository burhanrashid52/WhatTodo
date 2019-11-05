import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app/bloc/bloc_provider.dart';
import 'package:flutter_app/pages/map/map_bloc.dart';
import 'package:flutter_app/pages/places/models.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatelessWidget {
  final Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    final MapBloc mapBloc = BlocProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Maps"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.satellite),
            onPressed: () => mapBloc.setMayType(MapType.satellite),
          ),
          IconButton(
            icon: Icon(Icons.map),
            onPressed: () => mapBloc.setMayType(MapType.normal),
          ),
          IconButton(
            icon: Icon(Icons.dashboard),
            onPressed: () => mapBloc.setMayType(MapType.terrain),
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          StreamBuilder<MapType>(
            stream: mapBloc.mayType,
            initialData: MapType.hybrid,
            builder: (context, snapshotType) {
              return GoogleMap(
                mapType: snapshotType.data,
                initialCameraPosition: buildInitialCamera(),
                zoomGesturesEnabled: true,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
              );
            },
          ),
          //TODO: Fix the scroll and item are not visible
          StreamBuilder<List<Office>>(
            stream: mapBloc.offices,
            builder: (context, snapshot) {
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  var item = snapshot.data[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.red,
                      child: Text("P"),
                    ),
                    title: Text(item.name),
                    subtitle: Text(item.address),
                  );
                  //return Text(item.name);
                },
              );
            },
          )
        ],
      ),
    );
  }

  Set<Marker> buildMarkerSet(List<Office> offices) {
    Set<Marker> markers = Set<Marker>();
    for (var office in offices) {
      markers.add(office.toMarker());
    }
    return markers;
  }

  CameraPosition buildInitialCamera() {
    return CameraPosition(
      target: LatLng(37.42796133580664, -122.085749655962),
      zoom: 14.4746,
    );
  }
}
