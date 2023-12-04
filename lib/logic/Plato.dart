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

  Plato(
      this.idPlato,
      this.nombre,
      this.descripcion,
      this.precio,
      this.stock,
      this.imagen
      );

  Plato.registrar(
      this.nombre,
      this.descripcion,
      this.precio,
      this.stock,
      this.imagen
      ): idPlato = "";

  Plato.vacio(): idPlato = "", nombre = "", descripcion = "", precio = 0, stock = 0, imagen = "";

  Future<String> insertarPlato(String idRestaurante) async {
    final SupabaseService supabaseService = SupabaseService();
    SupabaseClient cliente = supabaseService.client;
    try {
      String id = randomDigits(10);
      await cliente
          .from("plato")
          .insert({"id_plato":id, "id_restaurante":idRestaurante, "nombre":nombre, "descripcion":descripcion, "precio":precio, "imagen":imagen});
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
          .eq("id_restaurante", idRestaurante);
      if (data.isNotEmpty) {
        for (var i in data) {
          Map<String, dynamic> dato = i;
          Plato plato = Plato(dato["id_plato"], dato["nombre"], dato["descripcion"], dato["precio"], dato["stock"], dato["imagen"]);
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
        plato = Plato(dato["id_plato"], dato["nombre"], dato["descripcion"], dato["precio"], dato["stock"], dato["imagen"]);
        return plato;
      } else {
        return plato;
      }
    } catch (e) {
      debugPrint(e.toString());
      return plato;
    }
  }

}