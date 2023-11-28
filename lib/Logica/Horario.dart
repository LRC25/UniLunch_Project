import 'package:flutter/cupertino.dart';
import 'package:unilunch/Persistencia/SupabaseConnection.dart';
import 'package:supabase/src/supabase_client.dart';

class Horario {

  String idHorario;
  String dia;
  DateTime horaApertura;
  DateTime horaCierre;

  Horario (
      this.idHorario,
      this.dia,
      this.horaApertura,
      this.horaCierre
      );

  Horario.vacio():
      idHorario = '',
      dia = '',
      horaApertura = DateTime(0),
      horaCierre = DateTime(0)
  ;
  
  Future<List<Horario>> listaHorariosPorRestaurante(String idRestaurante) async {
    List<Horario> horarios = [];
    final SupabaseService supabaseService = SupabaseService();
    SupabaseClient cliente = supabaseService.client;
    try {
      final data = await cliente.from("horario")
          .select()
          .eq("id_restaurante", idRestaurante);
      if (data.isNotEmpty) {
        for (var i in data) {
          Map<String, dynamic> dato = i;
          Horario horario = Horario(
              dato["id_horario"],
              dato["dia"],
              dato["hora_apertura"], // Arreglar
              dato["hora_cierre"]); // Arreglar
          horarios.add(horario);
        }
        return horarios;
      } else {
        return horarios;
      }
    } catch (e) {
      debugPrint(e.toString());
      return horarios;
    }
  }

}