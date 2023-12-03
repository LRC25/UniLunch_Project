import 'package:google_maps_flutter/google_maps_flutter.dart' as google_maps_dart;

import '../widgets/customers_page_widget.dart' show CustomersPageWidget;
import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';

class CustomersPageModel extends FlutterFlowModel<CustomersPageWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for searchRestaurant widget.
  FocusNode? searchRestaurantFocusNode;
  TextEditingController? searchRestaurantController;
  String? Function(BuildContext, String?)? searchRestaurantControllerValidator;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {
    unfocusNode.dispose();
    searchRestaurantFocusNode?.dispose();
    searchRestaurantController?.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}