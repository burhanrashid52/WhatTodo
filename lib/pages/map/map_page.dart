import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/bloc_provider.dart';
import 'package:flutter_app/pages/map/map_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatelessWidget {
  final Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    final MapBloc mapBloc = BlocProvider.of(context);
    return new Scaffold(
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
      body: StreamBuilder<MapType>(
          stream: mapBloc.mayType,
          initialData: MapType.hybrid,
          builder: (context, snapshot) {
            return GoogleMap(
              mapType: snapshot.data,
              initialCameraPosition: _kGooglePlex,
              zoomGesturesEnabled: true,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: _goToTheLake,
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}
