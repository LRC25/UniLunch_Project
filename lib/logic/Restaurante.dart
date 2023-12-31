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
  double latitud;
  double longitud;
  String direccion;
  String descripcion;
  DateTime horaApertura;
  DateTime horaCierre;
  String imagen;
  double notaPromedio;

  Restaurante({
    required String idUsuario,
    required String nombre,
    required String contrasenna,
    required String email,
    required String tipoUsuario,
    required this.idRestaurante,
    required this.nombreRestaurante,
    required this.latitud,
    required this.longitud,
    required this.direccion,
    required this.descripcion,
    required this.horaApertura,
    required this.horaCierre,
    required this.imagen,
    required this.notaPromedio
  }) : super(idUsuario, nombre, email, tipoUsuario, contrasenna);

  Restaurante.registro({
    String idUsuario = "",
    required String nombre,
    required String email,
    required String tipoUsuario,
    required String contrasenna,
    required this.latitud,
    required this.longitud,
    required this.nombreRestaurante,
    required this.direccion,
    required this.descripcion,
    required this.horaApertura,
    required this.horaCierre,
    required this.imagen
  }): idRestaurante = "", notaPromedio = 0, super(idUsuario, nombre, email, tipoUsuario, contrasenna);

  Restaurante.cliente({
    String idUsuario = "",
    String nombre = "",
    String email = "",
    String tipoUsuario = "",
    String contrasenna = "",
    required this.idRestaurante,
    required this.nombreRestaurante,
    required this.latitud,
    required this.longitud,
    required this.direccion,
    required this.descripcion,
    required this.horaApertura,
    required this.horaCierre,
    required this.imagen,
    required this.notaPromedio
  }) : super(idUsuario, nombre, email, tipoUsuario, contrasenna);

  Restaurante.vacio({
    String idUsuario = "",
    String nombre = "",
    String email = "",
    String tipoUsuario = "",
    String contrasenna = ""
  }) : idRestaurante = "", latitud = 0, longitud = 0, nombreRestaurante = "", direccion = "", descripcion = "", horaApertura = DateTime(0),
        horaCierre = DateTime(0), imagen = "", notaPromedio = 0, super(idUsuario, nombre, email, tipoUsuario, contrasenna);

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
          .insert({"id_restaurante":idRestaurante, "id_usuario":idUsuario, "nombre_restaurante":nombreRestaurante,"latitud": latitud, "longitud":longitud,
        "direccion":direccion, "descripcion":descripcion, "hora_apertura": convertTimeSQL(horaApertura), "hora_cierre": convertTimeSQL(horaCierre),
        "imagen":imagen, "nota_prom":0});
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
      String response = await plato.actualizarStock(nuevoStock);
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

  Future<List<Plato>> mostrarMenuHoy() async {
    Plato plato = Plato.vacio();
    List<Plato> platos = [];
    try {
      platos = await plato.listarPlatoPorRestauranteMenuHoy(idRestaurante);
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

static Future<int> actualizarDescripcion(String campo, String idRestaurante) async {
    final SupabaseService supabaseService = SupabaseService();
    SupabaseClient cliente = supabaseService.client;
    try {
      await cliente
          .from('restaurante')
          .update({'descripcion': campo}).match({'id_restaurante': idRestaurante});
      debugPrint("Correcto, cambio de contraseña realizado");
      return 1;
    } catch (e) {
      debugPrint(e.toString());
      return 0;
    }
  }

  static Future<int> actualizarNombre(String campo, String idUsuario) async {
    final SupabaseService supabaseService = SupabaseService();
    SupabaseClient cliente = supabaseService.client;
    try {
      await cliente
          .from('usuario')
          .update({'nombre': campo}).match({'id_usuario': idUsuario});

      debugPrint("Correcto, cambio de nombre realizado");
      return 1;
    } catch (e) {
      debugPrint(e.toString());
      return 0;
    }
  }

  static Future<int> actualizarNombreRestaurante(String campo, String idRestaurante) async {
    final SupabaseService supabaseService = SupabaseService();
    SupabaseClient cliente = supabaseService.client;
    try {
      await cliente
          .from('restaurante')
          .update({'nombre_restaurante': campo}).match({'id_restaurante': idRestaurante});
      debugPrint("Correcto, se ha cambiado el nombre del restaurante");
      return 1;
    } catch (e) {
      debugPrint(e.toString());
      return 0;
    }
  }


  static Future<int> actualizarDireccion(String direccion, double latitud, double longitud, String idRestaurante) async {
    final SupabaseService supabaseService = SupabaseService();
    SupabaseClient cliente = supabaseService.client;

    try {
      await cliente
          .from('restaurante')
          .update({'direccion': direccion, 'latitud': latitud, 'longitud': longitud}).match({'id_restaurante': idRestaurante});
      debugPrint("Correcto, se ha cambiado la dirección del restaurante");
      return 1;
    } catch (e) {
      debugPrint(e.toString());
      return 0;
    }
  }

  static Future<int> actualizarEmail(String campo, String idUsuario) async {
    final SupabaseService supabaseService = SupabaseService();
    SupabaseClient cliente = supabaseService.client;
    try {
      await cliente
          .from('usuario')
          .update({'email': campo}).match({'id_usuario': idUsuario});
      debugPrint("Correcto, se ha cambiado el correo");
      return 1;
    } catch (e) {
      debugPrint(e.toString());
      return 0;
    }
  }

  static Future<int> actualizarContrasena(String campo, String idUsuario) async {
    final SupabaseService supabaseService = SupabaseService();
    SupabaseClient cliente = supabaseService.client;
    try {
      await cliente
          .from('usuario')
          .update({'contrasenna': campo}).match({'id_usuario': idUsuario});
      debugPrint("Correcto, se ha cambiado la contraseña");
      return 1;
    } catch (e) {
      debugPrint(e.toString());
      return 0;
    }
  }

  static Future<int> actualizarHoraApertura(campo, String idR) async {
    final SupabaseService supabaseService = SupabaseService();
    SupabaseClient cliente = supabaseService.client;
    try {
      await cliente
          .from('restaurante')
          .update({'hora_apertura': convertTimeSQL(campo)}).match({'id_restaurante': idR});
      debugPrint("Correcto, se ha cambiado la hora de apertura");
      return 1;
    } catch (e) {
      debugPrint(e.toString());
      return 0;
    }
  }

  static Future<int> actualizarHoraCierre(campo, String idR) async {
    final SupabaseService supabaseService = SupabaseService();
    SupabaseClient cliente = supabaseService.client;
    try {
      await cliente
          .from('restaurante')
          .update({'hora_cierre': convertTimeSQL(campo)}).match({'id_restaurante': idR});
      debugPrint("Correcto, se ha cambiado la hora de cierre");
      return 1;
    } catch (e) {
      debugPrint(e.toString());
      return 0;
    }
  }
}



