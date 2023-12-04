import 'dart:convert';
import 'autocomplete_prediction.dart';

class LatLongResponse {
  final String? status;
  final String? lat;
  final String? lng;

  LatLongResponse({this.status, this.lat, this.lng});

  factory LatLongResponse.fromJson(Map<String, dynamic> json) {
    return LatLongResponse(
      status: json['status'] as String?,
      lat: json['result.geometry.location.lat'] != null
          ? json['result.geometry.location.lat']
              .map<AutocompletePrediction>(
                  (json) => AutocompletePrediction.fromJson(json))
              .toList()
          : null,
      lng: json['result.geometry.location.lng'] != null
          ? json['result.geometry.location.lng']
              .map<AutocompletePrediction>(
                  (json) => AutocompletePrediction.fromJson(json))
              .toList()
          : null,
    );
  }

  static LatLongResponse parseAutocompleteResult(String responseBody) {
    final parsed = json.decode(responseBody).cast<String, dynamic>();
    return LatLongResponse.fromJson(parsed);
  }
}
