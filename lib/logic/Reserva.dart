import 'package:unilunch/logic/ReservaPlato.dart';
import 'package:flutter/cupertino.dart';
import 'package:unilunch/persistence/SupabaseConnection.dart';
import 'package:supabase/src/supabase_client.dart';
import 'package:unilunch/utils.dart';

class Reserva {

  String idReserva;
  String nombreUsuario;
  String idRestaurante;
  String nombreRestaurante;
  String logoRestaurante;
  double notaRestaurante;
  DateTime fecha;
  int total;
  List<ReservaPlato> platos;
  String estado;
  bool estadoCalificacion;
  String nota;

  Reserva (
      this.idReserva,
      this.nombreUsuario,
      this.idRestaurante,
      this.nombreRestaurante,
      this.logoRestaurante,
      this.notaRestaurante,
      this.fecha,
      this.total,
      this.platos,
      this.estado,
      this.estadoCalificacion,
      this.nota
      );

  Reserva.registro (
      this.fecha,
      this.total,
      this.platos,
      ): idReserva = "", nombreUsuario = "", idRestaurante = "", nombreRestaurante = "", logoRestaurante = "",
        notaRestaurante = 0, estadoCalificacion = false, nota = "", estado = "";

  Reserva.cliente(
      this.idReserva,
      this.idRestaurante,
      this.nombreRestaurante,
      this.logoRestaurante,
      this.notaRestaurante,
      this.fecha,
      this.total,
      this.platos,
      this.estado,
      this.estadoCalificacion,
      this.nota
      ) : nombreUsuario = "";

  Reserva.restaurante(
      this.idReserva,
      this.nombreUsuario,
      this.fecha,
      this.total,
      this.platos,
      this.estado
      ) : idRestaurante = "", nombreRestaurante = "", logoRestaurante = "", notaRestaurante = 0, nota = "", estadoCalificacion = false;

  Reserva.vacio(): idReserva = "", idRestaurante = "", nombreUsuario = "", nombreRestaurante = "", logoRestaurante = "", notaRestaurante = 0,
        fecha = DateTime(0), total = 0, platos = [], estado = "", estadoCalificacion = false, nota = "";


  Future<String> insertarReserva(String idUsuario, String idRestaurante, DateTime hora) async {
    final SupabaseService supabaseService = SupabaseService();
    SupabaseClient cliente = supabaseService.client;
    final responseUsuario = await cliente.from("usuario").select('''id_usuario''').eq("id_usuario", idUsuario);
    if(responseUsuario.isNotEmpty) {
      final responseRestaurante = await cliente.from("restaurante").select('''id_restaurante''').eq("id_restaurante", idRestaurante);
      if(responseRestaurante.isNotEmpty) {
        if(total > 0) {
          DateTime actual = DateTime.now();
          if(fecha.year==actual.year && fecha.month==actual.month && fecha.day==actual.day) {
            final SupabaseService supabaseService = SupabaseService();
            SupabaseClient cliente = supabaseService.client;
            try {
              String id = randomDigits(10);
              await cliente
                  .from("reserva")
                  .insert({"id_reserva":id, "id_restaurante":idRestaurante, "id_usuario":idUsuario, "fecha":convertDate(fecha),
                "hora":convertTimeSQL(hora), "precio":total, "estado":"Pendiente", "estado_calificacion":false});
              for (ReservaPlato plato in platos) {
                plato.insertarReservaPlato(id);
                plato.plato.actualizarStock(plato.plato.stock-plato.cantidad);
              }
              return "correcto";
            } catch (e) {
              return e.toString();
            }
          } else {
            return "La fecha ingreseda no es la actual";
          }
        } else {
          return "Error El precio es un valor no esperado";
        }
      } else {
        return "Error este restaurante no existe";
      }
    } else {
      return "Error este usuario no existe";
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
          .eq("estado", "Pendiente")
          .order('fecha');
      if (data.isNotEmpty) {
        for (var i in data) {
          Map<String, dynamic> dato = i;
          Map<String, dynamic> nombre = dato["nombre"];
          List<ReservaPlato> reservaPlatos = await ReservaPlato.vacio()
              .listarPorReserva(dato["id_reserva"]);
          Reserva reserva = Reserva.restaurante(
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
          .neq("estado", "Pendiente")
          .order('fecha');
      if (data.isNotEmpty) {
        for (var i in data) {
          Map<String, dynamic> dato = i;
          Map<String, dynamic> nombre = dato["nombre"];
          List<ReservaPlato> reservaPlatos = await ReservaPlato.vacio()
              .listarPorReserva(dato["id_reserva"]);
          Reserva reserva = Reserva.restaurante(
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

  Future<List<Reserva>> listarResevaPendietePorCliente(String idCliente) async {
    List<Reserva> reservas = [];
    final SupabaseService supabaseService = SupabaseService();
    SupabaseClient cliente = supabaseService.client;
    try {
      final data = await cliente
          .from("reserva")
          .select(
          '''id_reserva, id_restaurante, nombre:id_restaurante(nombre_restaurante), logo:id_restaurante(imagen), nota_prom:id_restaurante(nota_prom),
          fecha, hora, precio, estado, estado_calificacion, nota:id_nota(calificacion)''')
          .eq("id_usuario", idCliente)
          .eq("estado", "Pendiente")
          .order('fecha');
      if (data.isNotEmpty) {
        for (var i in data) {
          Map<String, dynamic> dato = i;
          Map<String, dynamic> nombre = dato["nombre"];
          Map<String, dynamic> logo = dato["logo"];
          Map<String, dynamic> notaRestaurante = dato["nota_prom"];
          String nota;
          if(dato["nota"]==null){nota="";}else{Map<String, dynamic> notaDato = dato["nota"];nota=notaDato["calificacion"].toString();}
          List<ReservaPlato> reservaPlatos = await ReservaPlato.vacio()
              .listarPorReserva(dato["id_reserva"]);
          Reserva reserva = Reserva.cliente(
              dato["id_reserva"], dato["id_restaurante"], nombre["nombre_restaurante"], logo["imagen"], notaRestaurante["nota_prom"].toDouble(), converDateTime(dato["fecha"], dato["hora"]),
              dato["precio"], reservaPlatos, dato["estado"], dato["estado_calificacion"], nota);
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

  Future<List<Reserva>> listarResevaCompletaPorCliente(String idCliente) async {
    List<Reserva> reservas = [];
    final SupabaseService supabaseService = SupabaseService();
    SupabaseClient cliente = supabaseService.client;
    try {
      final data = await cliente
          .from("reserva")
          .select(
          '''id_reserva, id_restaurante, nombre:id_restaurante(nombre_restaurante), logo:id_restaurante(imagen), nota_prom:id_restaurante(nota_prom),
          fecha, hora, precio, estado, estado_calificacion, nota:id_nota(calificacion)''')
          .eq("id_usuario", idCliente)
          .neq("estado", "Pendiente")
          .order('fecha');
      if (data.isNotEmpty) {
        for (var i in data) {
          Map<String, dynamic> dato = i;
          Map<String, dynamic> nombre = dato["nombre"];
          Map<String, dynamic> logo = dato["logo"];
          Map<String, dynamic> notaRestaurante = dato["nota_prom"];
          String nota;
          if(dato["nota"]==null){nota="";}else{Map<String, dynamic> notaDato = dato["nota"];nota=notaDato["calificacion"].toString();}
          List<ReservaPlato> reservaPlatos = await ReservaPlato.vacio()
              .listarPorReserva(dato["id_reserva"]);
          Reserva reserva = Reserva.cliente(
              dato["id_reserva"], dato["id_restaurante"], nombre["nombre_restaurante"], logo["imagen"], notaRestaurante["nota_prom"].toDouble(), converDateTime(dato["fecha"], dato["hora"]),
              dato["precio"], reservaPlatos, dato["estado"], dato["estado_calificacion"], nota);
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

  Future<String> cancelarReserva() async {
    final SupabaseService supabaseService = SupabaseService();
    SupabaseClient cliente = supabaseService.client;
    try {
      await cliente.from('reserva').update({"estado": "Cancelado"}).match({"id_reserva": idReserva});
      for(ReservaPlato reservaPlato in this.platos){
        reservaPlato.plato.actualizarStock(reservaPlato.cantidad+reservaPlato.plato.stock);
      }
      return "correcto";
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> actualizarEstadoCalificacion(String idNota) async {
    final SupabaseService supabaseService = SupabaseService();
    SupabaseClient cliente = supabaseService.client;
    try {
      await cliente.from('reserva').update({"estado_calificacion": true, "id_nota": idNota}).match({"id_reserva": idReserva});
      return "correcto";
    } catch (e) {
      return e.toString();
    }
  }

}