import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import '../../../logic/Restaurante.dart';
import '../../../logic/Plato.dart';

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

  late List<Plato> platos = [];

  @override
  void initState() {
    _loadMenu();
    super.initState();
    _model = createModel(context, () => RestaurantsPageModel());
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  void _loadMenu() async {
    List<Plato> platosTemp = await widget.restaurante.mostrarMenu();
    setState(() {
      platos = platosTemp;
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
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
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
            child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                child: Container(
                  width: MediaQuery.sizeOf(context).width,
                  height: MediaQuery.sizeOf(context).height * 1,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: (platos.isEmpty) ? [Center(child: CircularProgressIndicator())] : platos.map((plato) {
                      return _model.mostrarMenu(context, plato);
                    }).toList(),
                  ),
                )),
          ),
        )
    );
  }
}