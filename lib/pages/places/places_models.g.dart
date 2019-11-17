// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'places_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaceResponse _$PlaceResponseFromJson(Map<String, dynamic> json) {
  return PlaceResponse(
    candidates: (json['candidates'] as List)
        ?.map((e) =>
            e == null ? null : Candidate.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    status: json['status'] as String,
  );
}

Map<String, dynamic> _$PlaceResponseToJson(PlaceResponse instance) =>
    <String, dynamic>{
      'candidates': instance.candidates,
      'status': instance.status,
    };

Candidate _$CandidateFromJson(Map<String, dynamic> json) {
  return Candidate(
    formatted_address: json['formatted_address'] as String,
    geometry: json['geometry'] == null
        ? null
        : Geometry.fromJson(json['geometry'] as Map<String, dynamic>),
    name: json['name'] as String,
    photos: (json['photos'] as List)
        ?.map(
            (e) => e == null ? null : Photo.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$CandidateToJson(Candidate instance) => <String, dynamic>{
      'formatted_address': instance.formatted_address,
      'geometry': instance.geometry,
      'name': instance.name,
      'photos': instance.photos,
    };

Geometry _$GeometryFromJson(Map<String, dynamic> json) {
  return Geometry(
    location: json['location'] == null
        ? null
        : Location.fromJson(json['location'] as Map<String, dynamic>),
    viewport: json['viewport'] == null
        ? null
        : Viewport.fromJson(json['viewport'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$GeometryToJson(Geometry instance) => <String, dynamic>{
      'location': instance.location,
      'viewport': instance.viewport,
    };

Location _$LocationFromJson(Map<String, dynamic> json) {
  return Location(
    lat: (json['lat'] as num)?.toDouble(),
    lng: (json['lng'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$LocationToJson(Location instance) => <String, dynamic>{
      'lat': instance.lat,
      'lng': instance.lng,
    };

Viewport _$ViewportFromJson(Map<String, dynamic> json) {
  return Viewport(
    northeast: json['northeast'] == null
        ? null
        : Northeast.fromJson(json['northeast'] as Map<String, dynamic>),
    southwest: json['southwest'] == null
        ? null
        : Southwest.fromJson(json['southwest'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ViewportToJson(Viewport instance) => <String, dynamic>{
      'northeast': instance.northeast,
      'southwest': instance.southwest,
    };

Northeast _$NortheastFromJson(Map<String, dynamic> json) {
  return Northeast(
    lat: (json['lat'] as num)?.toDouble(),
    lng: (json['lng'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$NortheastToJson(Northeast instance) => <String, dynamic>{
      'lat': instance.lat,
      'lng': instance.lng,
    };

Southwest _$SouthwestFromJson(Map<String, dynamic> json) {
  return Southwest(
    lat: (json['lat'] as num)?.toDouble(),
    lng: (json['lng'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$SouthwestToJson(Southwest instance) => <String, dynamic>{
      'lat': instance.lat,
      'lng': instance.lng,
    };

Photo _$PhotoFromJson(Map<String, dynamic> json) {
  return Photo(
    height: json['height'] as int,
    html_attributions:
        (json['html_attributions'] as List)?.map((e) => e as String)?.toList(),
    photo_reference: json['photo_reference'] as String,
    width: json['width'] as int,
  );
}

Map<String, dynamic> _$PhotoToJson(Photo instance) => <String, dynamic>{
      'height': instance.height,
      'html_attributions': instance.html_attributions,
      'photo_reference': instance.photo_reference,
      'width': instance.width,
    };
