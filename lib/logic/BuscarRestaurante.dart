import 'package:unilunch/logic/Restaurante.dart';

abstract class BuscarRestaurante {
  Future<List<Restaurante>> buscarRestaurante(dynamic entrada);
}
