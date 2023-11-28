import 'dart:ffi';
import 'package:unilunch/logic/Usuario.dart';
import 'package:unilunch/logic/Horario.dart';

class Restaurante extends Usuario {

  String ubicacion;
  String direccion;
  String descripcion;
  List<Horario> horario;
  String imagen;
  Float notaPromedio;


  Restaurante({
    required String idUsuario,
    required String nombre,
    required String email,
    required String tipoUsuario,
    required this.ubicacion,
    required this.direccion,
    required this.descripcion,
    required this.horario,
    required this.imagen,
    required this.notaPromedio
  }) : super(idUsuario, nombre, email, tipoUsuario);

}