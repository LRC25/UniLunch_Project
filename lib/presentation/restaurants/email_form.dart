import 'package:flutter/material.dart';
import '../../../../../logic/Restaurante.dart';


// Define a custom Form widget.
class FormEmail extends StatefulWidget {
  final Restaurante restaurante;
  const FormEmail({Key? key ,required this.restaurante}) : super(key: key);

  @override
  FormEmailState createState() {
    return FormEmailState();
  }
}

// Define a corresponding State class.
// This class holds data related to the form.
class FormEmailState extends State<FormEmail> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  var newEmailController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child:  Column(
        children: <Widget>[
          const SizedBox(height: 10,),
          const Text("Ingrese correo electrónico:", style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),),
          const SizedBox(height: 10,),
          TextFormField(
            controller: newEmailController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              labelText: "Correo electrónico",
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.email),
            ),
            validator: (value) {
              RegExp regex = RegExp(r"^[a-zA-Z0-9_!#$%&'\*+/=?{|}~^.-]+@[a-zA-Z0-9-]+.[a-zA-Z0-9-]+[a-zA-Z0-9_.][a-zA-Z0-9_]+[a-zA-Z0-9_.][a-zA-Z0-9_]+$");
              if (value == null || value.isEmpty) {
                return 'Por favor complete este campo';
              }
              else if (!regex.hasMatch(value)) {
                // 3
                return "Correo no válido";
              }

              else {
                return null;
              }
            },

          ),
          const SizedBox(height: 10,),
          Container(
            height: 45,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              gradient: const LinearGradient(
                  colors: [Color(0xFF064244), Colors.green],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft),
            ),
            //int valor = await actualizarUsuario(newUsuario, widget.usuario.usuario);
            child: MaterialButton(
              onPressed: () async {
                String newEmail = newEmailController.text;
                if (_formKey.currentState!.validate()) {
                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Realizando registro')),
                  );
                  int valor =  await Restaurante.actualizarEmail(newEmail, widget.restaurante.idUsuario);
                  if (valor == 1) {
                    // ignore: use_build_context_synchronously
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: Color(0xFFC6E8DA),
                          title: const Text("Correcto"),
                          content: const Text("Se ha creado correctamente"),
                          actions: <Widget>[
                            TextButton(
                              child: const Text("Ok"),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        );
                      },
                    );
                  }
                } else {
                  // ignore: use_build_context_synchronously
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const AlertDialog(
                          backgroundColor: Color(0xFFC6E8DA),
                          title: Text("Ocurrió un error"),
                          content: SingleChildScrollView(
                            child: ListBody(
                              children: [
                                Text("No se pudo actualizar")
                              ],
                            ),
                          ),
                        );
                      }
                  );
                }
              },

              child: const Text(
                "Guardar cambios",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),

          ),
          const SizedBox(height: 10,),

        ],

      ),
    );
  }


}