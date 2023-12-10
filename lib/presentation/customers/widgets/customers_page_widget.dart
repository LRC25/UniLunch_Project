import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as google_maps;
import 'package:unilunch/logic/BuscarPorDefecto.dart';
import 'package:unilunch/logic/BuscarPorNombre.dart';
import 'package:unilunch/logic/Cliente.dart';
import 'package:unilunch/logic/Restaurante.dart';

import '../models/customers_page_model.dart';
export '../models/customers_page_model.dart';

class CustomersPageWidget extends StatefulWidget {
  final Cliente cliente;
  const CustomersPageWidget({Key? key, required this.cliente})
      : super(key: key);

  @override
  _CustomersPageWidgetState createState() => _CustomersPageWidgetState();
}

class _CustomersPageWidgetState extends State<CustomersPageWidget> {
  late CustomersPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  var listaCargada = false;
  late List<Restaurante> restaurantes = [];

  @override
  void initState() {
    _loadRestaurantes();
    super.initState();
    _model = createModel(context, () => CustomersPageModel());

    _model.searchRestaurantController ??= TextEditingController();
    _model.searchRestaurantFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  void _loadRestaurantes() async {
    widget.cliente.setBuscarRestaurante(BuscarPorDefecto());
    List<Restaurante> restauranteTemp = await widget.cliente.applyBuscarRestaurante("");
    setState(() {
      listaCargada = true;
      restaurantes = restauranteTemp;
    });

    for (var restaurante in restaurantes) {
      // ignore: use_build_context_synchronously
      _model.addMarker(context, restaurante);
    }
  }

  void _loadFilteredRestaurantes() async {
    listaCargada = false;
    //TODO: clear Markers
    _model.clearMarkers(context);
    widget.cliente.setBuscarRestaurante(BuscarPorNombre());
    List<Restaurante> restauranteTemp = await widget.cliente.applyBuscarRestaurante(_model.searchRestaurantController.text);
    setState(() {
      listaCargada = true;
      restaurantes = restauranteTemp;
    });

    for (var restaurante in restaurantes) {
      // ignore: use_build_context_synchronously
      _model.addMarker(context, restaurante);
    }
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
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        appBar: AppBar(
          backgroundColor: Color(0xFFC6E8DA),
          automaticallyImplyLeading: false,
          title: Align(
            alignment: AlignmentDirectional(0.00, 0.00),
            child: Text(
              'Restaurantes',
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: MediaQuery.sizeOf(context).width,
                height: MediaQuery.sizeOf(context).height * 0.3,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                  shape: BoxShape.rectangle,
                ),
                child: google_maps.GoogleMap(
                  myLocationButtonEnabled: false,
                  zoomControlsEnabled: true,
                  initialCameraPosition: CustomersPageModel.initialCameraPosition,
                  markers: Set<google_maps.Marker>.from(_model.markers)
                )
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 8, 16, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.sizeOf(context).width*0.6,
                      child: TextFormField(
                        controller: _model.searchRestaurantController,
                        focusNode: _model.searchRestaurantFocusNode,
                        autofillHints: [AutofillHints.email],
                        obscureText: false,
                        decoration: InputDecoration(
                          labelText: 'Nombre de Restaurante...',
                          labelStyle:
                              FlutterFlowTheme.of(context).labelMedium.override(
                                    fontFamily: 'Readex Pro',
                                    color: Color(0xFF064244),
                                  ),
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
                          fillColor:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          contentPadding:
                              EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
                          prefixIcon: Icon(
                            Icons.sort,
                            color: Color(0xFF064244),
                          ),
                        ),
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Readex Pro',
                              color: Color(0xFF064244),
                            ),
                        keyboardType: TextInputType.emailAddress,
                        validator: _model.searchRestaurantControllerValidator
                            .asValidator(context),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width * 0.3,
                      child: FFButtonWidget(
                        onPressed: () {
                          _loadFilteredRestaurantes();
                        },
                        text: 'Buscar',
                        icon: Icon(
                          Icons.search_rounded,
                          size: 20,
                        ),
                        options: FFButtonOptions(
                          width: 230,
                          height: 52,
                          padding:
                              EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                          iconPadding:
                              EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                          color: Color(0xFF064244),
                          textStyle: FlutterFlowTheme.of(context)
                              .titleSmall
                              .override(
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
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                child: Container(
                  height: MediaQuery.sizeOf(context).height * 0.38,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: (listaCargada==false)
                          ? [const Center(child: CircularProgressIndicator(color: Color(0xFF064244)))]
                          : (restaurantes.isEmpty) ? [Center(child: Text(
                          "No hay restaurantes.",
                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Readex Pro',
                            color: Color(0xFF064244),
                            fontSize: 16,
                            fontWeight: FontWeight.w400,))
                      )] : restaurantes.map((restaurante) {
                        return _model.listaRestaurantes(context, restaurante);
                      }).toList(),
                    ),
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
