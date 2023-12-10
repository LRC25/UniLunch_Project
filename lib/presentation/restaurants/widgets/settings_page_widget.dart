import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:unilunch/presentation/common/widgets/login_page_widget.dart';
import 'package:unilunch/presentation/restaurants/email_form.dart';
import 'package:unilunch/presentation/restaurants/password_form.dart';
import '../../../logic/Restaurante.dart';


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../alerts.dart';

import '../models/settings_page_model.dart';
export '../models/settings_page_model.dart';

class RestaurantSettingsPageWidget extends StatefulWidget {
  final Restaurante restaurante;
  const RestaurantSettingsPageWidget({Key? key, required this.restaurante}) : super(key: key);

  @override
  _RestaurantSettingsPageWidgetState createState() =>
      _RestaurantSettingsPageWidgetState();
}

class _RestaurantSettingsPageWidgetState
    extends State<RestaurantSettingsPageWidget> {
  late RestaurantSettingsPageModel _model;


  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => RestaurantSettingsPageModel());

  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }  @override
  Widget build(BuildContext context) {
    if (isiOS) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarBrightness: Theme.of(context).brightness,
          systemStatusBarContrastEnforced: true,
        ),
      );
    }

    return GestureDetector(

      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).info,
        appBar: AppBar(
          backgroundColor: Color(0xFFC6E8DA),
          automaticallyImplyLeading: false,
          title: Align(
            alignment: AlignmentDirectional(0.00, 0.00),
            child: Text(
              'Opciones',
              style: FlutterFlowTheme.of(context).headlineMedium.override(
                fontFamily: 'Outfit',
                color: Color(0xFF064244),
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          actions: [],
          centerTitle: false,
          elevation: 2,
        ),
        body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(32, 16, 32, 0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                        child: Text(
                          'Información personal',
                          textAlign: TextAlign.center,
                          style: FlutterFlowTheme.of(context)
                              .headlineMedium
                              .override(
                            fontFamily: 'Outfit',
                            color: Color(0xFF074345),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 32),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding:
                              EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                              child: Icon(
                                Icons.account_circle_rounded,
                                color: Color(0xFF064244),
                                size: 35,
                              ),
                            ),
                            Text(
                              'Nombre',
                              textAlign: TextAlign.center,
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                fontFamily: 'Readex Pro',
                                color: Color(0xFF064244),
                                fontSize: 15,
                              ),
                            ),
                            FlutterFlowIconButton(
                              borderColor: Colors.white,
                              borderRadius: 0,
                              borderWidth: 0,
                              buttonSize: 50,
                              fillColor: Colors.white,
                              icon: Icon(
                                Icons.edit_square,
                                color: Color(0xFFFF7A00),
                                size: 35,
                              ),
                              onPressed: () {
                                updateMessage(context, "Nombre", widget.restaurante.nombre,  widget.restaurante.idUsuario, widget.restaurante.tipoUsuario);

                              },
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                        child: Text(
                          'Información restaurante',
                          style:
                          FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Readex Pro',
                            color: Color(0xFF074345),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding:
                            EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                            child: Icon(
                              Icons.format_underline,
                              color: Color(0xFF064244),
                              size: 35,
                            ),
                          ),
                          Text(
                            'Nombre Restaurante',
                            textAlign: TextAlign.start,
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                              fontFamily: 'Readex Pro',
                              color: Color(0xFF064244),
                              fontSize: 15,
                            ),
                          ),
                          FlutterFlowIconButton(
                            borderColor: Colors.white,
                            borderRadius: 0,
                            borderWidth: 0,
                            buttonSize: 50,
                            fillColor: Colors.white,
                            icon: Icon(
                              Icons.edit_square,
                              color: Color(0xFFFF7A00),
                              size: 35,
                            ),
                            onPressed: () {

                              updateMessage(context,  "Nombre del restaurante", widget.restaurante.nombreRestaurante,  widget.restaurante.idRestaurante, widget.restaurante.tipoUsuario);

                            },
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding:
                            EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                            child: Icon(
                              Icons.sort_outlined,
                              color: Color(0xFF064244),
                              size: 35,
                            ),
                          ),
                          Text(
                            'Descripción',
                            textAlign: TextAlign.start,
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                              fontFamily: 'Readex Pro',
                              color: Color(0xFF064244),
                              fontSize: 15,
                            ),
                          ),
                          FlutterFlowIconButton(
                            borderColor: Colors.white,
                            borderRadius: 0,
                            borderWidth: 0,
                            buttonSize: 50,
                            fillColor: Colors.white,
                            icon: Icon(
                              Icons.edit_square,
                              color: Color(0xFFFF7A00),
                              size: 35,
                            ),
                            onPressed: () async {

                              updateMessage(context, "Descripción", widget.restaurante.descripcion, widget.restaurante.idRestaurante, widget.restaurante.tipoUsuario);

                            },
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding:
                            EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                            child: Icon(
                              Icons.place,
                              color: Color(0xFF064244),
                              size: 35,
                            ),
                          ),
                          Text(
                            'Dirección',
                            textAlign: TextAlign.center,
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                              fontFamily: 'Readex Pro',
                              color: Color(0xFF064244),
                              fontSize: 15,
                            ),
                          ),
                          FlutterFlowIconButton(
                            borderColor: Colors.white,
                            borderRadius: 0,
                            borderWidth: 0,
                            buttonSize: 50,
                            fillColor: Colors.white,
                            icon: Icon(
                              Icons.edit_square,
                              color: Color(0xFFFF7A00),
                              size: 35,
                            ),
                            onPressed: () {


                              //updateMessagee(context, "Dirección", widget.restaurante.direccion,  widget.restaurante.idRestaurante);

                            },
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding:
                            EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                            child: Icon(
                              Icons.access_time_outlined,
                              color: Color(0xFF064244),
                              size: 35,
                            ),
                          ),
                          Text(
                            'Hora de apertura',
                            textAlign: TextAlign.center,
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                              fontFamily: 'Readex Pro',
                              color: Color(0xFF064244),
                              fontSize: 15,
                            ),
                          ),
                          FlutterFlowIconButton(
                            borderColor: Colors.white,
                            borderRadius: 0,
                            borderWidth: 0,
                            buttonSize: 50,
                            fillColor: Colors.white,
                            icon: Icon(
                              Icons.edit_square,
                              color: Color(0xFFFF7A00),
                              size: 35,
                            ),
                            onPressed: () async {
                              final _openingTime = await showTimePicker(
                                context: context,
                                helpText: "Actualizar hora de apertura",
                                confirmText: "Actualizar",
                                cancelText: "Cancelar",
                                initialTime:  TimeOfDay(hour:widget.restaurante.horaApertura.hour, minute:widget.restaurante.horaApertura.minute),
                              );
                              if (_openingTime != null) {
                                var horaApertura = DateTime(0);
                                safeSetState(() {
                                  horaApertura = DateTime(
                                    getCurrentTimestamp.year,
                                    getCurrentTimestamp.month,
                                    getCurrentTimestamp.day,
                                    _openingTime.hour,
                                    _openingTime.minute,
                                  );

                                  final formattedTime = '${_openingTime.format(context)}';
                                  Restaurante.actualizarHoraApertura( horaApertura, widget.restaurante.idRestaurante);
                                  debugPrint(formattedTime);
                                  var time = formattedTime;
                                });
                              }
                            },


                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding:
                            EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                            child: Icon(
                              Icons.timer_off_outlined,
                              color: Color(0xFF064244),
                              size: 35,
                            ),
                          ),
                          Text(
                            'Hora de cierre',
                            textAlign: TextAlign.center,
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                              fontFamily: 'Readex Pro',
                              color: Color(0xFF064244),
                              fontSize: 15,
                            ),
                          ),
                          FlutterFlowIconButton(
                            borderColor: Colors.white,
                            borderRadius: 0,
                            borderWidth: 0,
                            buttonSize: 50,
                            fillColor: Colors.white,
                            icon: Icon(
                              Icons.edit_square,
                              color: Color(0xFFFF7A00),
                              size: 35,
                            ),
                            onPressed:  () async {
                              final _closingTime = await showTimePicker(
                                context: context,
                                helpText: "Actualizar hora de cierre",
                                confirmText: "Actualizar",
                                cancelText: "Cancelar",
                                initialTime:  TimeOfDay(hour:widget.restaurante.horaCierre.hour, minute:widget.restaurante.horaCierre.minute),
                              );
                              if (_closingTime != null) {
                                var horaCierre = DateTime(0);
                                safeSetState(() {
                                  horaCierre = DateTime(
                                    getCurrentTimestamp.year,
                                    getCurrentTimestamp.month,
                                    getCurrentTimestamp.day,
                                    _closingTime.hour,
                                    _closingTime.minute,
                                  );

                                  final formattedTime = '${_closingTime.format(context)}';
                                  Restaurante.actualizarHoraCierre( horaCierre, widget.restaurante.idRestaurante);
                                  debugPrint(formattedTime);
                                  var time = formattedTime;
                                });
                              }
                            },
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 16),
                        child: Text(
                          'Seguridad',
                          style: FlutterFlowTheme.of(context)
                              .headlineMedium
                              .override(
                            fontFamily: 'Outfit',
                            color: Color(0xFF064244),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding:
                            EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                            child: Icon(
                              Icons.email,
                              color: Color(0xFF064244),
                              size: 35,
                            ),
                          ),
                          Text(
                            'Email',
                            textAlign: TextAlign.center,
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                              fontFamily: 'Readex Pro',
                              color: Color(0xFF064244),
                              fontSize: 15,
                            ),
                          ),
                          FlutterFlowIconButton(
                            borderColor: Colors.white,
                            borderRadius: 0,
                            borderWidth: 0,
                            buttonSize: 50,
                            fillColor: Colors.white,
                            icon: Icon(
                              Icons.edit_square,
                              color: Color(0xFFFF7A00),
                              size: 35,
                            ),

                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      backgroundColor: Color(0xFFC6E8DA),
                                      title: const Text(
                                        "Su correo electrónico es:",
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      content: SingleChildScrollView(
                                        child: ListBody(
                                          children: [
                                            Text(
                                              widget.restaurante.email,
                                              style: const TextStyle(
                                                fontSize: 15,
                                                color: Color(0xFF064244),

                                              ),
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            ExpansionTile(
                                              leading: const CircleAvatar(
                                                backgroundColor: Color(0xFF064244),
                                                child: Icon(
                                                  color: Colors.white,
                                                  Icons.edit,
                                                  size: 20,
                                                ),
                                              ),
                                              title: const Text(
                                                "Actualizar correo:",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.green,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                              // Contents
                                              children: [
                                                FormEmail(
                                                  restaurante: widget.restaurante,
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                            },

                            //onPressed: () {


                             // updateMessage(context, "Email", widget.restaurante.email,  widget.restaurante.idRestaurante);
                            //},
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding:
                            EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                            child: Icon(
                              Icons.vpn_key_rounded,
                              color: Color(0xFF064244),
                              size: 35,
                            ),
                          ),
                          Text(
                            'Contraseña',
                            textAlign: TextAlign.center,
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                              fontFamily: 'Readex Pro',
                              color: Color(0xFF064244),
                            ),
                          ),
                          FlutterFlowIconButton(
                            borderColor: Colors.white,
                            borderRadius: 0,
                            borderWidth: 0,
                            buttonSize: 50,
                            fillColor: Colors.white,
                            icon: Icon(
                              Icons.edit_square,
                              color: Color(0xFFFF7A00),
                              size: 35,
                            ),
                            onPressed: () {
                              showDialog(

                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      backgroundColor: Color(0xFFC6E8DA),
                                      content: SingleChildScrollView(
                                        child: ListBody(
                                          children: [
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            ExpansionTile(
                                              leading: const CircleAvatar(

                                                backgroundColor: Color(0xFF064244),
                                                child: Icon(
                                                  color: Colors.white,
                                                  Icons.edit,
                                                  size: 20,
                                                ),
                                              ),
                                              title: const Text(
                                                "Cambiar contraseña:",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.green,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                              // Contents
                                              children: [
                                                FormPassword(
                                                  restaurante: widget.restaurante,
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 16),
                  child: FFButtonWidget(
                    onPressed: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(
                          builder:(context) => LoginPageWidget()));
                    },
                    text: 'Cerrar Sesión',
                    options: FFButtonOptions(
                      width: 230,
                      height: 52,
                      padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                      iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                      color: Color(0xFFE72828),
                      textStyle:
                      FlutterFlowTheme.of(context).titleSmall.override(
                        fontFamily: 'Readex Pro',
                        color: Colors.white,
                        fontSize: 20,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}