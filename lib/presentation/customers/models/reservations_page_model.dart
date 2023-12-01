import 'package:flutterflow_ui/flutterflow_ui.dart';

import '../widgets/reservations_page_widget.dart' show CustomerReservationsPageWidget;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomerReservationsPageModel extends FlutterFlowModel<CustomerReservationsPageWidget> {
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
