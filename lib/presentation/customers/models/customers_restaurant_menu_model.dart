import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:flutter/material.dart';
import 'package:unilunch/logic/Plato.dart';

import '../widgets/customers_restaurant_menu_widget.dart';

class CustomerRestaurantMenuModel
    extends FlutterFlowModel<CustomerRestaurantMenuWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();

  final currencyFormat = NumberFormat.simpleCurrency(locale: "es_US");

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {
    unfocusNode.dispose();
  }

  /// Action blocks are added here.

  Padding mostrarMenu(BuildContext context, Plato plato) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(16, 5, 16, 5),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.sizeOf(context).width * 0.65,
                      height: 100,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context)
                            .secondaryBackground,
                      ),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            0, 0, 5, 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment:
                              AlignmentDirectional(-1.00, 0.00),
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
                            Text(
                              plato.descripcion,
                              textAlign: TextAlign.start,
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
                                  alignment: AlignmentDirectional(
                                      -1.00, 0.00),
                                  child: Text(
                                    currencyFormat.format(plato.precio),
                                    style: FlutterFlowTheme.of(
                                        context)
                                        .bodyMedium
                                        .override(
                                      fontFamily: 'Readex Pro',
                                      color: Color(0xFF138D20),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: Align(
                                    alignment: AlignmentDirectional(
                                        1.00, 0.00),
                                    child: Text(
                                      '${plato.stock} disponibles',
                                      textAlign: TextAlign.start,
                                      style:
                                      FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                        fontFamily:
                                        'Readex Pro',
                                        fontWeight:
                                        FontWeight.w300,
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
                        child: Container(
                          width: MediaQuery.sizeOf(context).width,
                          height:
                          MediaQuery.sizeOf(context).height * 1,
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius:
                                BorderRadius.circular(16),
                                child: Image.network(
                                  plato.imagen,
                                  width: MediaQuery.sizeOf(context)
                                      .width,
                                  height: MediaQuery.sizeOf(context)
                                      .height *
                                      1,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Align(
                                alignment:
                                AlignmentDirectional(1.00, 1.00),
                                child: FlutterFlowIconButton(
                                  borderColor: Color(0x00FFFFFF),
                                  borderRadius: 16,
                                  borderWidth: 1,
                                  buttonSize: 40,
                                  fillColor: Color(0xFFFF7A00),
                                  icon: Icon(
                                    Icons.add_circle,
                                    color:
                                    FlutterFlowTheme.of(context)
                                        .secondaryBackground,
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
