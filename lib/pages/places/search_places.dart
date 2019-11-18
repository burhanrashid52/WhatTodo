import 'package:flutter/material.dart';
import 'package:flutter_app/pages/map/map_bloc.dart';
import 'package:flutter_app/pages/map/place_widget.dart';
import 'package:flutter_app/pages/places/places_models.dart';

class SearchPlaces extends SearchDelegate<Results> {
  SearchPlaces(this._mapBloc);

  final MapBloc _mapBloc;

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          close(context, null);
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    _mapBloc.fetchLocations(query);
    return _buildPlaceStream();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _mapBloc.fetchLocations(query);
    return _buildPlaceStream();
  }

  StreamBuilder _buildPlaceStream() {
    return StreamBuilder<List<Results>>(
      stream: _mapBloc.offices,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return PlaceWidget(snapshot.data);
        }
        return CircularProgressIndicator();
      },
    );
  }
}
