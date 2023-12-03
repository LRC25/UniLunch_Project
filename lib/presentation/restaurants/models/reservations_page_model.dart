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

  Padding mostrarReservas(BuildContext context, Reserva reserva) {
    int cantidad = 0;
    for (ReservaPlato plato in reserva.platos) {
      cantidad = cantidad + plato.cantidad;
    }

    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 5),
      child: Container(
        width: MediaQuery.sizeOf(context).width,
        height: 80,
        decoration: BoxDecoration(
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
        child: Material(
          borderRadius: BorderRadius.circular(15),
          color: FlutterFlowTheme.of(context).secondaryBackground,
          child: InkWell(
            // splashColor: Colors.transparent,
            // focusColor: Colors.transparent,
            // hoverColor: Colors.transparent,
            // highlightColor: Colors.transparent,
            onTap: () async {
              detallesReservaPendiente(context, reserva);
            },
            child: Container(
              width: MediaQuery.sizeOf(context).width,
              height: 80,
              color: Colors.transparent,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Align(
                    alignment: AlignmentDirectional(0.00, 0.00),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
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
                        padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              reserva.nombreUsuario,
                              style: FlutterFlowTheme.of(context).bodyMedium.override(
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
                                  style: FlutterFlowTheme.of(context)
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
                              style: FlutterFlowTheme.of(context).bodyMedium.override(
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
          content: Column(
            children: [
              Flexible(
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 15),
                  child: Text(
                    'Detalles de Reserva',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'Readex Pro',
                      color: Color(0xFF064244),
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Align(
                    alignment: AlignmentDirectional(0.00, 0.00),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(50, 0, 15, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
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
                        padding: EdgeInsetsDirectional.fromSTEB(10, 0, 50, 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              reserva.nombreUsuario,
                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                fontFamily: 'Readex Pro',
                                color: Color(0xFF064244),
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              DateFormat('yyyy-MM-dd HH:mm').format(reserva.fecha),
                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                fontFamily: 'Readex Pro',
                                color: Color(0xFF064244),
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ].divide(SizedBox(height: 15)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 15, 0, 10),
                child: Text(
                  'Platos Reservados',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: 'Readex Pro',
                    color: Color(0xFF064244),
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: (reserva.platos.isEmpty) ? [Center(child: CircularProgressIndicator())] : reserva.platos.map((reservaPlato) {
                    return listaPlato(context, reservaPlato);
                  }).toList(),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 5),
                child: Text(
                  'Total: ${currencyFormat.format(reserva.total)}',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: 'Readex Pro',
                    color: Color(0xFF138D20),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0.00, 0.00),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                  child: FFButtonWidget(
                    onPressed: () async {
                      String respuesta = await reserva.completarReserva();
                      if(respuesta=="Correto") {
                        debugPrint("Correcto");
                      } else {
                        debugPrint("Correcto");
                      }
                    },
                    text: 'Completar Reserva',
                    options: FFButtonOptions(
                      width: 258,
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
              ),
            ],
          ),
        );
      },
    );
  }

  Padding listaPlato (BuildContext context, ReservaPlato reservaPlato) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
      child: Container(
        width: MediaQuery.sizeOf(context).width * 0.9,
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
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.sizeOf(context).width * 0.50,
                height: 100,
                decoration: BoxDecoration(
                  color:
                  FlutterFlowTheme.of(context).secondaryBackground,
                ),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: AlignmentDirectional(-1.00, 0.00),
                        child: Text(
                          reservaPlato.plato.nombre,
                          style: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .override(
                            fontFamily: 'Readex Pro',
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(-1.00, 0.00),
                        child: Text(
                          '${currencyFormat.format(reservaPlato.plato.precio)} c/u',
                          style: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .override(
                            fontFamily: 'Readex Pro',
                            fontSize: 15,
                            fontWeight: FontWeight.w200,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Align(
                            alignment:
                            AlignmentDirectional(-1.00, 0.00),
                            child: Text(
                              currencyFormat.format(reservaPlato.plato.precio*reservaPlato.cantidad),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                fontFamily: 'Readex Pro',
                                color: Color(0xFF138D20),
                                fontSize: 15,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                          Flexible(
                            child: Align(
                              alignment:
                              AlignmentDirectional(1.00, 0.00),
                              child: Text(
                                'Cantidad: ${reservaPlato.cantidad}',
                                textAlign: TextAlign.start,
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                  fontFamily: 'Readex Pro',
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
              Expanded(
                child: Container(
                  width: MediaQuery.sizeOf(context).width * 0.3,
                  height: 100,
                  decoration: BoxDecoration(),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      reservaPlato.plato.imagen,
                      width: MediaQuery.sizeOf(context).width * 0.108,
                      height: 200,
                      fit: BoxFit.cover,
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

  /// Additional helper methods are added here.
}