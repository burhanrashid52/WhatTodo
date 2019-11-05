import 'dart:async';

import 'package:flutter_app/bloc/bloc_provider.dart';
import 'package:flutter_app/pages/places/models.dart';
import 'package:flutter_app/pages/places/places_api_service.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapBloc extends BlocBase {
  MapBloc(this.placesApiService) {
    _fetchLocations();
  }

  final PlacesApiService placesApiService;

  StreamController<MapType> _mapTypeController =
      StreamController<MapType>.broadcast();

  Stream<MapType> get mayType => _mapTypeController.stream;

  StreamController<List<Office>> _officesController =
      StreamController<List<Office>>.broadcast();

  Stream<List<Office>> get offices => _officesController.stream;

  @override
  void dispose() {
    _mapTypeController.close();
    _officesController.close();
  }

  void setMayType(MapType mayType) {
    _mapTypeController.sink.add(mayType);
  }

  void _fetchLocations() {
    placesApiService.getGoogleOffices().then((value) {
      _officesController.sink.add(value.offices);
    });
  }
}

extension MyOffices on Office {
  Marker toMarker() {
    return Marker(
      markerId: MarkerId(name),
      position: LatLng(lat, lng),
      infoWindow: InfoWindow(
        title: name,
        snippet: address,
      ),
    );
  }
}
