import 'package:flutterflow_ui/flutterflow_ui.dart';
import '../widgets/reservations_page_widget.dart' show RestaurantReservationsPageWidget;
import 'package:flutter/material.dart';

class RestaurantReservationsPageModel
    extends FlutterFlowModel<RestaurantReservationsPageWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {
    unfocusNode.dispose();
  }

/// Action blocks are added here.

/// Additional helper methods are added here.
}

