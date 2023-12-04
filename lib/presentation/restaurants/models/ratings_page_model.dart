import 'package:flutterflow_ui/flutterflow_ui.dart';
import '../../../logic/Nota.dart';
import '../widgets/ratings_page_widget.dart' show RestaurantRatingsPageWidget;
import 'package:flutter/material.dart';

class RestaurantRatingsPageModel
    extends FlutterFlowModel<RestaurantRatingsPageWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {
    unfocusNode.dispose();
  }

  /// Action blocks are added here.

  Padding mostrarNotas(BuildContext context, Nota nota) {
    if (nota.descripcion.isNotEmpty) {
      return Padding(
        padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
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
                child: Padding(
                  padding:
                  EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Align(
                        alignment: AlignmentDirectional(0.00, 0.00),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              5, 0, 5, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment:
                            MainAxisAlignment.center,
                            crossAxisAlignment:
                            CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.star_rounded,
                                color: Color(0xFFFF7A00),
                                size: 32,
                              ),
                              Text(
                                nota.calificacion.toString(),
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
                        ),
                      ),
                      Flexible(
                        child: Text(
                          nota.descripcion,
                          maxLines: 3,
                          style: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .override(
                            fontFamily: 'Readex Pro',
                            color: Color(0xFF064244),
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ].divide(SizedBox(width: 5)),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return Padding(padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0));
    }
  }

  /// Additional helper methods are added here.
}
