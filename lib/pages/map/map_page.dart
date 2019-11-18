import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/bloc_provider.dart';
import 'package:flutter_app/pages/map/map_bloc.dart';
import 'package:flutter_app/pages/map/map_widget.dart';
import 'package:flutter_app/pages/places/search_places.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatelessWidget {
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
              final canditate = showSearch(
                context: context,
                delegate: SearchPlaces(mapBloc),
              );
            },
          ),
        ],
      ),
      body: MyGoogleMap(),
    );
  }
}
