import '../widgets/restaurants_page_widget.dart' show RestaurantsPageWidget;
import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';

class RestaurantsPageModel extends FlutterFlowModel<RestaurantsPageWidget> {
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