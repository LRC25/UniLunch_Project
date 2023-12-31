import 'package:flutter/cupertino.dart';
import 'package:unilunch/logic/BuscarRestaurante.dart';
import 'package:unilunch/logic/Restaurante.dart';
import 'package:unilunch/persistence/SupabaseConnection.dart';
import 'package:supabase/src/supabase_client.dart';

import '../utils.dart';

class BuscarPorNombre implements BuscarRestaurante {

  @override
  Future<List<Restaurante>> buscarRestaurante(dynamic entrada) async {
    final SupabaseService supabaseService = SupabaseService();
    SupabaseClient supabaseClient = supabaseService.client;
    List<Restaurante> restaurantes = [];
    try {
      final dataRestaurante = await supabaseClient
          .from("restaurante")
          .select('''id_restaurante,nombre_restaurante,latitud,longitud,direccion,descripcion,hora_apertura,hora_cierre,imagen,nota_prom''')
          .ilike('nombre_restaurante', '%$entrada%');
      if (dataRestaurante.isNotEmpty) {
        for(var i in dataRestaurante) {
          Map<String, dynamic> datoRestaurante = i;
          Restaurante restaurante = Restaurante.cliente(
              idRestaurante: datoRestaurante["id_restaurante"],
              nombreRestaurante: datoRestaurante["nombre_restaurante"],
              latitud: datoRestaurante["latitud"].toDouble(),
              longitud: datoRestaurante["longitud"].toDouble(),
              direccion: datoRestaurante["direccion"],
              descripcion: datoRestaurante["descripcion"],
              horaApertura: convertTime(datoRestaurante["hora_apertura"]),
              horaCierre: convertTime(datoRestaurante["hora_cierre"]),
              imagen: datoRestaurante["imagen"],
              notaPromedio: datoRestaurante["nota_prom"].toDouble());
          restaurantes.add(restaurante);
        }
      }
      return restaurantes;
    } catch (e) {
      debugPrint(e.toString());
      return restaurantes;
    }
  }

}