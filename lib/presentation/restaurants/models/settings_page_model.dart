import 'package:flutterflow_ui/flutterflow_ui.dart';
import '../../../logic/Usuario.dart';

import '../widgets/settings_page_widget.dart' show RestaurantSettingsPageWidget;
import 'package:flutter/material.dart';

class RestaurantSettingsPageModel
    extends FlutterFlowModel<RestaurantSettingsPageWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();



  set openingText(String openingText) {}

  set openingTime(DateTime openingTime) {}

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {
    unfocusNode.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
