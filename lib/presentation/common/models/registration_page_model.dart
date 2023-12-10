import 'dart:convert';

import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:unilunch/logic/Restaurante.dart';
import 'package:unilunch/network_utilities.dart';
import 'package:unilunch/presentation/common/models/autocomplete_prediction.dart';
import 'package:unilunch/presentation/common/models/place_auto_complete_response.dart';
import '../../../alerts.dart';
import '../../../logic/Cliente.dart';
import '../widgets/registration_page_widget.dart' show RegistrationPageWidget;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
  // State field(s) for logo widget.
  FocusNode? logoFocusNode;
  TextEditingController? logoController;
  String? Function(BuildContext, String?)? logoControllerValidator;
  String openingText = "Hora de Apertura";
  String closingText = "Hora de Cierre";
  DateTime? openingTime;
  DateTime? closingTime;

  String? description;
  String? placeId;

  final String apiKey = "AIzaSyCbDjS9GXcjjfbEqUQ0kDVSi6EEQxMwBfM";

  double? latitude;
  double? longitude;
  String? restaurantAddress;

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

    logoFocusNode?.dispose();
    logoController?.dispose();
  }

  /// Action blocks are added here.

  void registrarUsuario(BuildContext context) async {
    RegExp regex_email = RegExp(r"^[a-zA-Z0-9_!#$%&'\*+/=?{|}~^.-]+@[a-zA-Z0-9-]+.[a-zA-Z0-9-]+[a-zA-Z0-9_.][a-zA-Z0-9_]+[a-zA-Z0-9_.][a-zA-Z0-9_]+$");
    RegExp regex_contrasenna = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*#&?])[A-Za-z\d@$!#%*?&]{5,20}$');
    if (isRestaurant == false) {
      if (nameController1.text != "" &&
          emailAddressController.text != "" &&
          passwordController.text != "" &&
          passwordControllerValidator != "") {

        if (!regex_email.hasMatch(emailAddressController.text) && !regex_contrasenna.hasMatch(passwordController.text))
        { warningMessage(context, "Verificar correo y contraseña");       }

        else if (!regex_email.hasMatch(emailAddressController.text)){
          warningMessage(context, "Verificar correo");
        }

        else if (!regex_contrasenna.hasMatch(passwordController.text)){
          warningMessage(context, "Verificar contraseña");
        }

        else {
          if (passwordController.text == confirmPasswordController.text) {
          Cliente cliente = Cliente.registrar(
              nombre: nameController1.text,
              contrasenna: passwordController.text,
              email: emailAddressController.text,
              tipoUsuario: "Cliente");

          String response =
          await cliente.resgistrarCliente(passwordController.text);
          if (response == "correcto") {
            registrationAcceptMessage(
                context, "Se ha registrado correctamente");
          } else {
            errorMessage(context, "Ha ocurrido un error, no se pudo registrar");
          }
          }
          else {
            warningMessage(context, "Las contraseñas no coinciden");
          }
        }

      }
      else  {
        warningMessage(context, "Por favor llenar todos los campos");
      }


    } else { {
      if (nameController1.text != "" &&
          emailAddressController.text != "" &&
          passwordController.text != "" &&
          passwordControllerValidator != "" &&
          nameController2.text != "" &&
          //addressController1 != "" &&
          restaurantAddress != null &&
          descriptionController != "" &&
          logoController != "" &&
          openingTime != null &&
          closingTime != null
          && latitude != null
          && longitude != null) {

        if (!regex_email.hasMatch(emailAddressController.text) && !regex_contrasenna.hasMatch(passwordController.text))
         { warningMessage(context, "Verificar correo y contraseña");       }


        else if (!regex_email.hasMatch(emailAddressController.text)){
          warningMessage(context, "Verificar correo");
        }

        else if (!regex_contrasenna.hasMatch(passwordController.text)){
          warningMessage(context, "Verificar contraseña");
        }

        else {
          if (passwordController.text == confirmPasswordController.text) {
            Restaurante restaurante = Restaurante.registro(
                nombre: nameController1.text,
                email: emailAddressController.text,
                contrasenna: passwordController.text,
                tipoUsuario: "Restaurante",
                latitud: latitude as double,
                longitud: longitude as double,
                nombreRestaurante: nameController2.text,
                direccion: restaurantAddress as String,
                descripcion: descriptionController.text,
                horaApertura: openingTime as DateTime,
                horaCierre: closingTime as DateTime,
                imagen: logoController.text);

            String response =
            await restaurante.resgistrarRestaurante(passwordController.text);
            if (response == "correcto") {
              registrationAcceptMessage(
                  context, "Se ha registrado correctamente");
            } else {
              errorMessage(context, "Ha ocurrido un error, no se pudo registrar");
            }
          }
          else {
            warningMessage(context, "Las contraseñas no coinciden");
          }
        }

      }
      else  {
        warningMessage(context, "Por favor llenar todos los campos");
      }


    } }

  }

  List<AutocompletePrediction> placePredictions = [];

  void placeAutocomplete(String query, StateSetter setState) async {
    Uri uri = Uri.https("maps.googleapis.com",
        "maps/api/place/autocomplete/json", {"input": query, "key": apiKey});

    String? response = await NetworkUtilities.fetchUrl(uri);

    if (response != null) {
      PlaceAutocompleteResponse result =
          PlaceAutocompleteResponse.parseAutocompleteResult(response);
      if (result.predictions != null) {
        placePredictions = result.predictions!;
      }
    }
  }

  void requestLatLong(String placeId) async {
    Uri uri = Uri.https("maps.googleapis.com", "maps/api/place/details/json",
        {"place_id": placeId, "key": apiKey});

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      latitude = jsonResponse['result']['geometry']['location']['lat'];
      longitude = jsonResponse['result']['geometry']['location']['lng'];
      restaurantAddress = jsonResponse['result']['formatted_address'];
    }
  }

  /// Additional helper methods are added here.
}
