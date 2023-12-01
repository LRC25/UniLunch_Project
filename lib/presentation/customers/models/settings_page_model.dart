import 'package:flutterflow_ui/flutterflow_ui.dart';

import '../widgets/settings_page_widget.dart' show CustomerSettingsPageWidget;
import 'package:flutter/material.dart';

class CustomerSettingsPageModel
    extends FlutterFlowModel<CustomerSettingsPageWidget> {
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
