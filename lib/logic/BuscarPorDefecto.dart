import 'package:flutter/cupertino.dart';
import 'package:unilunch/logic/BuscarRestaurante.dart';
import 'package:unilunch/logic/Restaurante.dart';
import 'package:unilunch/persistence/SupabaseConnection.dart';
import 'package:supabase/src/supabase_client.dart';

import '../utils.dart';

class BuscarPorDefecto implements BuscarRestaurante {

  @override
  Future<List<Restaurante>> buscarRerstaurante(dynamic entrada) async {
    final SupabaseService supabaseService = SupabaseService();
    SupabaseClient cliente = supabaseService.client;
    List<Restaurante> restaurantes = [];
    try {
      final dataRestaurante = await cliente
          .from("restaurante")
          .select('''id_restaurante,nombre_restaurante,ubicacion,descripcion,direccion,hora_apertura,hora_cierre,imagen,nota_prom''');
      if (dataRestaurante.isNotEmpty) {
        for(var i in dataRestaurante) {
          Map<String, dynamic> datoRestarante = i;
          Restaurante restaurante = Restaurante.cliente(
              idRestaurante: datoRestarante["id_restaurante"],
              nombreRestaurante: datoRestarante["nombre_restaurante"],
              latitud: datoRestarante["latitud"].toDobule(),
              longitud: datoRestarante["longitud"].toDobule(),
              direccion: datoRestarante["direccion"],
              descripcion: datoRestarante["descripcion"],
              horaApertura: convertTime(datoRestarante["hora_apertura"]),
              horaCierre: convertTime(datoRestarante["hora_cierre"]),
              imagen: datoRestarante["imagen"],
              notaPromedio: datoRestarante["nota_prom"].toDouble());
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