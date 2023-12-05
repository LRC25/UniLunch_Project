import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:unilunch/logic/Plato.dart';
import 'package:unilunch/logic/Restaurante.dart';

import '../models/restaurants_page_model.dart';
export '../models/restaurants_page_model.dart';

class RestaurantsPageWidget extends StatefulWidget {
  final Restaurante restaurante;
  const RestaurantsPageWidget({Key? key, required this.restaurante})
      : super(key: key);

  @override
  _RestaurantsPageWidgetState createState() => _RestaurantsPageWidgetState();
}

class _RestaurantsPageWidgetState extends State<RestaurantsPageWidget> {
  late RestaurantsPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  bool platosCargados = false;
  bool menuCargado = false;
  late List<Plato> platos = [];
  late List<Plato> menu = [];

  @override
  void initState() {
    _loadMenu();
    _loadPlatos();
    super.initState();
    _model = createModel(context, () => RestaurantsPageModel());

    _model.nameController ??= TextEditingController();
    _model.descriptionController ??= TextEditingController();
    _model.priceController ??= TextEditingController();
    _model.imageController ??= TextEditingController();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  void _loadPlatos() async {
    List<Plato> platosTemp = await widget.restaurante.mostrarMenu();
    setState(() {
      platosCargados = true;
      platos = platosTemp;
    });
  }

  void _loadMenu() async {
    List<Plato> menuTemp = await widget.restaurante.mostrarMenuHoy();
    setState(() {
      menuCargado = true;
      menu = menuTemp;
    });
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
              widget.restaurante.nombreRestaurante,
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
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 8),
                          child: Stack(
                            children: [
                              Align(
                                alignment: AlignmentDirectional(0.00, 0.00),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 8, 0, 0),
                                  child: Text(
                                    'Platos',
                                    textAlign: TextAlign.center,
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Readex Pro',
                                          color: Color(0xFF064244),
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: AlignmentDirectional(1.00, 0.00),
                                child: FlutterFlowIconButton(
                                  borderColor: Color(0x00FFFFFF),
                                  borderRadius: 12,
                                  borderWidth: 1,
                                  buttonSize: 40,
                                  fillColor: Color(0xFF064244),
                                  icon: Icon(
                                    Icons.add_circle_rounded,
                                    color: Color(0xFFE4F4ED),
                                    size: 24,
                                  ),
                                  onPressed: () {
                                    _model.addPlateAlert(context, widget.restaurante);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 8),
                          child: Text(
                            'Estos son los platos que podrás agregar al menú.',
                            textAlign: TextAlign.center,
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Readex Pro',
                                  color: Color(0xFF064244),
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.3,
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: (platosCargados==false)
                                  ? [const Center(child: CircularProgressIndicator(color: Color(0xFF064244)))]
                                  : (platos.isEmpty) ? [Center(child: Text(
                                  "No hay platos agregados",
                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Readex Pro',
                                    color: Color(0xFF064244),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,))
                              )] : platos.map((plato) {
                                return _model.mostrarPlatos(context, plato);
                              }).toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                          child: Text(
                            'Menú de Hoy',
                            textAlign: TextAlign.center,
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Readex Pro',
                                  color: Color(0xFF064244),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                          child: AutoSizeText(
                            'Estos son los platos que tienes a la venta el día de hoy.',
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Readex Pro',
                                  color: Color(0xFF064244),
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.3,
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: (menuCargado==false)
                                  ? [const Center(child: CircularProgressIndicator(color: Color(0xFF064244)))]
                                  : (menu.isEmpty) ? [Center(child: Text(
                                  "No hay platos en el menú",
                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Readex Pro',
                                    color: Color(0xFF064244),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,))
                              )] : menu.map((plato) {
                                return _model.mostrarMenu(context, plato);
                              }).toList(),
                            ),
                          ),
                        ),
                      ],
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
