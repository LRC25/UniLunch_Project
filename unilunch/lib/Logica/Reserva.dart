import 'dart:ffi';
import 'package:unilunch/Logica/ReservaPlato.dart';

class Reserva {

  String idReserva;
  String nombreUsuario;
  DateTime fecha;
  Float total;
  List<ReservaPlato> platos;
  String estado;

  Reserva (
      this.idReserva,
      this.nombreUsuario,
      this.fecha,
      this.total,
      this.platos,
      this.estado
      );

}