import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/bloc_provider.dart';
import 'package:flutter_app/pages/map/map_bloc.dart';
import 'package:flutter_app/pages/map/place_widget.dart';
import 'package:flutter_app/pages/places/places_models.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatelessWidget {
  final Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    final MapBloc mapBloc = BlocProvider.of(context);

    _createMapTypeListener(mapBloc.mayType);

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
           Container(
            child: StreamBuilder<MapType>(
              stream: mapBloc.mayType,
              initialData: MapType.hybrid,
              builder: (context, snapshotType) {
                return buildGoogleMap(snapshotType.data);
              },
            ),
          ),
          //TODO: Fix the scroll and item are not visible
          Container(
            child: StreamBuilder<List<Candidate>>(
              stream: mapBloc.offices,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return PlaceWidget(snapshot.data);
                }
                return CircularProgressIndicator();
              },
            ),
          )
        ],
      ),
    );
  }

  GoogleMap buildGoogleMap(MapType mayType) {
    return GoogleMap(
      mapType: mayType,
      initialCameraPosition: buildInitialCamera(),
      zoomGesturesEnabled: true,
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
    );
  }

  /*Set<Marker> buildMarkerSet(List<Office> offices) {
    Set<Marker> markers = Set<Marker>();
    for (var office in offices) {
      markers.add(office.toMarker());
    }
    return markers;
  }*/

  CameraPosition buildInitialCamera() {
    return CameraPosition(
      target: LatLng(37.42796133580664, -122.085749655962),
      zoom: 14.4746,
    );
  }

  void _createMapTypeListener(Stream<MapType> mayType) {
    mayType.listen((value) {
      if (_controller != null) {
        // _controller
      }
    });
  }
}
