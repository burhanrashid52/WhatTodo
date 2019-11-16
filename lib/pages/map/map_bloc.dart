import 'dart:async';

import 'package:flutter_app/bloc/bloc_provider.dart';
import 'package:flutter_app/pages/places/places_api_service.dart';
import 'package:flutter_app/pages/places/places_models.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapBloc extends BlocBase {
  MapBloc(this.placesApiService) {
    _fetchLocations("A");
  }

  final PlacesApiService placesApiService;

  StreamController<MapType> _mapTypeController =
      StreamController<MapType>.broadcast();

  Stream<MapType> get mayType => _mapTypeController.stream;

  StreamController<List<Candidate>> _officesController =
      StreamController<List<Candidate>>.broadcast();

  Stream<List<Candidate>> get offices => _officesController.stream;

  @override
  void dispose() {
    _mapTypeController.close();
    _officesController.close();
  }

  void setMayType(MapType mayType) {
    _mapTypeController.sink.add(mayType);
  }

  void _fetchLocations(String placeQuery) {
    placesApiService.searchPlaces(placeQuery).then((value) {
      _officesController.sink.add(value.candidates);
    });
  }
}

/*extension MyOffices on Office {
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
}*/
