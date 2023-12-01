import 'package:unilunch/logic/Plato.dart';
import 'package:unilunch/logic/Reserva.dart';
import 'package:unilunch/logic/Usuario.dart';
import 'package:unilunch/logic/Horario.dart';
import 'package:unilunch/logic/Nota.dart';
import 'package:flutter/cupertino.dart';
import 'package:unilunch/persistence/SupabaseConnection.dart';
import 'package:supabase/src/supabase_client.dart';
import '../utils.dart';

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

  Restaurante.registro({
    String idUsuario = "",
    required String nombre,
    required String email,
    required String tipoUsuario,
    required this.ubicacion,
    required this.direccion,
    required this.descripcion,
    required this.imagen
  }): idRestaurante = "", horario = [], notaPromedio = 0, super(idUsuario, nombre, email, tipoUsuario);

  Future<String> resgistrarRestaurante(String contrasenna) async {
    final SupabaseService supabaseService = SupabaseService();
    SupabaseClient cliente = supabaseService.client;
    try {
      String idUsuario = randomDigits(10);
      String idRestaurante = randomDigits(10);
      await cliente
          .from("usuario")
          .insert({"id_usuario":idUsuario, "nombre":nombre, "email":email, "contrasenna":contrasenna, "tipo_usuario":tipoUsuario});
      await cliente
          .from("restaurante")
          .insert({"id_restaurante":idRestaurante, "id_usuario":idUsuario, "ubicacion":ubicacion, "direccion":direccion,
        "descripcion":descripcion, "imagen":imagen, "nota_prom":0});
      return "correcto";
    } catch (e) {
      debugPrint(e.toString());
      return e.toString();
    }
  }

  Future<String> registrarPlato(String imagen, String nombre, int precio, String descripcion, int stock) async {
    try {
      Plato plato = Plato.registrar(nombre, descripcion, precio, stock, imagen);
      String response = await plato.insertarPlato(idRestaurante);
      if (response == "correcto"){
        return "correcto";
      } else {
        return response;
      }
    } catch (e) {
      debugPrint(e.toString());
      return e.toString();
    }
  }

  Future<String> actualizarStock(Plato plato, int nuevoStock) async {
    try {
      String response = await plato.actualizarStok(nuevoStock);
      if (response == "correcto"){
        return "correcto";
      } else {
        return response;
      }
    } catch (e) {
      debugPrint(e.toString());
      return e.toString();
    }
  }

  Future<List<Plato>> mostrarMenu() async {
    Plato plato = Plato.vacio();
    List<Plato> platos = [];
    try {
      platos = await plato.listarPlatoPorRestaurante(idRestaurante);
      return platos;
    } catch (e) {
      debugPrint(e.toString());
      return platos;
    }
  }

  Future<List<Reserva>> monitorearReserva() async {
    Reserva reserva = Reserva.vacio();
    List<Reserva> reservas = [];
    try {
      reservas = await reserva.listarNotasPorRestaurante(idRestaurante);
      return reservas;
    } catch (e) {
      debugPrint(e.toString());
      return reservas;
    }
  }

  Future<List<Nota>> mostrarNotas() async {
    Nota nota = Nota.vacio();
    List<Nota> notas = [];
    try {
      notas = await nota.listarNotasPorRestaurante(idRestaurante);
      return notas;
    } catch (e) {
      debugPrint(e.toString());
      return notas;
    }
  }

}
