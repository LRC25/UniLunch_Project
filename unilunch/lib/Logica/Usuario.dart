import 'package:flutter/cupertino.dart';
import 'package:unilunch/Persistencia/SupabaseConnection.dart';
import 'package:supabase/src/supabase_client.dart';

class Usuario {

  String idUsuario;
  String nombre;
  String email;
  String tipoUsuario;

  Usuario (
      this.idUsuario,
      this.email,
      this.nombre,
      this.tipoUsuario
      );

  Usuario.Vacio():
      idUsuario = '',
      nombre = '',
      email = '',
      tipoUsuario = ''
  ;

  Future<String> login(String email, String contrasenna) async {
    final SupabaseService _supabaseService = SupabaseService();
    SupabaseClient cliente = _supabaseService.client;
    try {
      final data = await cliente
          .from('usuario')
          .select()
          .eq('email', email)
          .eq('contrasenna', contrasenna);
      if (data.isNotEmpty) {
        debugPrint("Correcto");
        return "Correcto";
      } else {
        debugPrint("Incorrecto");
        return "Incorrecto";
      }
    } catch (e) {
      debugPrint(e.toString());
      return "Error";
    }
  }

}