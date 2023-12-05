import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:unilunch/logic/Carrito.dart';
import 'package:unilunch/presentation/customers/widgets/customers_cart_page_widget.dart';
import '../../../logic/Cliente.dart';
import '../../../logic/Plato.dart';
import '../../../logic/Restaurante.dart';
import '../models/customers_restaurant_menu_model.dart';
import 'navbar_customer_page_widget.dart';
export '../models/customers_restaurant_menu_model.dart';

class CustomerRestaurantMenuWidget extends StatefulWidget {
  final Cliente cliente;
  final Carrito carrito;
  final Restaurante restaurante;
  const CustomerRestaurantMenuWidget({Key? key, required this.cliente,
    required this.carrito, required this.restaurante}) : super(key: key);

  @override
  _CustomerRestaurantMenuWidgetState createState() =>
      _CustomerRestaurantMenuWidgetState();
}

class _CustomerRestaurantMenuWidgetState
    extends State<CustomerRestaurantMenuWidget> {
  late CustomerRestaurantMenuModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  var menuCargado = false;
  late List<Plato> menu = [];

  @override
  void initState() {
    _loadMenu();
    super.initState();
    _model = createModel(context, () => CustomerRestaurantMenuModel());
    _model.actualCarrito = widget.carrito;
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  void _loadMenu() async {
    List<Plato> platosTemp = await widget.restaurante.mostrarMenuHoy();
    setState(() {
      menuCargado = true;
      menu = platosTemp;
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
          title: Stack(
            alignment: AlignmentDirectional(0, 0),
            children: [
              Align(
                alignment: AlignmentDirectional(0.00, 0.00),
                child: Text(
                  'Menú',
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
                        builder:(context) => NavbarCustomerPage(cliente: widget.cliente)));
                  },
                ),
              ),
              Align(
                alignment: AlignmentDirectional(1.00, 0.00),
                child: FlutterFlowIconButton(
                  borderColor: Color(0x00FFFFFF),
                  borderRadius: 20,
                  borderWidth: 1,
                  buttonSize: 40,
                  fillColor: Color(0x00FFFFFF),
                  icon: Icon(
                    Icons.shopping_cart_rounded,
                    color: Color(0xFF064244),
                    size: 24,
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(
                        builder:(context) => CustomerCartPageWidget(cliente: widget.cliente,
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
                                        (widget.restaurante.notaPromedio==0) ? "-" : widget.restaurante.notaPromedio.toString(),
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
                                    Align(
                                      alignment:
                                          AlignmentDirectional(-1.00, 0.00),
                                      child: Text(
                                        widget.restaurante.direccion,
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
                    'Menú',
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
                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: (menuCargado==false)
                        ? [const Center(child: CircularProgressIndicator(color: Color(0xFF064244)))]
                        : (menu.isEmpty) ? [Center(child: Text(
                        "No hay restaurantes",
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
    );
  }
}
