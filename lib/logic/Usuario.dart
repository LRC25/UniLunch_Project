import 'package:flutter/cupertino.dart';
import 'package:unilunch/persistence/SupabaseConnection.dart';
import 'package:supabase/src/supabase_client.dart';
import 'package:unilunch/logic/Cliente.dart';
import 'package:unilunch/logic/Restaurante.dart';

import '../utils.dart';

class Usuario {

  String idUsuario;
  String nombre;
  String email;
  String tipoUsuario;

  Usuario (
      this.idUsuario,
      this.nombre,
      this.email,
      this.tipoUsuario
      );

  Usuario.vacio():
      idUsuario = '',
      nombre = '',
      email = '',
      tipoUsuario = ''
  ;

  Future<dynamic> login(String email, String contrasenna, ) async {
    final SupabaseService supabaseService = SupabaseService();
    SupabaseClient cliente = supabaseService.client;
    try {
      final data = await cliente
          .from('usuario')
          .select('''id_usuario,nombre,email,tipo_usuario''')
          .eq('email', email)
          .eq('contrasenna', contrasenna);
      if (data.isNotEmpty) {
        Map<String, dynamic> dato = data[0];
        if (dato["tipo_usuario"] == "Cliente") {
          Cliente usuario = Cliente(
              idUsuario: dato["id_usuario"],
              nombre: dato["nombre"],
              email: dato["email"],
              tipoUsuario: dato["tipo_usuario"]);
          return usuario;
        } else if (dato["tipo_usuario"] == "Restaurante") {
          final dataRestaurante = await cliente
              .from("restaurante")
              .select('''id_restaurante,nombre_restaurante,latitud,longitud,descripcion,direccion,hora_apertura,hora_cierre,imagen,nota_prom''')
              .eq("id_usuario", dato["id_usuario"]);
          if (dataRestaurante.isNotEmpty) {
            Map<String, dynamic> datoRestarante = dataRestaurante[0];
            Restaurante usuario = Restaurante(
                idUsuario: dato["id_usuario"],
                nombre: dato["nombre"],
                email: dato["email"],
                tipoUsuario: dato["tipo_usuario"],
                idRestaurante: datoRestarante["id_restaurante"],
                nombreRestaurante: datoRestarante["nombre_restaurante"],
                latitud: datoRestarante["latitud"].toDouble(),
                longitud: datoRestarante["longitud"].toDouble(),
                direccion: datoRestarante["direccion"],
                descripcion: datoRestarante["descripcion"],
                horaApertura: convertTime(datoRestarante["hora_apertura"]),
                horaCierre: convertTime(datoRestarante["hora_cierre"]),
                imagen: datoRestarante["imagen"],
                notaPromedio: datoRestarante["nota_prom"].toDouble());
            return usuario;
          } else {
            return "este usuario no es de tipo restaurante";
          }
        }
      } else {
        return "Usuario no econtrado";
      }
    } catch (e) {
      return e.toString();
    }
  }

}