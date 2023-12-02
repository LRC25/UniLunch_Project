import 'package:flutter/material.dart';
import 'package:unilunch/presentation/common/widgets/login_page_widget.dart';

void registrationAcceptMessage(BuildContext context, String mensaje) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Correcto"),
        backgroundColor: Color(0xFFC6E8DA),
        content: SingleChildScrollView(
          child: ListBody(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.check,
                    color: Color(0xFF064244),
                  ),
                  SizedBox(width: 10),
                  Text(mensaje),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder:
                      (context) => LoginPageWidget()));
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(150, 50),
                  primary: Color(0xFF064244),
                  padding: EdgeInsets.symmetric(vertical: 15),
                ),
                child: Text(
                  'Aceptar',
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

void warningMessage(BuildContext context, String mensaje) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("No se puede ingresar"),
        backgroundColor: Color(0xFFC6E8DA),
        content: SingleChildScrollView(
          child: ListBody(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.warning,
                    color: Color(0xFF064244),
                  ),
                  SizedBox(width: 10),
                  Text(mensaje),
                ],
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
                  'Aceptar',
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

void errorMessage(BuildContext context, String mensaje) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Error"),
        backgroundColor: Color(0xFFC6E8DA),
        content: SingleChildScrollView(
          child: ListBody(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.error,
                    color: Color(0xFF064244),
                  ),
                  SizedBox(width: 10),
                  Text(mensaje),
                ],
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
                  'Aceptar',
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