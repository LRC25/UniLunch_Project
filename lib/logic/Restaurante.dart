import 'package:unilunch/logic/Plato.dart';
import 'package:unilunch/logic/Reserva.dart';
import 'package:unilunch/logic/Usuario.dart';
import 'package:unilunch/logic/Nota.dart';
import 'package:flutter/cupertino.dart';
import 'package:unilunch/persistence/SupabaseConnection.dart';
import 'package:supabase/src/supabase_client.dart';
import '../utils.dart';

class Restaurante extends Usuario {

  String idRestaurante;
  String nombreRestaurante;
  String ubicacion;
  String direccion;
  String descripcion;
  DateTime horaApertura;
  DateTime horaCierre;
  String imagen;
  double notaPromedio;

  Restaurante({
    required String idUsuario,
    required String nombre,
    required String email,
    required String tipoUsuario,
    required this.idRestaurante,
    required this.nombreRestaurante,
    required this.ubicacion,
    required this.direccion,
    required this.descripcion,
    required this.horaApertura,
    required this.horaCierre,
    required this.imagen,
    required this.notaPromedio
  }) : super(idUsuario, nombre, email, tipoUsuario);

  Restaurante.registro({
    String idUsuario = "",
    required String nombre,
    required String email,
    required String tipoUsuario,
    required this.ubicacion,
    required this.nombreRestaurante,
    required this.direccion,
    required this.descripcion,
    required this.horaApertura,
    required this.horaCierre,
    required this.imagen
  }): idRestaurante = "", notaPromedio = 0, super(idUsuario, nombre, email, tipoUsuario);

  Restaurante.cliente({
    String idUsuario = "",
    String nombre = "",
    String email = "",
    String tipoUsuario = "",
    required this.idRestaurante,
    required this.ubicacion,
    required this.nombreRestaurante,
    required this.direccion,
    required this.descripcion,
    required this.horaApertura,
    required this.horaCierre,
    required this.imagen,
    required this.notaPromedio
  }) : super(idUsuario, nombre, email, tipoUsuario);

  Restaurante.vacio({
    String idUsuario = "",
    String nombre = "",
    String email = "",
    String tipoUsuario = ""
  }) : idRestaurante = "", ubicacion = "", nombreRestaurante = "", direccion = "", descripcion = "", horaApertura = DateTime(0),
        horaCierre = DateTime(0), imagen = "", notaPromedio = 0, super(idUsuario, nombre, email, tipoUsuario);

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
          .insert({"id_restaurante":idRestaurante, "id_usuario":idUsuario, "nombre_restaurante":nombreRestaurante,"ubicacion":ubicacion, "direccion":direccion,
        "descripcion":descripcion, "hora_apertura": convertTimeSQL(horaApertura), "hora_cierre": convertTimeSQL(horaCierre), "imagen":imagen, "nota_prom":0});
      return "correcto";
    } catch (e) {
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
      reservas = await reserva.listarResevaPendietePorRestaurante(idRestaurante);
      return reservas;
    } catch (e) {
      debugPrint(e.toString());
      return reservas;
    }
  }

  Future<List<Reserva>> monitorearReservaCompleta() async {
    Reserva reserva = Reserva.vacio();
    List<Reserva> reservas = [];
    try {
      reservas = await reserva.listarResevaCompletaPorRestaurante(idRestaurante);
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

  Future<String> actualizarPromedio(String idRestaurante) async {
    final SupabaseService supabaseService = SupabaseService();
    SupabaseClient cliente = supabaseService.client;
    num contar = 0;
    int lenght = 0;
    double prom = 0;
    try {
      final data = await cliente
          .from("nota").select("calificacion").eq("id_restaurante", idRestaurante);
      if (data.isNotEmpty) {
        for (var i in data) {
          Map<String, dynamic> dato = i;
          contar = contar + dato["calificacion"];
          lenght = lenght +1;
        }
        prom = contar/lenght;
        prom = double.parse(prom.toStringAsFixed(1));
      }
      await cliente.from("restaurante").update({"nota_prom":prom}).match({"id_restaurante":idRestaurante});
      return "correcto";
    } catch (e) {
      return e.toString();
    }
  }

}