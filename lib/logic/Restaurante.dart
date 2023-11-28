//import 'dart:ffi';
import 'package:unilunch/logic/Usuario.dart';
import 'package:unilunch/logic/Horario.dart';
import 'package:flutter/cupertino.dart';
import 'package:unilunch/persistence/SupabaseConnection.dart';
import 'package:supabase/src/supabase_client.dart';

class Restaurante extends Usuario {

  String idRestaurante;
  String ubicacion;
  String direccion;
  String descripcion;
  List<Horario> horario;
  String imagen;
  double notaPromedio;


  Restaurante({
    required String idUsuario,
    required String nombre,
    required String email,
    required String tipoUsuario,
    required this.idRestaurante,
    required this.ubicacion,
    required this.direccion,
    required this.descripcion,
    required this.horario,
    required this.imagen,
    required this.notaPromedio
  }) : super(idUsuario, nombre, email, tipoUsuario);

  Future<String> resgistrarRestaurante(String contrasenna) async {
    final SupabaseService supabaseService = SupabaseService();
    SupabaseClient cliente = supabaseService.client;
    try {
      if (idUsuario.isNotEmpty | nombre.isNotEmpty | email.isNotEmpty | tipoUsuario.isNotEmpty) {
        await cliente
            .from("usuario")
            .insert({"id_usuario":idUsuario, "nombre":nombre, "email":email, "contrasenna":contrasenna, "tipo_usuario":tipoUsuario});
        await cliente
            .from("restaurante")
            .insert({});
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
