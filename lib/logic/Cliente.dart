import 'package:unilunch/logic/Usuario.dart';
import 'package:unilunch/logic/BuscarRestaurante.dart';
import 'package:unilunch/logic/Restaurante.dart';
import 'package:flutter/cupertino.dart';
import 'package:unilunch/persistence/SupabaseConnection.dart';
import 'package:supabase/src/supabase_client.dart';

class Cliente extends Usuario {

  late BuscarRestaurante _buscarRestaurante;

  Cliente({
    required String idUsuario,
    required String nombre,
    required String email,
    required String tipoUsuario,
  }) : super(idUsuario, nombre, email, tipoUsuario);

  void setBuscarRestaurante(BuscarRestaurante buscarRestaurante) {
    _buscarRestaurante = buscarRestaurante;
  }

  List<Restaurante> applyBuscarRestaurante(dynamic entrada) {
    return _buscarRestaurante.buscarRerstaurante(entrada);
  }

  Future<String> resgistrarCliente(String contrasenna) async {
    final SupabaseService supabaseService = SupabaseService();
    SupabaseClient cliente = supabaseService.client;
    try {
      if (idUsuario.isNotEmpty | nombre.isNotEmpty | email.isNotEmpty | tipoUsuario.isNotEmpty) {
        final data = await cliente
            .from("usuario")
            .insert({"id_usuario":idUsuario, "nombre":nombre, "email":email, "contrasenna":contrasenna, "tipo_usuario":tipoUsuario});
        return "correcto";
      } else {
        return "Algunos campos estan vacios";
      }
    } catch (e) {
      debugPrint(e.toString());
      return e.toString();
    }
  }

}
