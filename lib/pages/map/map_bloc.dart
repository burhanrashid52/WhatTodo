import 'dart:async';

import 'package:flutter_app/bloc/bloc_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapBloc extends BlocBase {
  StreamController<MapType> _mapTypeController =
      StreamController<MapType>.broadcast();

  Stream<MapType> get mayType => _mapTypeController.stream;

  @override
  void dispose() {
    _mapTypeController.close();
  }

  void setMayType(MapType mayType) {
    _mapTypeController.sink.add(mayType);
  }
}
