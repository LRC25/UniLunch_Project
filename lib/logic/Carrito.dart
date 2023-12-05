import 'ReservaPlato.dart';

class Carrito {

  List<ReservaPlato> platos;

  Carrito(
      this.platos
      );

  Carrito.vacio() : platos = [];

}