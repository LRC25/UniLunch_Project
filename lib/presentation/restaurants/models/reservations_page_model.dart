import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:unilunch/logic/Reserva.dart';
import 'package:unilunch/logic/ReservaPlato.dart';
import '../widgets/reservations_page_widget.dart' show RestaurantReservationsPageWidget;
import 'package:flutter/material.dart';

class RestaurantReservationsPageModel
    extends FlutterFlowModel<RestaurantReservationsPageWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();

  final currencyFormat = NumberFormat.simpleCurrency(locale: "es_US");

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {
    unfocusNode.dispose();
  }

  /// Action blocks are added here.

  Center mostrarReservas(BuildContext context, Reserva reserva) {
    int cantidad = 0;
    for (ReservaPlato plato in reserva.platos) {
      cantidad = cantidad + plato.cantidad;
    }

    return Center(
      child: GestureDetector(
        onTap: () {
          //detallesReservaPendiente(context, reserva);
        },
        child: Flexible(
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 5),
            child: Container(
              width: MediaQuery.sizeOf(context).width,
              height: 80,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context)
                    .secondaryBackground,
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
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Align(
                    alignment: AlignmentDirectional(0.00, 0.00),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          15, 0, 15, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment:
                        MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.account_circle,
                            color: Color(0xFF064244),
                            size: 32,
                          ),
                          Icon(
                            Icons.access_time,
                            color: Color(0xFF064244),
                            size: 32,
                          ),
                        ].divide(SizedBox(height: 5)),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Align(
                      alignment: AlignmentDirectional(0.00, 0.00),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            20, 0, 20, 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment:
                          MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Text(
                              reserva.nombreUsuario,
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                fontFamily: 'Readex Pro',
                                color: Color(0xFF064244),
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  '$cantidad platos - ',
                                  style: FlutterFlowTheme.of(
                                      context)
                                      .bodyMedium
                                      .override(
                                    fontFamily: 'Readex Pro',
                                    color: Color(0xFF064244),
                                    fontSize: 15,
                                  ),
                                ),
                                estodoReserva(context, reserva)
                              ],
                            ),
                            Text(
                              DateFormat('yyyy-MM-dd HH:mm').format(reserva.fecha),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                fontFamily: 'Readex Pro',
                                color: Color(0xFF064244),
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                fontStyle: FontStyle.italic,
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
        ),
      ),
    );
  }

  Text estodoReserva(BuildContext context, Reserva reserva) {
    if (reserva.estado=="Cancelado") {
      return Text(
        "Cancelado",
        style: FlutterFlowTheme.of(context).bodyMedium
            .override(
          fontFamily: 'Readex Pro',
          color: Colors.red,
        ),
      );
    } else {
      return Text(
        currencyFormat.format(reserva.total),
        style: FlutterFlowTheme.of(context).bodyMedium
        .override(
          fontFamily: 'Readex Pro',
          color: Color(0xFF29A814),
        ),
      );
    }
  }

  void detallesReservaPendiente(BuildContext context, Reserva reserva) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
              child: Text(
                'Reserva',
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                  fontFamily: 'Readex Pro',
                  color: Color(0xFF064244),
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
          ),
          backgroundColor: Color(0xFFC6E8DA),
          content: ListBody(
            children: [

            ],
          ),
        );
      },
    );
  }

  /// Additional helper methods are added here.
}