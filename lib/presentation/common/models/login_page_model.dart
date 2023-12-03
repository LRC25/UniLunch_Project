import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:unilunch/alerts.dart';
import '../../../logic/Cliente.dart';
import '../../../logic/Restaurante.dart';
import '../../../logic/Usuario.dart';
import '../../customers/widgets/navbar_customer_page_widget.dart';
import '../../restaurants/widgets/navbar_restaurant_page_widget.dart';
import '../widgets/login_page_widget.dart' show LoginPageWidget;
import 'package:flutter/material.dart';

class LoginPageModel extends FlutterFlowModel<LoginPageWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for emailAddress widget.
  FocusNode? emailAddressFocusNode;
  TextEditingController? emailAddressController;
  String? Function(BuildContext, String?)? emailAddressControllerValidator;
  // State field(s) for password widget.
  FocusNode? passwordFocusNode;
  TextEditingController? passwordController;
  late bool passwordVisibility;
  String? Function(BuildContext, String?)? passwordControllerValidator;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    passwordVisibility = false;
  }

  void dispose() {
    unfocusNode.dispose();
    emailAddressFocusNode?.dispose();
    emailAddressController?.dispose();

    passwordFocusNode?.dispose();
    passwordController?.dispose();
  }

  /// Action blocks are added here.

  void iniciarSesion(BuildContext context) async {
    if (emailAddressController.text != "" && passwordController.text != "") {
      String email = emailAddressController.text;
      String contrasenna = passwordController.text;
      dynamic usuario = await Usuario.vacio().login(email, contrasenna);
      if (usuario is Cliente) {
        Cliente cliente = usuario as Cliente;
        Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) => NavbarCustomerPage(cliente: cliente)));
      } else if (usuario is Restaurante) {
        Restaurante restaurante = usuario as Restaurante;
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>
            NavbarRestaurantPage(restaurante: restaurante)));
      } else {
        warningMessage(context, "Verificar sus datos");
      }
    } else {
      warningMessage(context, "Por favor llenar todos los campos");
    }
  }
  /// Additional helper methods are added here.
}