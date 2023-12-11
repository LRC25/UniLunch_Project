import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:unilunch/logic/Carrito.dart';
import 'package:unilunch/logic/Cliente.dart';
import 'package:unilunch/logic/Restaurante.dart';

import '../../../logic/ReservaPlato.dart';
import '../models/customers_cart_page_model.dart';
import 'customers_restaurant_menu_widget.dart';
export '../models/customers_cart_page_model.dart';

class CustomerCartPageWidget extends StatefulWidget {
  final Cliente cliente;
  final Carrito carrito;
  final Restaurante restaurante;
  const CustomerCartPageWidget({Key? key, required this.cliente,
    required this.carrito, required this.restaurante}) : super(key: key);

  @override
  _CustomerCartPageWidgetState createState() => _CustomerCartPageWidgetState();
}

class _CustomerCartPageWidgetState extends State<CustomerCartPageWidget> {
  late CustomerCartPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final currencyFormat = NumberFormat.simpleCurrency(locale: "es_US");

  var platosCargados = false;
  List<ReservaPlato> reservaPlatos = [];

  int suma(List<ReservaPlato> reservaPlatos){
    int suma = 0;
    for(ReservaPlato reservaPlato in reservaPlatos) {
      suma = suma + reservaPlato.cantidad*reservaPlato.plato.precio;
    }
    return suma;
  }

  int total = 0;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CustomerCartPageModel());
    _model.actualCarrito = widget.carrito;
    _loadReservaPlaro();
    _loadTotal();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  void _loadReservaPlaro() {
    setState(() {
      platosCargados = true;
      reservaPlatos = _model.actualCarrito.platos;
    });
  }

  void _loadTotal(){
    setState(() {
      total = suma(_model.actualCarrito.platos);
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
          title: Stack(
            alignment: AlignmentDirectional(0, 0),
            children: [
              Align(
                alignment: AlignmentDirectional(0.00, 0.00),
                child: Text(
                  'Reservación',
                  style: FlutterFlowTheme.of(context).headlineMedium.override(
                        fontFamily: 'Outfit',
                        color: Color(0xFF064244),
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(-1.00, 0.00),
                child: FlutterFlowIconButton(
                  borderColor: Color(0x00FFFFFF),
                  borderRadius: 20,
                  borderWidth: 1,
                  buttonSize: 40,
                  fillColor: Color(0x00FFFFFF),
                  icon: Icon(
                    Icons.arrow_back_rounded,
                    color: Color(0xFF064244),
                    size: 24,
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(
                        builder:(context) => CustomerRestaurantMenuWidget(cliente: widget.cliente,
                          carrito: _model.actualCarrito, restaurante: widget.restaurante,)));
                  },
                ),
              ),
            ],
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
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
                child: Container(
                  width: MediaQuery.sizeOf(context).width,
                  height: 100,
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
                        Expanded(
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: Container(
                                width: MediaQuery.sizeOf(context).width * 0.4,
                                height: MediaQuery.sizeOf(context).height * 1,
                                decoration: BoxDecoration(),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Image.network(
                                    widget.restaurante.imagen,
                                    width:
                                        MediaQuery.sizeOf(context).width * 0.108,
                                    height: 200,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.sizeOf(context).width * 0.65,
                          height: 100,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                          ),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Expanded(
                                      child: Align(
                                        alignment:
                                            AlignmentDirectional(-1.00, 0.00),
                                        child: Text(
                                          widget.restaurante.nombreRestaurante,
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Readex Pro',
                                                color: Color(0xFF064244),
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                          maxLines: 2,
                                        ),
                                      ),
                                    ),
                                    Icon(
                                      Icons.star_rounded,
                                      color: Color(0xFFFF7A00),
                                      size: 24,
                                    ),
                                    Align(
                                      alignment:
                                          AlignmentDirectional(-1.00, 0.00),
                                      child: Text(
                                        widget.restaurante.notaPromedio.toString(),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Readex Pro',
                                              color: Color(0xFFFF7A00),
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  widget.restaurante.descripcion,
                                  textAlign: TextAlign.justify,
                                  maxLines: 2,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        color: Color(0xFF064244),
                                      ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Flexible(
                                      child: Align(
                                        alignment:
                                            AlignmentDirectional(-1.00, 0.00),
                                        child: Text(
                                          widget.restaurante.direccion,
                                          overflow: TextOverflow.ellipsis,
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Readex Pro',
                                                color: Color(0xFF064244),
                                                fontSize: 16,
                                                fontWeight: FontWeight.w300,
                                              ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                  child: Text(
                    'Platos a Reservar',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Readex Pro',
                          color: Color(0xFF064244),
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: (platosCargados==false)
                        ? [const Center(child: CircularProgressIndicator(color: Color(0xFF064244)))]
                        : (reservaPlatos.isEmpty) ? [Center(child: Text(
                        "No hay platos",
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Readex Pro',
                          color: Color(0xFF064244),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,))
                    )] : reservaPlatos.map((reservaPlato) {
                      return _model.mostrarPlatosReserva(context, reservaPlato, _loadTotal, reservaPlatos);
                    }).toList(),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                child: Text(
                  currencyFormat.format(total),
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Readex Pro',
                        color: Color(0xFF138D20),
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                  child: Text(
                    'Datos de Reserva',
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
                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                  child: Text(
                    'Tú reserva es para hoy.',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Readex Pro',
                          color: Color(0xFF064244),
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                child: FFButtonWidget(
                  onPressed: () async {
                    final _datePickedTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.fromDateTime(getCurrentTimestamp),
                    );
                    if (_datePickedTime != null) {
                      safeSetState(() {
                        _model.datePicked = DateTime(
                          getCurrentTimestamp.year,
                          getCurrentTimestamp.month,
                          getCurrentTimestamp.day,
                          _datePickedTime.hour,
                          _datePickedTime.minute,
                        );
                      });
                    }
                  },
                  text: 'Hora',
                  icon: Icon(
                    Icons.access_time_filled_rounded,
                    size: 15,
                  ),
                  options: FFButtonOptions(
                    width: MediaQuery.sizeOf(context).width * 0.6,
                    height: 52,
                    padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                    iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                    color: Color(0x00FFFFFF),
                    textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                          fontFamily: 'Readex Pro',
                          color: Color(0xFF064244),
                          fontWeight: FontWeight.normal,
                        ),
                    elevation: 0,
                    borderSide: BorderSide(
                      color: FlutterFlowTheme.of(context).alternate,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(35),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                child: FFButtonWidget(
                  onPressed: () {
                    _model.crearReserva(context, total);
                  },
                  text: 'Crear Reserva',
                  options: FFButtonOptions(
                    width: MediaQuery.sizeOf(context).width * 0.6,
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
            ],
          ),
        ),
      ),
    );
  }
}
