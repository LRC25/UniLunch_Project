import 'package:google_maps_flutter/google_maps_flutter.dart'
    as google_maps_dart;

import '../widgets/customers_page_widget.dart' show CustomersPageWidget;
import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';

class CustomersPageModel extends FlutterFlowModel<CustomersPageWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for searchRestaurant widget.
  FocusNode? searchRestaurantFocusNode;
  TextEditingController? searchRestaurantController;
  google_maps_dart.GoogleMapController? googleMapController;
  String? Function(BuildContext, String?)? searchRestaurantControllerValidator;

  /// Initialization and disposal methods.

  static const initialCameraPosition = google_maps_dart.CameraPosition(
      target: google_maps_dart.LatLng(7.1380158, -73.1198447), zoom: 16.25);

  void initState(BuildContext context) {}

  void dispose() {
    unfocusNode.dispose();
    searchRestaurantFocusNode?.dispose();
    searchRestaurantController?.dispose();
    googleMapController?.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
