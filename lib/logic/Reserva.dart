import 'package:unilunch/logic/ReservaPlato.dart';
import 'package:flutter/cupertino.dart';
import 'package:unilunch/persistence/SupabaseConnection.dart';
import 'package:supabase/src/supabase_client.dart';
import 'package:unilunch/utils.dart';

class Reserva {

  String idReserva;
  String nombreUsuario;
  DateTime fecha;
  int total;
  List<ReservaPlato> platos;
  String estado;

  Reserva (
      this.idReserva,
      this.nombreUsuario,
      this.fecha,
      this.total,
      this.platos,
      this.estado
      );

  Reserva.registro (
      this.fecha,
      this.total,
      this.platos,
      this.estado
      ): idReserva = "", nombreUsuario = "";

  Reserva.vacio(): idReserva = "", nombreUsuario = "", fecha = DateTime(0), total = 0, platos = [], estado = "";

  Future<String> insertarReserva(String idUsuario, String idRestaurante) async {
    final SupabaseService supabaseService = SupabaseService();
    SupabaseClient cliente = supabaseService.client;
    try {
      String id = randomDigits(10);
      await cliente
          .from("reserva")
          .insert({"id_reserva":id, "id_restaurante":idRestaurante, "id_usuario":idUsuario, "fecha":convertDate(fecha), "precio":total});
      for (ReservaPlato plato in platos) {
        plato.insertarReservaPlato(id);
      }
      return "correcto";
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> eliminarReserva() async {
    final SupabaseService supabaseService = SupabaseService();
    SupabaseClient cliente = supabaseService.client;
    try {
      for (ReservaPlato plato in platos) {
        plato.eliminarReservaPlato();
      }
      await cliente.from('reserva').delete().match({"id_reserva": idReserva});
      return "correcto";
    } catch (e) {
      return e.toString();
    }
  }

  Future<List<Reserva>> listarResevaPendietePorRestaurante(String idRestaurante) async {
    List<Reserva> reservas = [];
    final SupabaseService supabaseService = SupabaseService();
    SupabaseClient cliente = supabaseService.client;
    try {
      final data = await cliente
          .from("reserva")
          .select(
          '''id_reserva, nombre:id_usuario(nombre), fecha, hora, precio, estado''')
          .eq("id_restaurante", idRestaurante)
          .eq("estado", "Pendiente");
      if (data.isNotEmpty) {
        for (var i in data) {
          Map<String, dynamic> dato = i;
          Map<String, dynamic> nombre = dato["nombre"];
          List<ReservaPlato> reservaPlatos = await ReservaPlato.vacio()
              .listarPorReserva(dato["id_reserva"]);
          Reserva reserva = Reserva(
              dato["id_reserva"], nombre["nombre"], converDateTime(dato["fecha"], dato["hora"]), dato["precio"],
              reservaPlatos, dato["estado"]);
          reservas.add(reserva);
        }
        return reservas;
      } else {
        return reservas;
      }
    } catch (e) {
      debugPrint(e.toString());
      return reservas;
    }
  }

  Future<List<Reserva>> listarResevaCompletaPorRestaurante(String idRestaurante) async {
    List<Reserva> reservas = [];
    final SupabaseService supabaseService = SupabaseService();
    SupabaseClient cliente = supabaseService.client;
    try {
      final data = await cliente
          .from("reserva")
          .select('''id_reserva, nombre:id_usuario(nombre), fecha, hora, precio, estado''')
          .eq("id_restaurante", idRestaurante)
          .neq("estado", "Pendiente");
      if (data.isNotEmpty) {
        for (var i in data) {
          Map<String, dynamic> dato = i;
          Map<String, dynamic> nombre = dato["nombre"];
          List<ReservaPlato> reservaPlatos = await ReservaPlato.vacio()
              .listarPorReserva(dato["id_reserva"]);
          Reserva reserva = Reserva(
              dato["id_reserva"], nombre["nombre"], converDateTime(dato["fecha"], dato["hora"]), dato["precio"],
              reservaPlatos, dato["estado"]);
          reservas.add(reserva);
        }
        return reservas;
      } else {
        return reservas;
      }
    } catch (e) {
      debugPrint(e.toString());
      return reservas;
    }
  }

  Future<String> completarReserva() async {
    final SupabaseService supabaseService = SupabaseService();
    SupabaseClient cliente = supabaseService.client;
    try {
      await cliente.from('reserva').update({"estado": "Completado"}).match({"id_reserva": idReserva});
      return "correcto";
    } catch (e) {
      return e.toString();
    }
  }

}