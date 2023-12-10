import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:unilunch/network_utilities.dart';

import '../../common/models/autocomplete_prediction.dart';
import '../../common/models/place_auto_complete_response.dart';
import '../widgets/settings_page_widget.dart' show RestaurantSettingsPageWidget;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RestaurantSettingsPageModel
    extends FlutterFlowModel<RestaurantSettingsPageWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for address widget.
  FocusNode? addressFocusNode1;
  TextEditingController? addressController1;
  String? Function(BuildContext, String?)? addressController1Validator;

  final String apiKey = "AIzaSyCbDjS9GXcjjfbEqUQ0kDVSi6EEQxMwBfM";

  double? latitude;
  double? longitude;
  String? restaurantAddress;

  set openingText(String openingText) {}

  set openingTime(DateTime openingTime) {}

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {
    unfocusNode.dispose();

    addressFocusNode1?.dispose();
    addressController1?.dispose();
  }

  /// Action blocks are added here.
  List<AutocompletePrediction> placePredictions = [];

  void placeAutocomplete(String query, StateSetter setState) async {
    Uri uri = Uri.https("maps.googleapis.com",
        "maps/api/place/autocomplete/json", {"input": query, "key": apiKey});

    String? response = await NetworkUtilities.fetchUrl(uri);

    if (response != null) {
      PlaceAutocompleteResponse result =
          PlaceAutocompleteResponse.parseAutocompleteResult(response);
      if (result.predictions != null) {
        placePredictions = result.predictions!;
      }
    }
  }

  void requestLatLong(String placeId) async {
    Uri uri = Uri.https("maps.googleapis.com", "maps/api/place/details/json",
        {"place_id": placeId, "key": apiKey});

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      latitude = jsonResponse['result']['geometry']['location']['lat'];
      longitude = jsonResponse['result']['geometry']['location']['lng'];
    }
  }

  void updateAddress() async {

  }

  /// Additional helper methods are added here.
}
