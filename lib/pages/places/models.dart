import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Locations {
  Locations({this.offices, this.regions});

  factory Locations.fromJson(Map<String, dynamic> json) {
    return Locations(
      offices: json['offices'] != null
          ? (json['offices'] as List).map((i) => Office.fromJson(i)).toList()
          : null,
      regions: json['regions'] != null
          ? (json['regions'] as List).map((i) => Region.fromJson(i)).toList()
          : null,
    );
  }

  List<Office> offices;

  List<Region> regions;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.offices != null) {
      data['offices'] = this.offices.map((v) => v.toJson()).toList();
    }
    if (this.regions != null) {
      data['regions'] = this.regions.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

@JsonSerializable()
class Region {
  Region({this.coords, this.id, this.name, this.zoom});

  factory Region.fromJson(Map<String, dynamic> json) {
    return Region(
      coords: json['coords'] != null ? Coords.fromJson(json['coords']) : null,
      id: json['id'],
      name: json['name'],
      zoom: json['zoom'],
    );
  }

  Coords coords;
  String id;

  String name;

  double zoom;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['zoom'] = this.zoom;
    if (this.coords != null) {
      data['coords'] = this.coords.toJson();
    }
    return data;
  }
}

@JsonSerializable()
class Coords {
  Coords({this.lat, this.lng});

  factory Coords.fromJson(Map<String, dynamic> json) {
    return Coords(
      lat: json['lat'],
      lng: json['lng'],
    );
  }

  double lat;

  double lng;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    return data;
  }
}

@JsonSerializable()
class Office {
  Office(
      {this.address,
      this.id,
      this.image,
      this.lat,
      this.lng,
      this.name,
      this.phone,
      this.region});

  factory Office.fromJson(Map<String, dynamic> json) {
    return Office(
      address: json['address'],
      id: json['id'],
      image: json['image'],
      lat: json['lat'],
      lng: json['lng'],
      name: json['name'],
      phone: json['phone'],
      region: json['region'],
    );
  }

  String address;
  String id;
  String image;
  double lat;
  double lng;
  String name;
  String phone;

  String region;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['address'] = this.address;
    data['id'] = this.id;
    data['image'] = this.image;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['region'] = this.region;
    return data;
  }
}
