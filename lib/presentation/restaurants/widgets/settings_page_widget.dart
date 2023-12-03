import 'package:flutterflow_ui/flutterflow_ui.dart';
<<<<<<< Updated upstream
=======
import '../../../logic/Restaurante.dart';
import '../../../logic/Usuario.dart';
>>>>>>> Stashed changes

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  }

  @override
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
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
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
<<<<<<< Updated upstream
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Container(
                  width: MediaQuery.sizeOf(context).width,
                  height: MediaQuery.sizeOf(context).height * 1,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                    shape: BoxShape.rectangle,
=======
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
                                updateMessage(context, "Nombre", widget.restaurante.nombre);
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
                              updateMessage(context, "Nombre del restaurante", widget.restaurante.nombreRestaurante);
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

                              updateMessage(context, "Descripción", widget.restaurante.descripcion);
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
                              updateMessage(context, "Dirección", widget.restaurante.direccion);
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
                            onPressed: () {
                              print('IconButton pressed ...');
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
                            onPressed: () {
                              print('IconButton pressed ...');
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
                              print('IconButton pressed ...');
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
                              print('IconButton pressed ...');
                            },
                          ),
                        ],
                      ),
                    ],
>>>>>>> Stashed changes
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
