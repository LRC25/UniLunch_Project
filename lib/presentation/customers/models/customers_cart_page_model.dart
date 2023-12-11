import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:unilunch/alerts.dart';
import 'package:unilunch/logic/Carrito.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:unilunch/logic/ReservaPlato.dart';
import '../widgets/customers_cart_page_widget.dart' show CustomerCartPageWidget;
import 'package:flutter/material.dart';

class CustomerCartPageModel extends FlutterFlowModel<CustomerCartPageWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  DateTime? datePicked;
  
  final currencyFormat = NumberFormat.simpleCurrency(locale: "es_US");
  Carrito actualCarrito = Carrito.vacio();

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
  }

  void dispose() {
    unfocusNode.dispose();
  }

  /// Action blocks are added here.

  Padding mostrarPlatosReserva(BuildContext context, ReservaPlato reservaPlato,
    Function _loadTotal, List<ReservaPlato> reservas) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 5),
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
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(
                      0, 0, 5, 0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment:
                    MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Text(
                          reservaPlato.plato.nombre,
                          maxLines: 2,
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
                      Text(
                        currencyFormat.format(reservaPlato.plato.precio),
                        textAlign: TextAlign.start,
                        maxLines: 1,
                        style: FlutterFlowTheme.of(context)
                            .bodyMedium
                            .override(
                          fontFamily: 'Readex Pro',
                          color:
                          FlutterFlowTheme.of(context)
                              .secondaryText,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      Text(
                        currencyFormat.format(reservaPlato.cantidad*reservaPlato.plato.precio),
                        textAlign: TextAlign.start,
                        maxLines: 1,
                        style: FlutterFlowTheme.of(context)
                            .bodyMedium
                            .override(
                          fontFamily: 'Readex Pro',
                          color: Color(0xFF138D20),
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(
                  5, 0, 10, 0),
                child: Container(
                  width: 120,
                  height: 40,
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
                        count: reservaPlato.cantidad,
                        updateCount: (count) {
                          if(count >= 1) {
                            setState(() {
                              reservaPlato.cantidad = count;
                              _loadTotal();
                            });
                          }
                        },
                        stepSize: 1,
                      );
                    },
                  ),
                ),
              ),
              Stack(
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(
                        0, 0, 5, 0),
                    child: Container(
                      width: MediaQuery.sizeOf(context).width *
                          0.25,
                      height:
                      MediaQuery.sizeOf(context).height * 1,
                      decoration: BoxDecoration(),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.network(
                          reservaPlato.plato.imagen,
                          width:
                          MediaQuery.sizeOf(context).width,
                          height: MediaQuery.sizeOf(context)
                              .height *
                              1,
                          fit: BoxFit.cover,
                        ),
                      ),
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
                        reservas.remove(reservaPlato);
                        _loadTotal();
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  crearReserva(BuildContext context, int total) async {
    if(actualCarrito.platos.isNotEmpty) {
      if(datePicked!=null) {
        bool cantidadInsuficiente = false;
        for(ReservaPlato carrito in actualCarrito.platos) {
          if(carrito.cantidad>carrito.plato.stock){
            cantidadInsuficiente = true;
          }
        }
        if(cantidadInsuficiente==false) {
          DateTime fecha = DateTime.now();
          String response = await widget.cliente.hacerReservar(fecha, datePicked!, total, actualCarrito.platos, widget.restaurante.idRestaurante);
          if (response=="correcto") {
            accceptMessageReserva(context, "Se ha agredo correctanemte", widget.cliente);
          } else {
            errorMessage(context, "ha ocurrido un error");
          }
        } else {
          warningMessage(context, "Algunos platos no tienen la suficiente cantidad");
        }
      } else {
        warningMessage(context, "Por favor agregar la hora de la reserva");
      }
    } else {
      warningMessage(context, "No hay platos en la reserva");
    }
  }

  /// Additional helper methods are added here.
}
