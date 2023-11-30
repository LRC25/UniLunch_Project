import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:unilunch/persistence/SupabaseConnection.dart';
import 'package:supabase/src/supabase_client.dart';

import '../../logic/Restaurante.dart';

class Avatar extends StatefulWidget {
  final Restaurante restaurante;
  const Avatar({Key? key, required this.restaurante}) : super(key: key);

  @override
  _Avatar createState() => _Avatar();
}

class _Avatar extends State<Avatar> {
  String? image_actually;
  XFile? image;

  Future<void> _getImage() async {
    final ImagePicker picker = ImagePicker();
    var pickerImage = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if(pickerImage != null){
        image_actually = pickerImage.path;
        image = pickerImage;
      }
    });
  }

  Future<void> _uploadImage() async {
    final SupabaseService supabaseService = SupabaseService();
    SupabaseClient cliente = supabaseService.client;
    final image = this.image;

    if (image != null) {
      String idRestaruante = widget.restaurante.idRestaurante;
      final imageBytes = await image.readAsBytes();
      await cliente.storage.from("restaurantes").updateBinary('/$idRestaruante/imagen', imageBytes);
      print('Imagen subida a Supabase');
    } else {
      print('No hay ninguna imagen para subir.');
    }
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Imagen desde Supabase'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              (image_actually==null)?Container():Image(image: AssetImage(image_actually!)),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _getImage();
                },
                child: Text('Añadir imagen'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _uploadImage();
                },
                child: Text('Subir imagen'),
              ),
            ],
          ),
        ),
      ),
    );
  }

}