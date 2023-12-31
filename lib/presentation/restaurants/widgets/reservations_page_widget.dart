import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:unilunch/logic/Reserva.dart';
import '../../../logic/Restaurante.dart';

import '../models/reservations_page_model.dart';
export '../widgets/reservations_page_widget.dart';

class RestaurantReservationsPageWidget extends StatefulWidget {
  final Restaurante restaurante;
  const RestaurantReservationsPageWidget({Key? key, required this.restaurante}) : super(key: key);

  @override
  _RestaurantReservationsPageWidgetState createState() =>
      _RestaurantReservationsPageWidgetState();
}

class _RestaurantReservationsPageWidgetState
    extends State<RestaurantReservationsPageWidget> {
  late RestaurantReservationsPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  var reservaCargada = false;
  late List<Reserva> reservas = [];
  late List<Reserva> reservasCompletas = [];

  @override
  void initState() {
    _loadReservas();
    super.initState();
    _model = createModel(context, () => RestaurantReservationsPageModel());
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  void _loadReservas() async {
    List<Reserva> reservasTemp = await widget.restaurante.monitorearReserva();
    List<Reserva> reservasComTemp = await widget.restaurante.monitorearReservaCompleta();
    setState(() {
      reservaCargada = true;
      reservas = reservasTemp;
      reservasCompletas = reservasComTemp;
    });
  }

  void reload(){
    setState(() {
      reservaCargada=false;
      _loadReservas();
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
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Color(0xFFC6E8DA),
          automaticallyImplyLeading: false,
          title: Align(
            alignment: AlignmentDirectional(0.00, 0.00),
            child: Text(
              'Reservas',
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
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Flexible(
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                    child: Text(
                      'Reservas Pendientes',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Readex Pro',
                            color: Color(0xFF064244),
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: (reservaCargada==false)
                          ? [const Center(child: CircularProgressIndicator(color: Color(0xFF064244)))]
                          : (reservas.isEmpty) ? [Center(child: Text(
                          "No hay reservas pendientes",
                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Readex Pro',
                            color: Color(0xFF064244),
                            fontSize: 16,
                            fontWeight: FontWeight.w400,))
                      )] : reservas.map((reserva) {
                        return _model.mostrarReservas(context, reserva, reload);
                      }).toList(),
                    ),
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                    child: Text(
                      'Reservas Completadas',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Readex Pro',
                        color: Color(0xFF064244),
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: (reservaCargada==false)
                          ? [const Center(child: CircularProgressIndicator(color: Color(0xFF064244)))]
                          : (reservasCompletas.isEmpty) ? [Center(child: Text(
                          "No hay reservas",
                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Readex Pro',
                            color: Color(0xFF064244),
                            fontSize: 16,
                            fontWeight: FontWeight.w400,))
                      )] : reservasCompletas.map((reserva) {
                        return _model.mostrarReservas(context, reserva, reload);
                      }).toList(),
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