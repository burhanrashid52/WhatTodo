import 'dart:convert';
import 'dart:io';
import 'package:flutter_app/pages/places/places_models.dart';
import 'package:http/http.dart' as http;

// ignore: constant_identifier_names
const BASE_URL = "https://maps.googleapis.com/maps/api/place";
// ignore: constant_identifier_names
const API_KEY = "YOUR_PLACES_KEY_HERE";
// ignore: constant_identifier_names
const PLACE_PARAMS =
    "/textsearch/json?key=$API_KEY&inputtype=textquery&fields=photos,formatted_address,name,geometry&&input=";
// ignore: constant_identifier_names
const SEARCH_PLACE_ENDPOINT = BASE_URL + PLACE_PARAMS;

class PlacesApiService {
  Future<PlaceResponse> searchPlaces(String placeQuery) async {
    final googlePlacesURL = SEARCH_PLACE_ENDPOINT + placeQuery;
    print(googlePlacesURL);
    // Retrieve the locations of Google offices
    final response = await http.get(googlePlacesURL);
    if (response.statusCode == 200) {
      return PlaceResponse.fromJson(json.decode(response.body));
    } else {
      throw HttpException(
          'Unexpected status code ${response.statusCode}:'
          ' ${response.reasonPhrase}',
          uri: Uri.parse(googlePlacesURL));
    }
  }
}
