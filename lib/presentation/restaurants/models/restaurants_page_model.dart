import '../../../logic/Plato.dart';
import '../widgets/restaurants_page_widget.dart' show RestaurantsPageWidget;
import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';

class RestaurantsPageModel extends FlutterFlowModel<RestaurantsPageWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();

  final currencyFormat = NumberFormat.simpleCurrency(locale: "es_US");

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {
    unfocusNode.dispose();
  }

  /// Action blocks are added here.
  ///

  Container mostrarPlatos(BuildContext context, Plato plato) {
    return Container(
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
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            plato.nombre,
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
                        Align(
                          alignment: AlignmentDirectional(1.00, 0.00),
                          child: Text(
                            '\$15.000',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Readex Pro',
                                  color: Color(0xFF138D20),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300,
                                ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      plato.descripcion,
                      textAlign: TextAlign.start,
                      maxLines: 2,
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Readex Pro',
                            color: Color(0xFF064244),
                          ),
                    ),
                    Flexible(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          FFButtonWidget(
                            onPressed: () {
                              print('Button pressed ...');
                            },
                            text: 'Agregar',
                            options: FFButtonOptions(
                              height: 35,
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                              iconPadding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                              color: Color(0xFF064244),
                              textStyle: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .override(
                                    fontFamily: 'Readex Pro',
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                  ),
                              elevation: 3,
                              borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          FlutterFlowIconButton(
                            borderColor: Colors.transparent,
                            borderRadius: 8,
                            buttonSize: 35,
                            fillColor: Color(0xFFFF7A00),
                            icon: Icon(
                              Icons.edit_rounded,
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              size: 20,
                            ),
                            onPressed: () {
                              print('EditButton pressed ...');
                            },
                          ),
                          FlutterFlowIconButton(
                            borderColor: Colors.transparent,
                            borderRadius: 8,
                            buttonSize: 35,
                            fillColor: Color(0xFFE72828),
                            icon: Icon(
                              Icons.delete_forever_rounded,
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              size: 20,
                            ),
                            onPressed: () {
                              print('RemoveButton pressed ...');
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                plato.imagen,
                width: MediaQuery.sizeOf(context).width * 0.25,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container mostrarMenu(BuildContext context, Plato plato) {
    return Container(
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
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Text(
                        plato.nombre,
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Readex Pro',
                              color: Color(0xFF064244),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                    Text(
                      plato.descripcion,
                      textAlign: TextAlign.start,
                      maxLines: 2,
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Readex Pro',
                            color: Color(0xFF064244),
                          ),
                    ),
                    Text(
                      currencyFormat.format(plato.precio),
                      textAlign: TextAlign.start,
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
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
            Flexible(
              child: Container(
                width: MediaQuery.sizeOf(context).width * 0.25,
                height: MediaQuery.sizeOf(context).height * 1,
                child: Stack(
                  children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        plato.imagen,
                        width: MediaQuery.sizeOf(context).width * 0.25,
                        height: 200,
                        fit: BoxFit.cover,
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
                        onPressed: () {
                          print('IconButton pressed ...');
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Additional helper methods are added here.
}
