import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../logic/Nota.dart';
import '../../../logic/Restaurante.dart';
import 'package:auto_size_text/auto_size_text.dart';

import '../models/ratings_page_model.dart';
export '../models/ratings_page_model.dart';

class RestaurantRatingsPageWidget extends StatefulWidget {
  final Restaurante restaurante;
  const RestaurantRatingsPageWidget({Key? key, required this.restaurante}) : super(key: key);

  @override
  _RestaurantRatingsPageWidgetState createState() =>
      _RestaurantRatingsPageWidgetState();
}

class _RestaurantRatingsPageWidgetState
    extends State<RestaurantRatingsPageWidget> {
  late RestaurantRatingsPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  var notasCargadas = false;
  var cantidad = 0;
  late List<Nota> notas = [];

  @override
  void initState() {
    _loadNotas();
    super.initState();
    _model = createModel(context, () => RestaurantRatingsPageModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  void _loadNotas() async {
    List<Nota> notasTemp = await widget.restaurante.mostrarNotas();
    setState(() {
      notasCargadas = true;
      notas = notasTemp;
      cantidad = notasTemp.length;
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
              'Calificaciones',
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
                Container(
                  decoration: BoxDecoration(),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 4),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AutoSizeText(
                          '${widget.restaurante.nombreRestaurante}',
                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Readex Pro',
                            color: Color(0xFF064244),
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.star_rounded,
                              color: Color(0xFFFF7A00),
                              size: 30,
                            ),
                            Text(
                              '${widget.restaurante.notaPromedio} (${cantidad.toString()})',
                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Readex Pro',
                                    color: Color(0xFFFF7A00),
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                // Padding(
                //   padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 8),
                //   child: Text(
                //     'Así van tus calificaciones:',
                //     style: FlutterFlowTheme.of(context).bodyMedium.override(
                //           fontFamily: 'Readex Pro',
                //           color: Color(0xFF064244),
                //           fontSize: 16,
                //           fontWeight: FontWeight.normal,
                //         ),
                //   ),
                // ),
                // Padding(
                //   padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 8),
                //   child: Column(
                //     mainAxisSize: MainAxisSize.max,
                //     crossAxisAlignment: CrossAxisAlignment.center,
                //     children: [
                //       Padding(
                //         padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                //         child: Row(
                //           mainAxisSize: MainAxisSize.max,
                //           mainAxisAlignment: MainAxisAlignment.center,
                //           children: [
                //             Icon(
                //               Icons.star_rounded,
                //               color: Color(0xFFFF7A00),
                //               size: 24,
                //             ),
                //             Text(
                //               '5',
                //               style: FlutterFlowTheme.of(context)
                //                   .bodyMedium
                //                   .override(
                //                     fontFamily: 'Readex Pro',
                //                     color: Color(0xFFFF7A00),
                //                     fontSize: 16,
                //                     fontWeight: FontWeight.bold,
                //                   ),
                //             ),
                //             Text(
                //               ' - 300',
                //               style: FlutterFlowTheme.of(context)
                //                   .bodyMedium
                //                   .override(
                //                     fontFamily: 'Readex Pro',
                //                     color: Color(0xFF064244),
                //                     fontSize: 16,
                //                   ),
                //             ),
                //           ],
                //         ),
                //       ),
                //       Padding(
                //         padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                //         child: Row(
                //           mainAxisSize: MainAxisSize.max,
                //           mainAxisAlignment: MainAxisAlignment.center,
                //           children: [
                //             Icon(
                //               Icons.star_rounded,
                //               color: Color(0xFFFF7A00),
                //               size: 24,
                //             ),
                //             Text(
                //               '4',
                //               style: FlutterFlowTheme.of(context)
                //                   .bodyMedium
                //                   .override(
                //                     fontFamily: 'Readex Pro',
                //                     color: Color(0xFFFF7A00),
                //                     fontSize: 16,
                //                     fontWeight: FontWeight.bold,
                //                   ),
                //             ),
                //             Text(
                //               ' - 60',
                //               style: FlutterFlowTheme.of(context)
                //                   .bodyMedium
                //                   .override(
                //                     fontFamily: 'Readex Pro',
                //                     color: Color(0xFF064244),
                //                     fontSize: 16,
                //                   ),
                //             ),
                //           ],
                //         ),
                //       ),
                //       Padding(
                //         padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                //         child: Row(
                //           mainAxisSize: MainAxisSize.max,
                //           mainAxisAlignment: MainAxisAlignment.center,
                //           children: [
                //             Icon(
                //               Icons.star_rounded,
                //               color: Color(0xFFFF7A00),
                //               size: 24,
                //             ),
                //             Text(
                //               '3',
                //               style: FlutterFlowTheme.of(context)
                //                   .bodyMedium
                //                   .override(
                //                     fontFamily: 'Readex Pro',
                //                     color: Color(0xFFFF7A00),
                //                     fontSize: 16,
                //                     fontWeight: FontWeight.bold,
                //                   ),
                //             ),
                //             Text(
                //               ' - 20',
                //               style: FlutterFlowTheme.of(context)
                //                   .bodyMedium
                //                   .override(
                //                     fontFamily: 'Readex Pro',
                //                     color: Color(0xFF064244),
                //                     fontSize: 16,
                //                   ),
                //             ),
                //           ],
                //         ),
                //       ),
                //       Padding(
                //         padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                //         child: Row(
                //           mainAxisSize: MainAxisSize.max,
                //           mainAxisAlignment: MainAxisAlignment.center,
                //           children: [
                //             Icon(
                //               Icons.star_rounded,
                //               color: Color(0xFFFF7A00),
                //               size: 24,
                //             ),
                //             Text(
                //               '2',
                //               style: FlutterFlowTheme.of(context)
                //                   .bodyMedium
                //                   .override(
                //                     fontFamily: 'Readex Pro',
                //                     color: Color(0xFFFF7A00),
                //                     fontSize: 16,
                //                     fontWeight: FontWeight.bold,
                //                   ),
                //             ),
                //             Text(
                //               ' - 10',
                //               style: FlutterFlowTheme.of(context)
                //                   .bodyMedium
                //                   .override(
                //                     fontFamily: 'Readex Pro',
                //                     color: Color(0xFF064244),
                //                     fontSize: 16,
                //                   ),
                //             ),
                //           ],
                //         ),
                //       ),
                //       Padding(
                //         padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                //         child: Row(
                //           mainAxisSize: MainAxisSize.max,
                //           mainAxisAlignment: MainAxisAlignment.center,
                //           children: [
                //             Icon(
                //               Icons.star_rounded,
                //               color: Color(0xFFFF7A00),
                //               size: 24,
                //             ),
                //             Text(
                //               '1',
                //               style: FlutterFlowTheme.of(context)
                //                   .bodyMedium
                //                   .override(
                //                     fontFamily: 'Readex Pro',
                //                     color: Color(0xFFFF7A00),
                //                     fontSize: 16,
                //                     fontWeight: FontWeight.bold,
                //                   ),
                //             ),
                //             Text(
                //               ' - 10',
                //               style: FlutterFlowTheme.of(context)
                //                   .bodyMedium
                //                   .override(
                //                     fontFamily: 'Readex Pro',
                //                     color: Color(0xFF064244),
                //                     fontSize: 16,
                //                   ),
                //             ),
                //           ],
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 8),
                  child: Text(
                    'Esto han dicho tus clientes:',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Readex Pro',
                          color: Color(0xFF064244),
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        ),
                  ),
                ),
                Column(
                  children: (notasCargadas==false)
                      ? [const Center(child: CircularProgressIndicator(color: Color(0xFF064244)))]
                      : (notas.isEmpty) ? [Center(child: Text(
                      "No hay notas",
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Readex Pro',
                        color: Color(0xFF064244),
                        fontSize: 16,
                        fontWeight: FontWeight.w400,))
                  )] : notas.map((nota) {
                    return _model.mostrarNotas(context, nota);
                  }).toList(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
