import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/bloc_provider.dart';
import 'package:flutter_app/pages/map/map_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
          myLocationButtonEnabled: false,
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
