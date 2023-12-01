import 'package:flutterflow_ui/flutterflow_ui.dart';
import '../widgets/registration_page_widget.dart' show RegistrationPageWidget;
import 'package:flutter/material.dart';

class RegistrationPageModel extends FlutterFlowModel<RegistrationPageWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for name widget.
  FocusNode? nameFocusNode1;
  TextEditingController? nameController1;
  String? Function(BuildContext, String?)? nameController1Validator;
  // State field(s) for emailAddress widget.
  FocusNode? emailAddressFocusNode;
  TextEditingController? emailAddressController;
  String? Function(BuildContext, String?)? emailAddressControllerValidator;
  // State field(s) for password widget.
  FocusNode? passwordFocusNode;
  TextEditingController? passwordController;
  late bool passwordVisibility;
  String? Function(BuildContext, String?)? passwordControllerValidator;
  // State field(s) for confirmPassword widget.
  FocusNode? confirmPasswordFocusNode;
  TextEditingController? confirmPasswordController;
  late bool confirmPasswordVisibility;
  String? Function(BuildContext, String?)? confirmPasswordControllerValidator;
  // State field(s) for Switch widget.
  bool isRestaurant = false;
  // State field(s) for name widget.
  FocusNode? nameFocusNode2;
  TextEditingController? nameController2;
  String? Function(BuildContext, String?)? nameController2Validator;
  // State field(s) for description widget.
  FocusNode? descriptionFocusNode;
  TextEditingController? descriptionController;
  String? Function(BuildContext, String?)? descriptionControllerValidator;
  // State field(s) for address widget.
  FocusNode? addressFocusNode1;
  TextEditingController? addressController1;
  String? Function(BuildContext, String?)? addressController1Validator;
  // State field(s) for address widget.
  FocusNode? addressFocusNode2;
  TextEditingController? addressController2;
  String? Function(BuildContext, String?)? addressController2Validator;
  // State field(s) for logo widget.
  FocusNode? logoFocusNode;
  TextEditingController? logoController;
  String? Function(BuildContext, String?)? logoControllerValidator;
  String openingText = "Hora de Apertura";
  String closingText = "Hora de Cierre";
  DateTime? openingTime;
  DateTime? closingTime;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    passwordVisibility = false;
    confirmPasswordVisibility = false;
  }

  void dispose() {
    unfocusNode.dispose();
    nameFocusNode1?.dispose();
    nameController1?.dispose();

    emailAddressFocusNode?.dispose();
    emailAddressController?.dispose();

    passwordFocusNode?.dispose();
    passwordController?.dispose();

    confirmPasswordFocusNode?.dispose();
    confirmPasswordController?.dispose();

    nameFocusNode2?.dispose();
    nameController2?.dispose();

    descriptionFocusNode?.dispose();
    descriptionController?.dispose();

    addressFocusNode1?.dispose();
    addressController1?.dispose();

    addressFocusNode2?.dispose();
    addressController2?.dispose();

    logoFocusNode?.dispose();
    logoController?.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
