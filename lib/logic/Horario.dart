import 'package:flutter/cupertino.dart';
import 'package:unilunch/persistence/SupabaseConnection.dart';
import 'package:supabase/src/supabase_client.dart';
import 'package:unilunch/utils.dart';

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

  Horario.resgistrar (
      this.dia,
      this.horaApertura,
      this.horaCierre
      ): idHorario = "";

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
              converDateTime("00-00-00" ,dato["hora_apertura"]),
              converDateTime("00-00-00", dato["hora_cierre"]));
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

  Future<String> insertarHorario(String idRestaurante) async {
    final SupabaseService supabaseService = SupabaseService();
    SupabaseClient cliente = supabaseService.client;
    try {
      String id = randomDigits(10);
      await cliente
          .from("horario")
          .insert({"id_horario":id, "id_restaurante":idRestaurante, "dia":dia, "hora_apertura":horaApertura, "hora_cierre":horaCierre});
      return "correcto";
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> eliminarHoraio() async {
    final SupabaseService supabaseService = SupabaseService();
    SupabaseClient cliente = supabaseService.client;
    try {
      await cliente.from('horario').delete().match({"id_horario": idHorario});
      return "correcto";
    } catch (e) {
      return e.toString();
    }
  }

}