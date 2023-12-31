import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:unilunch/logic/Cliente.dart';
import 'package:unilunch/presentation/common/widgets/login_page_widget.dart';
import 'package:unilunch/presentation/customers/widgets/navbar_customer_page_widget.dart';

import '../../../logic/Restaurante.dart';

void registrationAcceptMessage(BuildContext context, String mensaje) {
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
                    Icons.check_circle,
                    color: Color(0xFF29A814),
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
                        onPressed: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder:
                              (context) => LoginPageWidget()));
                        },
                        text: 'Aceptar',
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

void accceptMessage(BuildContext context, String mensaje) {
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
                    Icons.check_circle,
                    color: Color(0xFF29A814),
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
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        text: 'Aceptar',
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

void accceptMessageReserva(BuildContext context, String mensaje, Cliente cliente) {
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
                    Icons.check_circle,
                    color: Color(0xFF29A814),
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
                        onPressed: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(
                              builder:(context) => NavbarCustomerPage(cliente: cliente)));
                        },
                        text: 'Aceptar',
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

void warningMessage(BuildContext context, String mensaje) {
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
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        text: 'Aceptar',
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

void errorMessage(BuildContext context, String mensaje) {
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
                    Icons.error_sharp,
                    color: Color(0xFFD31717),
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
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        text: 'Aceptar',
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

void updateMessage(BuildContext context, String campo, String informacionActual, id, tipo) {

  TextEditingController _textFieldController = TextEditingController(text: informacionActual);

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(

        title: Text("Actualizar $campo"),
        backgroundColor: Color(0xFFC6E8DA),
        content: SingleChildScrollView(
          child: ListBody(
            children: [


              SizedBox(height: 20),

              TextField(
                controller: _textFieldController,
                decoration: InputDecoration(hintText: 'Ingrese $campo'),
              ),
              SizedBox(height: 20),

              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(150, 50),
                  primary: Color(0xFF064244),
                  padding: EdgeInsets.symmetric(vertical: 15),
                ),
                child: Text(
                  'Cancelar',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 20),

              ElevatedButton(
                onPressed: () async {
                  debugPrint(campo);
                  String nuevoValor = _textFieldController.text;
                  if(campo == 'Nombre') {
                    if (tipo == 'Restaurante') {

                      int valor = await Restaurante.actualizarNombre(nuevoValor,id);
                      debugPrint('$valor');
                      if (valor == 1){
                        await alertActualizado(context);
                        Navigator.pop(context);
                      }
                      else {
                        await alertError(context);
                      }

                    }
                    else if(tipo == 'Cliente') {
                      int valor =  await Cliente.actualizarNombre(nuevoValor,id) ;
                      debugPrint('$valor');
                      if (valor == 1){
                        debugPrint('Entró al if');
                        await alertActualizado(context);
                        Navigator.pop(context);
                     }
                     else {
                       await alertError(context);
                    }
                  }

                  }
                  else  if(campo == 'Nombre del restaurante'){
                    int valor =  await Restaurante.actualizarNombreRestaurante(nuevoValor,id);
                    if (valor == 1){
                      await alertActualizado(context);
                      Navigator.pop(context);
                      debugPrint('Entró al iif II');
                    }
                    else {
                      await alertError(context);
                    }
                    debugPrint('Entró al iif');
                  }

                  else if(campo == 'Descripción'){
                    debugPrint('Entró al iif II');
                    int valor =  await Restaurante.actualizarDescripcion(nuevoValor,id);
                    if (valor == 1){
                      await alertActualizado(context);
                      Navigator.pop(context);

                    }
                    else {
                      await alertError(context);
                    }

                  }

                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(150, 50),
                  primary: Color(0xFF064244),
                  padding: EdgeInsets.symmetric(vertical: 15),
                ),
                child: const Text(
                  'Guardar',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

Future<void> alertError(BuildContext context) async {
  await showDialog(
      context: context,
      builder: (BuildContext context) {
        return const AlertDialog(
          backgroundColor: Color(0xFFC6E8DA),
          title: Text("Ocurrió un error"),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text("No se actualizar")
              ],
            ),
          ),
        );
      }
  );
}

Future<void> alertActualizado(BuildContext context) async {
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Color(0xFFC6E8DA),
        title: Text("Correcto"),
        content: Text("Se ha actualizado correctamente"),
        actions: <Widget>[
          TextButton(
            child: Text("Ok"),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      );

    },
  );
}

void accceptPassRecoveryMessage(BuildContext context, String mensaje) {
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
                    Icons.check_circle,
                    color: Color(0xFF29A814),
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
                        onPressed: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(
                            builder: (context) => LoginPageWidget()));
                        },
                        text: 'Aceptar',
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