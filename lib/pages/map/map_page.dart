import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/bloc_provider.dart';
import 'package:flutter_app/pages/map/map_bloc.dart';
import 'package:flutter_app/pages/map/map_widget.dart';
import 'package:flutter_app/pages/places/places_models.dart';
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
            icon: Icon(Icons.search),
            onPressed: () {
              final canditate = showSearch(
                context: context,
                delegate: SearchPlaces(mapBloc),
              );
            },
          ),
          buildPopupMenu(context),
        ],
      ),
      body: MyGoogleMap(),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.send,
          color: Colors.white,
        ),
        onPressed: () {
          final locationInfo = LocationInfo(
              18.4695, 73.8890, "Kondhwa", "Graphikon Paradise lane");
          Navigator.pop(context, locationInfo);
        },
      ),
    );
  }

  Widget buildPopupMenu(BuildContext context) {
    final MapBloc mapBloc = BlocProvider.of(context);
    return PopupMenuButton<MapType>(
      icon: Icon(Icons.more_vert),
      onSelected: (MapType result) async {
        mapBloc.setMayType(result);
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<MapType>>[
        const PopupMenuItem<MapType>(
          value: MapType.satellite,
          child: Text('Satellite'),
        ),
        const PopupMenuItem<MapType>(
          value: MapType.hybrid,
          child: Text('Hybrid'),
        ),
        const PopupMenuItem<MapType>(
          value: MapType.normal,
          child: Text('Normal'),
        ),
        const PopupMenuItem<MapType>(
          value: MapType.terrain,
          child: Text('Terrain'),
        )
      ],
    );
  }
}
