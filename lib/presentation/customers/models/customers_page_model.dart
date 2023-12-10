import 'package:google_maps_flutter/google_maps_flutter.dart'
    as google_maps;
import 'package:unilunch/logic/Carrito.dart';
import 'package:unilunch/logic/Restaurante.dart';

import '../widgets/customers_page_widget.dart' show CustomersPageWidget;
import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';

import '../widgets/customers_restaurant_menu_widget.dart';

class CustomersPageModel extends FlutterFlowModel<CustomersPageWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for searchRestaurant widget.
  FocusNode? searchRestaurantFocusNode;
  TextEditingController? searchRestaurantController;
  google_maps.GoogleMapController? googleMapController;
  String? Function(BuildContext, String?)? searchRestaurantControllerValidator;

  final Carrito carrito = Carrito.vacio();

  List<google_maps.Marker> markers = [];

  /// Initialization and disposal methods.

  static const initialCameraPosition = google_maps.CameraPosition(
      target: google_maps.LatLng(7.1380158, -73.1198447), zoom: 16.25);

  void initState(BuildContext context) {}

  void dispose() {
    unfocusNode.dispose();
    searchRestaurantFocusNode?.dispose();
    searchRestaurantController?.dispose();
    googleMapController?.dispose();
  }

  /// Action blocks are added here.

  Padding listaRestaurantes(BuildContext context, Restaurante restaurante) {
    return Padding(
        padding: EdgeInsetsDirectional.fromSTEB(16, 5, 16, 5),
        child: InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
                builder:(context) => CustomerRestaurantMenuWidget(cliente: widget.cliente,
                  carrito: carrito, restaurante: restaurante,)));
          },
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
                      padding: EdgeInsetsDirectional.fromSTEB(
                          0, 0, 5, 0),
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: Container(
                          width:
                          MediaQuery.sizeOf(context).width * 1,
                          height:
                          MediaQuery.sizeOf(context).height * 1,
                          decoration: BoxDecoration(),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              restaurante.imagen,
                              width:
                              MediaQuery.sizeOf(context).width *
                                  0.108,
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
                      padding: EdgeInsetsDirectional.fromSTEB(
                          0, 0, 5, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment:
                            MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                child: Align(
                                  alignment: AlignmentDirectional(
                                      -1.00, 0.00),
                                  child: Text(
                                    restaurante.nombreRestaurante,
                                    style: FlutterFlowTheme.of(
                                        context)
                                        .bodyMedium
                                        .override(
                                      fontFamily: 'Readex Pro',
                                      color: Color(0xFF064244),
                                      fontSize: 16,
                                      fontWeight:
                                      FontWeight.bold,
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
                                alignment: AlignmentDirectional(
                                    -1.00, 0.00),
                                child: Text(
                                  (restaurante.notaPromedio==0) ? "-" : restaurante.notaPromedio.toString(),
                                  style: FlutterFlowTheme.of(
                                      context)
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
                            restaurante.descripcion,
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
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Flexible(
                                child: Align(
                                  alignment: AlignmentDirectional(
                                      -1.00, 0.00),
                                  child: Text(
                                    maxLines: 1,
                                    restaurante.direccion,
                                    overflow: TextOverflow.ellipsis,
                                    style: FlutterFlowTheme.of(
                                        context)
                                        .bodyMedium
                                        .override(
                                      fontFamily: 'Readex Pro',
                                      color: Color(0xFF064244),
                                      fontSize: 14,
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
        )
    );
  }

  void addMarker(BuildContext context, Restaurante restaurante){
    markers.add(
      google_maps.Marker(
        markerId: google_maps.MarkerId(restaurante.idRestaurante),
        position: google_maps.LatLng(restaurante.latitud, restaurante.longitud),
        infoWindow: google_maps.InfoWindow(
          title: restaurante.nombreRestaurante,
          snippet: restaurante.direccion,
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder:(context) =>
            CustomerRestaurantMenuWidget(cliente: widget.cliente, carrito: carrito, restaurante: restaurante)));
          },
        )
      )
    );
  }

  void clearMarkers(BuildContext context){
    markers.clear();
  }

  /// Additional helper methods are added here.
}
