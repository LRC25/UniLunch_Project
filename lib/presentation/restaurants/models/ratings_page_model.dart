import 'package:flutterflow_ui/flutterflow_ui.dart';
import '../widgets/ratings_page_widget.dart' show RestaurantRatingsPageWidget;
import 'package:flutter/material.dart';

class RestaurantRatingsPageModel
    extends FlutterFlowModel<RestaurantRatingsPageWidget> {
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
