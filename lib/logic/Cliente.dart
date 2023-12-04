import 'package:unilunch/logic/Nota.dart';
import 'package:unilunch/logic/Reserva.dart';
import 'package:unilunch/logic/Usuario.dart';
import 'package:unilunch/logic/BuscarRestaurante.dart';
import 'package:unilunch/logic/Restaurante.dart';
import 'package:unilunch/logic/ReservaPlato.dart';
import 'package:flutter/cupertino.dart';
import 'package:unilunch/persistence/SupabaseConnection.dart';
import 'package:supabase/src/supabase_client.dart';

import '../utils.dart';

class Cliente extends Usuario {

  late BuscarRestaurante _buscarRestaurante;

  Cliente({
    required String idUsuario,
    required String nombre,
    required String email,
    required String tipoUsuario,
  }) : super(idUsuario, nombre, email, tipoUsuario);

  Cliente.registrar({
    String idUsuario = "",
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
      String idUsuario = randomDigits(10);
      await cliente
          .from("usuario")
          .insert({"id_usuario":idUsuario, "nombre":nombre, "email":email, "contrasenna":contrasenna, "tipo_usuario":tipoUsuario});
      return "correcto";
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> hacerReservar(DateTime fecha, int total, List<ReservaPlato> platos, String estado, String idRestaurante) async {
    try {
      Reserva reserva = Reserva.registro(fecha, total, platos, estado);
      String response = await reserva.insertarReserva(idUsuario, idRestaurante);
      if (response == "correcto"){
        return "correcto";
      } else {
        return response;
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> calificarRestaurante(String descripcion, int calificacion, Reserva reserva) async {
    try {
      Nota nota = Nota.resgistro(descripcion, calificacion);
      await nota.insertarNota(reserva.idRestaurante, idUsuario, reserva);
      Restaurante restaurante = Restaurante.vacio();
      String response = await restaurante.actualizarPromedio(reserva.idRestaurante);
      if (response=="correcto") {
        return "correcto";
      } else {
        return response;
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> eliminarCalificacion(Nota nota) async {
    try {
      String response = await nota.eliminarNota();
      if (response == "correcto"){
        return "correcto";
      } else {
        return response;
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<List<Reserva>> monitorearReserva() async {
    Reserva reserva = Reserva.vacio();
    List<Reserva> reservas = [];
    try {
      reservas = await reserva.listarResevaPendietePorCliente(idUsuario);
      return reservas;
    } catch (e) {
      debugPrint(e.toString());
      return reservas;
    }
  }

  Future<List<Reserva>> monitorearHistorial() async {
    Reserva reserva = Reserva.vacio();
    List<Reserva> reservas = [];
    try {
      reservas = await reserva.listarResevaCompletaPorCliente(idUsuario);
      return reservas;
    } catch (e) {
      debugPrint(e.toString());
      return reservas;
    }
  }

}
