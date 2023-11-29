import 'package:unilunch/logic/Plato.dart';
import 'package:flutter/cupertino.dart';
import 'package:unilunch/persistence/SupabaseConnection.dart';
import 'package:supabase/src/supabase_client.dart';
import 'package:unilunch/utils.dart';

class ReservaPlato {

  String idReservaPlato;
  Plato plato;
  int cantidad;

  ReservaPlato(
      this.idReservaPlato,
      this.plato,
      this.cantidad
      );

  ReservaPlato.vacio(): idReservaPlato = "", plato = Plato.vacio(), cantidad = 0;

  ReservaPlato.registro(
      this.plato,
      this.cantidad
      ): idReservaPlato = "";

  Future<String> insertarReservaPlato(String idReserva) async {
    final SupabaseService supabaseService = SupabaseService();
    SupabaseClient cliente = supabaseService.client;
    try {
      String id = randomDigits(10);
      await cliente
          .from("reserva_plato")
          .insert({"id_reserva_plato":id, "id_reserva":idReserva, "id_plato":plato.idPlato, "cantidad":cantidad});
      return "correcto";
    } catch (e) {
      debugPrint(e.toString());
      return e.toString();
    }
  }

  Future<String> eliminarReservaPlato() async {
    final SupabaseService supabaseService = SupabaseService();
    SupabaseClient cliente = supabaseService.client;
    try {
      await cliente.from('reserva_plato').delete().match({"id_reserva_plato": idReservaPlato});
      return "correcto";
    } catch (e) {
      debugPrint(e.toString());
      return e.toString();
    }
  }

  Future<List<ReservaPlato>> listarPorReserva(String idReserva) async {
    List<ReservaPlato> reservaPlatos = [];
    final SupabaseService supabaseService = SupabaseService();
    SupabaseClient cliente = supabaseService.client;
    try {
      final data = await cliente
          .from("reserva_plato")
          .select()
          .eq("id_reserva", idReserva);
      if (data.isNotEmpty) {
        for (var i in data) {
          Map<String, dynamic> dato = i;
          Plato plato = await Plato.vacio().listarPlatoPorId(dato["id_plato"]);
          ReservaPlato reservaPlato = ReservaPlato(dato["id_reserva_plato"], plato, dato["cantidad"]);
          reservaPlatos.add(reservaPlato);
        }
        return reservaPlatos;
      } else {
        return reservaPlatos;
      }
    } catch (e) {
      debugPrint(e.toString());
      return reservaPlatos;
    }
  }

}