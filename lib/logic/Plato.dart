import 'package:flutter/cupertino.dart';
import 'package:unilunch/persistence/SupabaseConnection.dart';
import 'package:supabase/src/supabase_client.dart';
import 'package:unilunch/utils.dart';

class Plato {

  String idPlato;
  String nombre;
  String descripcion;
  int precio;
  int stock;
  String imagen;
  bool menuHoy;

  Plato(
      this.idPlato,
      this.nombre,
      this.descripcion,
      this.precio,
      this.stock,
      this.imagen,
      this.menuHoy
      );

  Plato.registrar(
      this.nombre,
      this.descripcion,
      this.precio,
      this.stock,
      this.imagen,
      ): idPlato = "", menuHoy = false;

  Plato.vacio(): idPlato = "", nombre = "", descripcion = "", precio = 0, stock = 0, imagen = "", menuHoy = false;

  Future<String> insertarPlato(String idRestaurante) async {
    final SupabaseService supabaseService = SupabaseService();
    SupabaseClient cliente = supabaseService.client;
    try {
      String id = randomDigits(10);
      await cliente
          .from("plato")
          .insert({"id_plato":id, "id_restaurante":idRestaurante, "nombre":nombre, "descripcion":descripcion, "imagen":imagen, "stock":0,
        "precio":precio, "menu_hoy": false});
      return "correcto";
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> actualizarStock(int nuevoStock) async {
    final SupabaseService supabaseService = SupabaseService();
    SupabaseClient cliente = supabaseService.client;
    try {
      await cliente
          .from("plato")
          .update({"stock":nuevoStock}).match({"id_plato":idPlato});
      stock = nuevoStock;
      return "correcto";
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> agregarMenu() async {
    final SupabaseService supabaseService = SupabaseService();
    SupabaseClient cliente = supabaseService.client;
    try {
      await cliente
          .from("plato")
          .update({"menu_hoy":true}).match({"id_plato":idPlato});
      return "correcto";
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> quitarMenu() async {
    final SupabaseService supabaseService = SupabaseService();
    SupabaseClient cliente = supabaseService.client;
    try {
      await cliente
          .from("plato")
          .update({"menu_hoy":false}).match({"id_plato":idPlato});
      return "correcto";
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> eliminarPlato() async {
    final SupabaseService supabaseService = SupabaseService();
    SupabaseClient cliente = supabaseService.client;
    try {
      await cliente.from('plato').delete().match({"id_plato": idPlato});
      return "correcto";
    } catch (e) {
      return e.toString();
    }
  }

  Future<List<Plato>> listarPlatoPorRestaurante(String idRestaurante) async {
    List<Plato> platos = [];
    final SupabaseService supabaseService = SupabaseService();
    SupabaseClient cliente = supabaseService.client;
    try {
      final data = await cliente.from("plato")
          .select()
          .eq("id_restaurante", idRestaurante)
          .order('nombre');
      if (data.isNotEmpty) {
        for (var i in data) {
          Map<String, dynamic> dato = i;
          Plato plato = Plato(dato["id_plato"], dato["nombre"], dato["descripcion"], dato["precio"], dato["stock"], dato["imagen"], dato["menu_hoy"]);
          platos.add(plato);
        }
        return platos;
      } else {
        return platos;
      }
    } catch (e) {
      debugPrint(e.toString());
      return platos;
    }
  }

  Future<List<Plato>> listarPlatoPorRestauranteMenuHoy(String idRestaurante) async {
    List<Plato> platos = [];
    final SupabaseService supabaseService = SupabaseService();
    SupabaseClient cliente = supabaseService.client;
    try {
      final data = await cliente.from("plato")
          .select()
          .eq("id_restaurante", idRestaurante)
          .eq("menu_hoy", true).order('nombre');
      if (data.isNotEmpty) {
        for (var i in data) {
          Map<String, dynamic> dato = i;
          Plato plato = Plato(dato["id_plato"], dato["nombre"], dato["descripcion"], dato["precio"], dato["stock"], dato["imagen"], dato["menu_hoy"]);
          platos.add(plato);
        }
        return platos;
      } else {
        return platos;
      }
    } catch (e) {
      debugPrint(e.toString());
      return platos;
    }
  }

  Future<Plato> listarPlatoPorId(String idPlato) async {
    Plato plato = Plato.vacio();
    final SupabaseService supabaseService = SupabaseService();
    SupabaseClient cliente = supabaseService.client;
    try {
      final data = await cliente.from("plato")
          .select()
          .eq("id_plato", idPlato);
      if (data.isNotEmpty) {
        Map<String, dynamic> dato = data[0];
        plato = Plato(dato["id_plato"], dato["nombre"], dato["descripcion"], dato["precio"], dato["stock"], dato["imagen"], dato["menu_hoy"]);
        return plato;
      } else {
        return plato;
      }
    } catch (e) {
      debugPrint(e.toString());
      return plato;
    }
  }

  Future<String> actualizarNombre(String nombre) async {
    final SupabaseService supabaseService = SupabaseService();
    SupabaseClient cliente = supabaseService.client;
    try {
      await cliente
          .from("plato")
          .update({"nombre":nombre}).match({"id_plato":idPlato});
      return "correcto";
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> actualizarDescripcion(String descripcion) async {
    final SupabaseService supabaseService = SupabaseService();
    SupabaseClient cliente = supabaseService.client;
    try {
      await cliente
          .from("plato")
          .update({"descripcion":descripcion}).match({"id_plato":idPlato});
      return "correcto";
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> actualizarPrecio(int precio) async {
    final SupabaseService supabaseService = SupabaseService();
    SupabaseClient cliente = supabaseService.client;
    try {
      await cliente
          .from("plato")
          .update({"precio":precio}).match({"id_plato":idPlato});
      return "correcto";
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> actualizarLogo(String logo) async {
    final SupabaseService supabaseService = SupabaseService();
    SupabaseClient cliente = supabaseService.client;
    try {
      await cliente
          .from("plato")
          .update({"imagen":logo}).match({"id_plato":idPlato});
      return "correcto";
    } catch (e) {
      return e.toString();
    }
  }

}