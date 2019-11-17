import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/bloc_provider.dart';
import 'package:flutter_app/pages/map/map_bloc.dart';
import 'package:flutter_app/pages/map/place_widget.dart';
import 'package:flutter_app/pages/places/search_places.dart';
import 'package:flutter_app/pages/places/places_models.dart';
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
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: SearchPlaces(mapBloc),
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          MyGoogleMap(),
          //TODO: Fix the scroll and item are not visible
          StreamBuilder<List<Candidate>>(
            stream: mapBloc.offices,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return PlaceWidget(snapshot.data);
              }
              return CircularProgressIndicator();
            },
          )
        ],
      ),
    );
  }
}

class MyGoogleMap extends StatelessWidget {
  final Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    final MapBloc mapBloc = BlocProvider.of(context);
    return StreamBuilder<MapType>(
      stream: mapBloc.mayType,
      initialData: MapType.hybrid,
      builder: (context, snapshotType) {
        return GoogleMap(
          mapType: snapshotType.data,
          initialCameraPosition: _buildInitialCamera(),
          zoomGesturesEnabled: true,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        );
      },
    );
  }

  CameraPosition _buildInitialCamera() {
    return CameraPosition(
      target: LatLng(37.42796133580664, -122.085749655962),
      zoom: 14.4746,
    );
  }
}
