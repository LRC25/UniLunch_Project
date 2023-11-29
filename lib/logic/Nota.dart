import 'package:flutter/cupertino.dart';
import 'package:unilunch/persistence/SupabaseConnection.dart';
import 'package:supabase/src/supabase_client.dart';
import 'package:unilunch/utils.dart';

class Nota {
  String idNota;
  String nombreCliente;
  int calificacion;
  String descripcion;

  Nota(
      this.idNota,
      this.nombreCliente,
      this.descripcion,
      this.calificacion
      );

  Nota.resgistro(
      this.descripcion,
      this.calificacion
      ): idNota = "", nombreCliente = "";

  Nota.vacio(): idNota = "", nombreCliente = "", calificacion = 0, descripcion = "";

  Future<String> insertarNota(String idRestaurante, String idUsuario) async {
    final SupabaseService supabaseService = SupabaseService();
    SupabaseClient cliente = supabaseService.client;
    try {
      String id = randomDigits(10);
      await cliente
          .from("nota")
          .insert({"id_nota":id, "id_restaurante":idRestaurante, "id_usuario":idUsuario, "calificacion":calificacion, "descripcion":descripcion});
      return "correcto";
    } catch (e) {
      debugPrint(e.toString());
      return e.toString();
    }
  }

  Future<String> eliminarNota() async {
    final SupabaseService supabaseService = SupabaseService();
    SupabaseClient cliente = supabaseService.client;
    try {
      await cliente.from('nota').delete().match({"id_nota": idNota});
      return "correcto";
    } catch (e) {
      debugPrint(e.toString());
      return e.toString();
    }
  }

  Future<List<Nota>> listarNotasPorRestaurante(String idRestaurante) async {
    List<Nota> notas = [];
    final SupabaseService supabaseService = SupabaseService();
    SupabaseClient cliente = supabaseService.client;
    try {
      final data = await cliente.from("nota")
          .select('''id_nota, nombre:id_usuario(nombre), descrpcion, calificacion''')
          .eq("id_restaurante", idRestaurante);
      if (data.isNotEmpty) {
        for (var i in data) {
          Map<String, dynamic> dato = i;
          Nota nota = Nota(dato["id_nota"], dato["nombre"], dato["descripcion"], dato["calificacion"]);
          notas.add(nota);
        }
        return notas;
      } else {
        return notas;
      }
    } catch (e) {
      debugPrint(e.toString());
      return notas;
    }
  }

}