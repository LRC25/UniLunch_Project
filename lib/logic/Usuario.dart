import 'package:flutter/cupertino.dart';
import 'package:unilunch/persistence/SupabaseConnection.dart';
import 'package:supabase/src/supabase_client.dart';
import 'package:unilunch/logic/Cliente.dart';
import 'package:unilunch/logic/Restaurante.dart';
import 'package:unilunch/logic/Horario.dart';

class Usuario {

  String idUsuario;
  String nombre;
  String email;
  String tipoUsuario;

  Usuario (
      this.idUsuario,
      this.email,
      this.nombre,
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
          final dataRestarante = await cliente
              .from("restaurante")
              .select('''id_restaurante,ubicacion,descripcion,direccion,imagen,nota_prom''')
              .eq("id_usuario", dato["id_usuario"]);
          if (dataRestarante.isNotEmpty) {
            Map<String, dynamic> datoRestarante = dataRestarante[0];
            List<Horario> horarios = [];
            Horario horario = Horario.vacio();
            horarios = await horario.listaHorariosPorRestaurante(datoRestarante["id_restaurante"]);
            Restaurante usuario = Restaurante(
                idUsuario: dato["id_usuario"],
                nombre: dato["nombre"],
                email: dato["email"],
                tipoUsuario: dato["tipo_usuario"],
                idRestaurante: datoRestarante["id_restaurante"],
                ubicacion: datoRestarante["ubicacion"],
                direccion: datoRestarante["direccion"],
                descripcion: datoRestarante["descripcion"],
                horario: horarios,
                imagen: datoRestarante["imagen"],
                notaPromedio: datoRestarante["nota_prom"]);
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