import 'package:unilunch/Logica/Usuario.dart';
import 'package:unilunch/Logica/BuscarRestaurante.dart';
import 'package:unilunch/Logica/Restaurante.dart';

class Cliente extends Usuario {

  late BuscarRestaurante _buscarRestaurante;

  Cliente({
    required String idUsuario,
    required String nombre,
    required String email,
    required String tipoUsuario,
  }) : super(idUsuario, nombre, email, tipoUsuario);

  void setBuscarRestaurante(BuscarRestaurante buscarRestaurante) {
    _buscarRestaurante = buscarRestaurante;
  }

  List<Restaurante> applyBuscarRestaurante(dynamic entrada) {
    return _buscarRestaurante.buscarRerstaurante(entrada);
  }

}