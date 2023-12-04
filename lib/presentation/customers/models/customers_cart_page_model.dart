import 'package:flutterflow_ui/flutterflow_ui.dart';
import '../widgets/customers_cart_page_widget.dart' show CustomerCartPageWidget;
import 'package:flutter/material.dart';

class CustomerCartPageModel extends FlutterFlowModel<CustomerCartPageWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  DateTime? datePicked;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {
    unfocusNode.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
