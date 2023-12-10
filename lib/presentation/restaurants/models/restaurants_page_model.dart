import 'package:flutter/services.dart';
import 'package:unilunch/alerts.dart';
import 'package:unilunch/logic/Restaurante.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../logic/Plato.dart';
import '../widgets/restaurants_page_widget.dart' show RestaurantsPageWidget;
import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';

class RestaurantsPageModel extends FlutterFlowModel<RestaurantsPageWidget> {
  ///  State fields for stateful widgets in this page.
  /// 

  final unfocusNode = FocusNode();

  final currencyFormat = NumberFormat.simpleCurrency(locale: "es_US");

  TextEditingController? nameController;
  String? Function(BuildContext, String?)? nameControllerValidator;

  TextEditingController? descriptionController;
  String? Function(BuildContext, String?)? descriptionControllerValidator;

  TextEditingController? priceController;
  String? Function(BuildContext, String?)? priceControllerValidator;

  TextEditingController? imageController;
  String? Function(BuildContext, String?)? imageControllerValidator;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {
    unfocusNode.dispose();

    nameController?.dispose();
    descriptionController?.dispose();
    priceController?.dispose();
    imageController?.dispose();
  }

  /// Action blocks are added here.
  ///

  Padding mostrarPlatos(BuildContext context, Plato plato, Function reload) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(16, 5, 16, 5),
      child: Container(
        width: MediaQuery.sizeOf(context).width,
        height: 110,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 4,
              color: Color(0x33000000),
              offset: Offset(0, 2),
            )
          ],
          borderRadius: BorderRadius.circular(15),
          shape: BoxShape.rectangle,
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              plato.nombre,
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                fontFamily: 'Readex Pro',
                                color: Color(0xFF064244),
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional(1.00, 0.00),
                            child: Text(
                              currencyFormat.format(plato.precio),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                fontFamily: 'Readex Pro',
                                color: Color(0xFF138D20),
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        plato.descripcion,
                        textAlign: TextAlign.start,
                        maxLines: 2,
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Readex Pro',
                          color: Color(0xFF064244),
                        ),
                      ),
                      Flexible(
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            FFButtonWidget(
                              onPressed: () async {
                                if(plato.menuHoy==false) {
                                  String respuesta = await plato.agregarMenu();
                                  if (respuesta == "correcto") {
                                    reload();
                                    accceptMessage(context, "Ha sido agregado con éxito.");
                                  } else {
                                    errorMessage(context, "Ha ocurrido un error");
                                  }
                                } else {
                                  warningMessage(context, "El plato ya fue agregado");
                                }
                              },
                              text: 'Agregar',
                              options: FFButtonOptions(
                                height: 35,
                                padding:
                                EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                                iconPadding:
                                EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                color: Color(0xFF064244),
                                textStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .override(
                                  fontFamily: 'Readex Pro',
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),
                                elevation: 3,
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            FlutterFlowIconButton(
                              borderColor: Colors.transparent,
                              borderRadius: 8,
                              buttonSize: 35,
                              fillColor: Color(0xFFFF7A00),
                              icon: Icon(
                                Icons.edit_rounded,
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                size: 20,
                              ),
                              onPressed: () {
                                editarPlato(context, plato, reload);
                              },
                            ),
                            FlutterFlowIconButton(
                              borderColor: Colors.transparent,
                              borderRadius: 8,
                              buttonSize: 35,
                              fillColor: Color(0xFFE72828),
                              icon: Icon(
                                Icons.delete_forever_rounded,
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                size: 20,
                              ),
                              onPressed: () {
                                mensajeConfirmacion(context, "Esta segudo que desea eliminar el plato", plato, reload);
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  plato.imagen,
                  width: MediaQuery.sizeOf(context).width * 0.25,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding mostrarMenu(BuildContext context, Plato plato, Function reload) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(16, 5, 16, 5),
      child: Container(
        width: MediaQuery.sizeOf(context).width,
        height: 110,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 4,
              color: Color(0x33000000),
              offset: Offset(0, 2),
            )
          ],
          borderRadius: BorderRadius.circular(15),
          shape: BoxShape.rectangle,
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
                //width: MediaQuery.sizeOf(context).width * 0.5,
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Text(
                        plato.nombre,
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Readex Pro',
                          color: Color(0xFF064244),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      plato.descripcion,
                      textAlign: TextAlign.start,
                      maxLines: 2,
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Readex Pro',
                        color: Color(0xFF064244),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          currencyFormat.format(plato.precio),
                          textAlign: TextAlign.start,
                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Readex Pro',
                            color: Color(0xFF138D20),
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        Text(
                          ' - Cantidad: ${plato.stock}',
                          textAlign: TextAlign.start,
                          maxLines: 2,
                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Readex Pro',
                            color: Color(0xFF064244),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Flexible(
                child: Container(
                  width: MediaQuery.sizeOf(context).width * 0.25,
                  //height: MediaQuery.sizeOf(context).height * 1,
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.network(
                          plato.imagen,
                          width: MediaQuery.sizeOf(context).width * 0.25,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(1.00, 1.00),
                        child: FlutterFlowIconButton(
                          borderColor: Color(0x00FFFFFF),
                          borderRadius: 15,
                          buttonSize: 40,
                          fillColor: Color(0xFFE72828),
                          icon: Icon(
                            Icons.delete_forever_rounded,
                            color:
                            FlutterFlowTheme.of(context).secondaryBackground,
                            size: 24,
                          ),
                          onPressed: () async {
                            String respuesta = await plato.quitarMenu();
                            if (respuesta == "correcto") {
                              reload();
                              accceptMessage(context, "Ha sido quitado del menu con éxito.");
                            } else {
                              errorMessage(context, "Ha ocurrido un error");
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void addPlateAlert(BuildContext context, Restaurante restaurante, Function reload) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Color(0xFFC6E8DA),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 5, 16, 5),
                child: Text(
                  'Información de Plato',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: 'Readex Pro',
                    color: Color(0xFF064244),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                child: Container(
                  width: double.infinity,
                  child: TextFormField(
                    controller: nameController,
                    obscureText: false,
                    decoration: InputDecoration(
                      labelText: 'Nombre',
                      labelStyle: FlutterFlowTheme.of(context).labelMedium,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).alternate,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(35),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFF064244),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(35),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).error,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(35),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).error,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(35),
                      ),
                      filled: true,
                      fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                      contentPadding:
                      EdgeInsetsDirectional.fromSTEB(24, 24, 24, 24),
                      prefixIcon: Icon(
                        Icons.text_format_rounded,
                        color: Color(0xFF064244),
                      ),
                    ),
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'Readex Pro',
                      color: Color(0xFF064244),
                    ),
                    validator:
                    nameControllerValidator.asValidator(context),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                child: Container(
                  width: double.infinity,
                  child: TextFormField(
                    controller: descriptionController,
                    obscureText: false,
                    decoration: InputDecoration(
                      labelText: 'Descripción',
                      labelStyle: FlutterFlowTheme.of(context).labelMedium,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).alternate,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(35),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFF064244),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(35),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).error,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(35),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).error,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(35),
                      ),
                      filled: true,
                      fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                      contentPadding:
                      EdgeInsetsDirectional.fromSTEB(24, 24, 24, 24),
                      prefixIcon: Icon(
                        Icons.short_text_rounded,
                        color: Color(0xFF064244),
                      ),
                    ),
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'Readex Pro',
                      color: Color(0xFF064244),
                    ),
                    keyboardType: TextInputType.multiline,
                    validator: descriptionControllerValidator
                        .asValidator(context),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                child: Container(
                  width: double.infinity,
                  child: TextFormField(
                    controller: priceController,
                    obscureText: false,
                    decoration: InputDecoration(
                      labelText: 'Precio',
                      labelStyle: FlutterFlowTheme.of(context).labelMedium,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).alternate,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(35),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFF064244),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(35),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).error,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(35),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).error,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(35),
                      ),
                      filled: true,
                      fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                      contentPadding:
                      EdgeInsetsDirectional.fromSTEB(24, 24, 24, 24),
                      prefixIcon: Icon(
                        Icons.attach_money_rounded,
                        color: Color(0xFF064244),
                      ),
                    ),
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'Readex Pro',
                      color: Color(0xFF064244),
                    ),
                    keyboardType: TextInputType.number,
                    validator:
                    priceControllerValidator.asValidator(context),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                child: Container(
                  width: double.infinity,
                  child: TextFormField(
                    controller: imageController,
                    obscureText: false,
                    decoration: InputDecoration(
                      labelText: 'Logo',
                      labelStyle: FlutterFlowTheme.of(context).labelMedium,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).alternate,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(35),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFF064244),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(35),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).error,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(35),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).error,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(35),
                      ),
                      filled: true,
                      fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                      contentPadding:
                      EdgeInsetsDirectional.fromSTEB(24, 24, 24, 24),
                      prefixIcon: Icon(
                        Icons.image_rounded,
                        color: Color(0xFF064244),
                      ),
                    ),
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'Readex Pro',
                      color: Color(0xFF064244),
                    ),
                    validator:
                    imageControllerValidator.asValidator(context),
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0.00, 0.00),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                  child: FFButtonWidget(
                    onPressed: () async {
                      if(nameController.text != "" && descriptionController.text != "" && priceController.text != "" && imageController.text != ""){
                        Plato newPlato = Plato.vacio();
                        newPlato.nombre = nameController.text;
                        newPlato.descripcion = descriptionController.text;
                        newPlato.precio = int.parse(priceController.text);
                        newPlato.imagen = imageController.text;
                        String respuesta = await newPlato.insertarPlato(restaurante.idRestaurante);
                        if (respuesta == "correcto") {
                          Navigator.of(context).pop();
                          reload();
                          accceptMessage(context, "Ha sido agregado con éxito.");
                        } else {
                          Navigator.of(context).pop();
                          errorMessage(context, "Ha ocurrido un error");
                        }
                      } else {
                        warningMessage(context, "Es necesario llenar todos los campos.");
                      }
                    },
                    text: 'Agregar Plato',
                    options: FFButtonOptions(
                      width: 230,
                      height: 52,
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                      iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                      color: Color(0xFF064244),
                      textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                        fontFamily: 'Readex Pro',
                        color: Colors.white,
                      ),
                      elevation: 3,
                      borderSide: BorderSide(
                        color: Colors.transparent,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(35),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

  void mensajeConfirmacion(BuildContext context, String mensaje, Plato plato, Function reload) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xFFC6E8DA),
          content: SingleChildScrollView(
              child: Container(
                width: MediaQuery.sizeOf(context).width,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.warning_sharp,
                      color: FlutterFlowTheme.of(context).warning,
                      size: 100,
                    ),
                    Align(
                      alignment: AlignmentDirectional(0.00, 0.00),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                        child: Text(
                          mensaje,
                          style: FlutterFlowTheme.of(context).headlineMedium.override(
                            fontFamily: 'Outfit',
                            color: Color(0xFF064244),
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional(0.00, 0.00),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 5, 10, 10),
                        child: FFButtonWidget(
                          onPressed: () async {
                            String respuesta = await plato.eliminarPlato();
                            if(respuesta=="correcto") {
                              Navigator.of(context).pop();
                              reload();
                              accceptMessage(context, "Se ha eliminado corretamente la reserva");
                            } else {
                              Navigator.of(context).pop();
                              errorMessage(context, "Ha ocurrido un error");
                            }
                          },
                          text: 'Si',
                          options: FFButtonOptions(
                            width: 140,
                            height: 52,
                            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                            iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                            color: FlutterFlowTheme.of(context).warning,
                            textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                              fontFamily: 'Readex Pro',
                              color: Colors.white,
                            ),
                            elevation: 3,
                            borderSide: BorderSide(
                              color: Colors.transparent,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(35),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional(0.00, 0.00),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 5, 10, 10),
                        child: FFButtonWidget(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          text: 'No',
                          options: FFButtonOptions(
                            width: 140,
                            height: 52,
                            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                            iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                            color: Color(0xFF064244),
                            textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                              fontFamily: 'Readex Pro',
                              color: Colors.white,
                            ),
                            elevation: 3,
                            borderSide: BorderSide(
                              color: Colors.transparent,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(35),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
          ),
        );
      },
    );
  }

  void editarPlato(BuildContext context, Plato plato, Function reload) {

    final nombreController = TextEditingController();
    final descripcionController = TextEditingController();
    final precioController = TextEditingController();
    final logoController = TextEditingController();
    int stock = plato.stock;

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              backgroundColor: Color(0xFFC6E8DA),
              content: SingleChildScrollView(
                  child: Container(
                      width: MediaQuery.sizeOf(context).width,
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 16),
                              child: Text(
                                'Actualizar Plato',
                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                  fontFamily: 'Readex Pro',
                                  color: Color(0xFF064244),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                              child: Container(
                                width: double.infinity,
                                child: TextFormField(
                                  controller: nombreController,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelText: plato.nombre,
                                    labelStyle: FlutterFlowTheme.of(context).labelMedium,
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context).alternate,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(35),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFF064244),
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(35),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context).error,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(35),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context).error,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(35),
                                    ),
                                    filled: true,
                                    fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                                    contentPadding:
                                    EdgeInsetsDirectional.fromSTEB(24, 24, 24, 24),
                                    prefixIcon: Icon(
                                      Icons.text_format_rounded,
                                      color: Color(0xFF064244),
                                    ),
                                  ),
                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Readex Pro',
                                    color: Color(0xFF064244),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                              child: Container(
                                width: double.infinity,
                                child: TextFormField(
                                  controller: descripcionController,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelText: plato.descripcion,
                                    labelStyle: FlutterFlowTheme.of(context).labelMedium,
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context).alternate,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(35),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFF064244),
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(35),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context).error,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(35),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context).error,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(35),
                                    ),
                                    filled: true,
                                    fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                                    contentPadding:
                                    EdgeInsetsDirectional.fromSTEB(24, 24, 24, 24),
                                    prefixIcon: Icon(
                                      Icons.short_text_rounded,
                                      color: Color(0xFF064244),
                                    ),
                                  ),
                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Readex Pro',
                                    color: Color(0xFF064244),
                                  ),
                                  keyboardType: TextInputType.multiline,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                              child: Container(
                                width: double.infinity,
                                child: TextFormField(
                                  controller: precioController,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelText: currencyFormat.format(plato.precio),
                                    labelStyle: FlutterFlowTheme.of(context).labelMedium,
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context).alternate,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(35),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFF064244),
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(35),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context).error,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(35),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context).error,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(35),
                                    ),
                                    filled: true,
                                    fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                                    contentPadding:
                                    EdgeInsetsDirectional.fromSTEB(24, 24, 24, 24),
                                    prefixIcon: Icon(
                                      Icons.attach_money_rounded,
                                      color: Color(0xFF064244),
                                    ),
                                  ),
                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Readex Pro',
                                    color: Color(0xFF064244),
                                  ),
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                              child: Container(
                                width: double.infinity,
                                child: TextFormField(
                                  controller: logoController,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelText: plato.imagen,
                                    labelStyle: FlutterFlowTheme.of(context).labelMedium,
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context).alternate,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(35),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFF064244),
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(35),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context).error,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(35),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context).error,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(35),
                                    ),
                                    filled: true,
                                    fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                                    contentPadding:
                                    EdgeInsetsDirectional.fromSTEB(24, 24, 24, 24),
                                    prefixIcon: Icon(
                                      Icons.image_rounded,
                                      color: Color(0xFF064244),
                                    ),
                                  ),
                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Readex Pro',
                                    color: Color(0xFF064244),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: 160,
                              height: 50,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).secondaryBackground,
                                borderRadius: BorderRadius.circular(8),
                                shape: BoxShape.rectangle,
                                border: Border.all(
                                  color: FlutterFlowTheme.of(context).alternate,
                                  width: 2,
                                ),
                              ),
                              child: StatefulBuilder(
                                builder: (BuildContext context, StateSetter setState) {
                                  return FlutterFlowCountController(
                                    decrementIconBuilder: (enabled) => FaIcon(
                                      FontAwesomeIcons.minus,
                                      color: enabled
                                          ? FlutterFlowTheme.of(context).secondaryText
                                          : FlutterFlowTheme.of(context).alternate,
                                      size: 20,
                                    ),
                                    incrementIconBuilder: (enabled) => FaIcon(
                                      FontAwesomeIcons.plus,
                                      color: enabled
                                          ? FlutterFlowTheme.of(context).primary
                                          : FlutterFlowTheme.of(context).alternate,
                                      size: 20,
                                    ),
                                    countBuilder: (count) => Text(
                                      count.toString(),
                                      style: FlutterFlowTheme.of(context).titleLarge,
                                    ),
                                    count: stock,
                                    updateCount: (count) {
                                      if(count >= 0) {
                                        setState(() {
                                          stock = count;
                                        });
                                      }
                                    },
                                    stepSize: 1,
                                  );
                                },
                              ),
                            ),
                            Align(
                              alignment: AlignmentDirectional(0.00, 0.00),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 16),
                                child: FFButtonWidget(
                                  onPressed: () async {
                                    bool actualizo = false;
                                    if(nombreController.text!="") {
                                      if(nombreController.text!=plato.nombre) {
                                        plato.actualizarNombre(nombreController.text);
                                        actualizo = true;
                                      }
                                    }
                                    if(descripcionController.text!="") {
                                      if(descripcionController.text!=plato.descripcion) {
                                        plato.actualizarDescripcion(descripcionController.text);
                                        actualizo = true;
                                      }
                                    }
                                    if(precioController.text!="") {
                                      if(precioController.text!=plato.precio) {
                                        plato.actualizarPrecio(int.parse(precioController.text));
                                        actualizo = true;
                                      }
                                    }
                                    if(logoController.text!="") {
                                      if(precioController.text!=plato.imagen) {
                                        plato.actualizarLogo(precioController.text);
                                        actualizo = true;
                                      }
                                    }
                                    if(stock!=plato.stock){
                                      plato.actualizarStock(stock);
                                      actualizo = true;
                                    }
                                    if(actualizo==true) {
                                      Navigator.of(context).pop();
                                      reload();
                                      accceptMessage(context, "Se ha actualizado correctamente");
                                    } else {
                                      Navigator.of(context).pop();
                                      warningMessage(context, "No hubo cambios");
                                    }
                                  },
                                  text: 'Actualizar',
                                  options: FFButtonOptions(
                                    width: 230,
                                    height: 52,
                                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                    iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                    color: Color(0xFF064244),
                                    textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                      fontFamily: 'Readex Pro',
                                      color: Colors.white,
                                    ),
                                    elevation: 3,
                                    borderSide: BorderSide(
                                      color: Colors.transparent,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(35),
                                  ),
                                ),
                              ),
                            ),
                          ]
                      )
                  )
              )
          );
        }
    );
  }

  /// Additional helper methods are added here.
}
