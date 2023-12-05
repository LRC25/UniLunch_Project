import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:unilunch/logic/Cliente.dart';
import '../../../alerts.dart';
import '../../../logic/Reserva.dart';
import '../../../logic/ReservaPlato.dart';
import '../widgets/reservations_page_widget.dart' show CustomerReservationsPageWidget;
import 'package:flutter/material.dart';

class CustomerReservationsPageModel extends FlutterFlowModel<CustomerReservationsPageWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();

  final currencyFormat = NumberFormat.simpleCurrency(locale: "es_US");

  double valorActual = 3;

  /// Initialization and disposal methods.

  final textFieldFocusNode = FocusNode();
  final textController = TextEditingController();

  void initState(BuildContext context) {}

  void dispose() {
    unfocusNode.dispose();
  }

  /// Action blocks are added here.

  Padding mostrarReservas(BuildContext context, Reserva reserva, Cliente cliente, Function reload) {
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
            onTap: () async {
              detallesReservaPendiente(context, reserva, cantidad, reload);
            },
            child: Container(
              width: MediaQuery.sizeOf(context).width,
              height: 80,
              color: Colors.transparent,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.sizeOf(context).width * 0.18,
                    height: 120,
                    decoration: BoxDecoration(),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        reserva.logoRestaurante,
                        width: MediaQuery.sizeOf(context).width * 0.108,
                        height: 120,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Flexible(
                    child: Align(
                      alignment: AlignmentDirectional(0.00, 0.00),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              reserva.nombreRestaurante,
                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                fontFamily: 'Readex Pro',
                                color: Color(0xFF064244),
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                              maxLines: 1,
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
                                  maxLines: 1,
                                ),
                                estadoReserva(context, reserva)
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
                              maxLines: 1,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  botonCalificar(context, reserva, cantidad, cliente)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Text estadoReserva(BuildContext context, Reserva reserva) {
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

  Container botonCalificar(BuildContext context, Reserva reserva, int cantidad, Cliente cliente){
    if (reserva.estado!="Completado") {
      return Container(
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
        ),
      );
    } else {
      if(reserva.estadoCalificacion==true) {
        return Container(
          width: 100,
          height: 100,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.star_rounded,
                color: Color(0xFFFF7A00),
                size: 32,
              ),
              Text(
                reserva.nota,
                textAlign: TextAlign.center,
                style: FlutterFlowTheme.of(context)
                    .bodyMedium
                    .override(
                  fontFamily: 'Readex Pro',
                  color: Color(0xFFFF7A00),
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ].divide(SizedBox(height: 0)),
          ),
        );
      } else {
        return Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).secondaryBackground,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                child: FlutterFlowIconButton(
                  borderColor: FlutterFlowTheme.of(context).info,
                  borderRadius: 10,
                  borderWidth: 1,
                  buttonSize: 40,
                  fillColor: Color(0xFFFF983D),
                  icon: Icon(
                    Icons.star_rate,
                    color: FlutterFlowTheme.of(context).info,
                    size: 24,
                  ),
                  onPressed: () {
                    calificar(context, reserva, cantidad, cliente);
                  },
                ),
              ),
              Text(
                'Calificar',
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                  fontFamily: 'Readex Pro',
                  color: Color(0xFFFF983D),
                ),
              ),
            ],
          ),
        );
      }
    }
  }

  void detallesReservaPendiente(BuildContext context, Reserva reserva, int cantidad, Function reload) {
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
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
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
              Container(
                width: MediaQuery.sizeOf(context).width,
                height: 80,
                color: Colors.transparent,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    AspectRatio(
                      aspectRatio: 1,
                      child: Container(
                        width: MediaQuery.sizeOf(context).width * 0.18,
                        height: 120,
                        decoration: BoxDecoration(),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.network(
                            reserva.logoRestaurante,
                            width: MediaQuery.sizeOf(context).width * 0.108,
                            height: 120,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      child: Align(
                        alignment: AlignmentDirectional(0.00, 0.00),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                reserva.nombreRestaurante,
                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                  fontFamily: 'Readex Pro',
                                  color: Color(0xFF064244),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                                maxLines: 1,
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    '$cantidad platos',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                      fontFamily: 'Readex Pro',
                                      color: Color(0xFF064244),
                                      fontSize: 12,
                                    ),
                                    maxLines: 1,
                                  ),
                                ],
                              ),
                              Text(
                                DateFormat('yyyy-MM-dd').format(reserva.fecha),
                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                  fontFamily: 'Readex Pro',
                                  color: Color(0xFF064244),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FontStyle.italic,
                                ),
                                maxLines: 1,
                              ),
                              Text(
                                DateFormat('HH:mm').format(reserva.fecha),
                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                  fontFamily: 'Readex Pro',
                                  color: Color(0xFF064244),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FontStyle.italic,
                                ),
                                maxLines: 1,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 80,
                      height: 80,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.star_rounded,
                            color: Color(0xFFFF7A00),
                            size: 20,
                          ),
                          Text(
                            reserva.notaRestaurante.toString(),
                            textAlign: TextAlign.center,
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                              fontFamily: 'Readex Pro',
                              color: Color(0xFFFF7A00),
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                          ),
                        ].divide(SizedBox(height: 0)),
                      ),
                    ),
                  ],
                ),
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
                  children: (reserva.platos.isEmpty)
                      ? [const Center(child: CircularProgressIndicator(color: Color(0xFF064244)))]
                      : reserva.platos.map((reservaPlato) {
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
              (reserva.estado!="Pendiente") ? Container() : Align(
                alignment: AlignmentDirectional(0.00, 0.00),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                  child: FFButtonWidget(
                    onPressed: () async {
                      Navigator.of(context).pop();
                      warningCanceleReservationMessage(context, "Esta seguro que desea cancelar la reserva", reserva, reload);
                    },
                    text: 'Cancelar Reserva',
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
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    width: MediaQuery.sizeOf(context).width * 0.3,
                    height: 100,
                    decoration: BoxDecoration(),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        reservaPlato.plato.imagen,
                        width: MediaQuery.sizeOf(context).width * 0.108,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
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

  void warningCanceleReservationMessage(BuildContext context, String mensaje, Reserva reserva, Function reload) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xFFC6E8DA),
          content: SingleChildScrollView(
              child: Container(
                width: MediaQuery.sizeOf(context).width,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.warning_sharp,
                      color: FlutterFlowTheme.of(context).warning,
                      size: 100,
                    ),
                    Align(
                      alignment: AlignmentDirectional(0.00, 0.00),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                        child: Text(
                          mensaje,
                          style: FlutterFlowTheme.of(context).headlineMedium.override(
                            fontFamily: 'Outfit',
                            color: Color(0xFF064244),
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional(0.00, 0.00),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 5, 10, 10),
                        child: FFButtonWidget(
                          onPressed: () async {
                            String respuesta = await reserva.cancelarReserva();
                            if(respuesta=="correcto") {
                              Navigator.of(context).pop();
                              reload();
                              accceptMessage(context, "Se ha cancelado corretamente la reserva");
                            } else {
                              Navigator.of(context).pop();
                              errorMessage(context, "Ha ocurrido un error");
                            }
                          },
                          text: 'Si',
                          options: FFButtonOptions(
                            width: 140,
                            height: 52,
                            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                            iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                            color: FlutterFlowTheme.of(context).warning,
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
                    Align(
                      alignment: AlignmentDirectional(0.00, 0.00),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 5, 10, 10),
                        child: FFButtonWidget(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          text: 'No',
                          options: FFButtonOptions(
                            width: 140,
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
              )
          ),
        );
      },
    );
  }

  void calificar(BuildContext context, Reserva reserva, int cantidad, Cliente cliente) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xFFC6E8DA),
          content: SingleChildScrollView(
              child: Container(
                width: MediaQuery.sizeOf(context).width,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: MediaQuery.sizeOf(context).width,
                      height: 80,
                      color: Colors.transparent,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.sizeOf(context).width * 0.20,
                            height: 120,
                            decoration: BoxDecoration(),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.network(
                                reserva.logoRestaurante,
                                width: MediaQuery.sizeOf(context).width * 0.108,
                                height: 120,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Flexible(
                            child: Align(
                              alignment: AlignmentDirectional(0.00, 0.00),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      reserva.nombreRestaurante,
                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                        fontFamily: 'Readex Pro',
                                        color: Color(0xFF064244),
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Text(
                                          '$cantidad platos',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                            fontFamily: 'Readex Pro',
                                            color: Color(0xFF064244),
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      DateFormat('yyyy-MM-dd').format(reserva.fecha),
                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                        fontFamily: 'Readex Pro',
                                        color: Color(0xFF064244),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                    Text(
                                      DateFormat('HH:mm').format(reserva.fecha),
                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                        fontFamily: 'Readex Pro',
                                        color: Color(0xFF064244),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 80,
                            height: 80,
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.star_rounded,
                                  color: Color(0xFFFF7A00),
                                  size: 20,
                                ),
                                Text(
                                  reserva.notaRestaurante.toString(),
                                  textAlign: TextAlign.center,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                    fontFamily: 'Readex Pro',
                                    color: Color(0xFFFF7A00),
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ].divide(SizedBox(height: 0)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional(0.00, 0.00),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                        child: Center(
                          child: Text(
                            "¿Comó fue tu experiencia en ${reserva.nombreRestaurante}?",
                            textAlign: TextAlign.center,
                            style: FlutterFlowTheme.of(context).headlineMedium.override(
                              fontFamily: 'Outfit',
                              color: Color(0xFF064244),
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )
                      ),
                    ),
                    RatingBar.builder(
                      onRatingUpdate: (newValue) => {
                        valorActual = newValue
                      },
                      itemBuilder: (context, index) => Icon(
                        Icons.star_rounded,
                        color: FlutterFlowTheme.of(context).tertiary,
                      ),
                      direction: Axis.horizontal,
                      initialRating: 3,
                      minRating: 1,
                      unratedColor: FlutterFlowTheme.of(context).accent3,
                      itemCount: 5,
                      itemSize: 40,
                      glowColor: FlutterFlowTheme.of(context).tertiary,
                    ),
                    Align(
                      alignment: AlignmentDirectional(0.00, 0.00),
                      child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                          child: Center(
                            child: Text(
                              "¿Tienes algún comentario?",
                              textAlign: TextAlign.center,
                              style: FlutterFlowTheme.of(context).headlineMedium.override(
                                fontFamily: 'Outfit',
                                color: Color(0xFF064244),
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          )
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(15, 10, 15, 10),
                      child: TextFormField(
                        controller: textController,
                        focusNode: textFieldFocusNode,
                        autofocus: true,
                        obscureText: false,
                        decoration: InputDecoration(
                          labelText: 'Ingresa tu comentario aquí',
                          labelStyle: FlutterFlowTheme.of(context).bodyMedium,
                          alignLabelWithHint: false,
                          hintStyle: FlutterFlowTheme.of(context).labelMedium,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF064244),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF064244),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).error,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).error,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        style: FlutterFlowTheme.of(context).bodyMedium,
                        textAlign: TextAlign.center,
                        maxLines: 3,
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional(0.00, 0.00),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 5, 10, 10),
                        child: FFButtonWidget(
                          onPressed: () async {
                            if (textController.text=="") {
                              String response = await cliente.calificarRestaurante("", valorActual.toInt(), reserva);
                              if (response=="correcto") {
                                Navigator.of(context).pop();
                                accceptMessage(context, "Se ha calificado corretamente la reserva");
                              } else {
                                Navigator.of(context).pop();
                                errorMessage(context, "Ha ocurrido un error");
                              }
                            } else {
                              String response = await cliente.calificarRestaurante(textController.text, valorActual.toInt(), reserva);
                              if (response=="correcto") {
                                Navigator.of(context).pop();
                                accceptMessage(context, "Se ha calificado corretamente la reserva");
                              } else {
                                Navigator.of(context).pop();
                                errorMessage(context, "Ha ocurrido un error");
                              }
                            }
                          },
                          text: 'Envíar',
                          options: FFButtonOptions(
                            width: 140,
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
              )
          ),
        );
      },
    );
  }

  /// Additional helper methods are added here.
}
