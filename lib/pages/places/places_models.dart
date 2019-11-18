import 'package:json_annotation/json_annotation.dart';

part 'places_models.g.dart';

@JsonSerializable()
class PlaceResponse {
  PlaceResponse({this.candidates, this.status});

  factory PlaceResponse.fromJson(Map<String, dynamic> json) =>
      _$PlaceResponseFromJson(json);

  final List<Results> candidates;

  final String status;

  Map<String, dynamic> toJson() => _$PlaceResponseToJson(this);
}

@JsonSerializable()
class Results {
  Results({this.formatted_address, this.geometry, this.name, this.photos});

  factory Results.fromJson(Map<String, dynamic> json) =>
      _$ResultsFromJson(json);

  final String formatted_address;
  final Geometry geometry;

  final String name;

  final List<Photo> photos;

  Map<String, dynamic> toJson() => _$ResultsToJson(this);
}

@JsonSerializable()
class Geometry {
  Geometry({this.location, this.viewport});

  factory Geometry.fromJson(Map<String, dynamic> json) =>
      _$GeometryFromJson(json);

  final Location location;
  final Viewport viewport;

  Map<String, dynamic> toJson() => _$GeometryToJson(this);
}

@JsonSerializable()
class Location {
  Location({this.lat, this.lng});

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);

  final double lat;
  final double lng;

  Map<String, dynamic> toJson() => _$LocationToJson(this);
}

@JsonSerializable()
class Viewport {
  Viewport({this.northeast, this.southwest});

  factory Viewport.fromJson(Map<String, dynamic> json) =>
      _$ViewportFromJson(json);

  final Northeast northeast;

  final Southwest southwest;

  Map<String, dynamic> toJson() => _$ViewportToJson(this);
}

@JsonSerializable()
class Northeast {
  Northeast({this.lat, this.lng});

  factory Northeast.fromJson(Map<String, dynamic> json) =>
      _$NortheastFromJson(json);

  final double lat;

  final double lng;

  Map<String, dynamic> toJson() => _$NortheastToJson(this);
}

@JsonSerializable()
class Southwest {
  Southwest({this.lat, this.lng});

  factory Southwest.fromJson(Map<String, dynamic> json) =>
      _$SouthwestFromJson(json);

  final double lat;

  final double lng;

  Map<String, dynamic> toJson() => _$SouthwestToJson(this);
}

@JsonSerializable()
class Photo {
  Photo(
      {this.height, this.html_attributions, this.photo_reference, this.width});

  factory Photo.fromJson(Map<String, dynamic> json) => _$PhotoFromJson(json);

  final int height;

  final List<String> html_attributions;

  final String photo_reference;

  final int width;

  Map<String, dynamic> toJson() => _$PhotoToJson(this);
}
