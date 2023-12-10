// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:unilunch/logic/Nota.dart';
import 'package:unilunch/logic/Plato.dart';
import 'package:unilunch/logic/Reserva.dart';
import 'package:unilunch/logic/ReservaPlato.dart';

import 'package:unilunch/persistence/SupabaseConnection.dart';

void main() async {

  await SupabaseService().initialize();

  test('Agregar Calificacion', () async {
    List<String> esperado = [
      "Error La calificacion no esta dentro en lo esperado",
      "Error este restaurante no existe",
      "Error este usuario no existe",
      "Error La calificacion no esta dentro en lo esperado",
      "correcto"
    ];
    List<String> respuesta = [];
    respuesta.add(await Nota.resgistro("Descripcion de la calificacion", -15420)
        .insertarNota("0987654321", "1234567890", Reserva.vacio()));// Nota negativa
    respuesta.add(await Nota.resgistro("Descripcion de la calificacion", 5)
        .insertarNota("0000000000", "1234567890", Reserva.vacio()));// Usuario inexistente
    respuesta.add(await Nota.resgistro("Descripcion de la calificacion", 5)
        .insertarNota("0987654321", "0000000000", Reserva.vacio()));// Restaurante inexistente
    respuesta.add(await Nota.resgistro("Descripcion de la calificacion", 999999)
        .insertarNota("0987654321", "1234567890", Reserva.vacio()));// Nota fuera de rango
    respuesta.add(await Nota.resgistro("Descripcion de la calificacion", 5)
        .insertarNota("0987654321", "1234567890", Reserva.vacio()));// Insert correcto
    expect(respuesta, esperado);
  });

  test("Agregar Plato", () async {
    List<String> esperado = [
      "Error el stock de este plato es negativo",
      "Error este restaurante no existe",
      "Error el precio de este plato es negativo",
      "Error la imagen esta vacía",
      "correcto"
    ];
    List<String> respuesta = [];
    respuesta.add(await Plato.registrar("Carne", "Carne asada", 15000, -10, "imagen").insertarPlato("0987654321")); // Stock negativo
    respuesta.add(await Plato.registrar("Carne", "Carne asada", 15000, 10, "imagen").insertarPlato("0000000000")); // Restaurante inexistente
    respuesta.add(await Plato.registrar("Carne", "Carne asada", -15000, 10, "imagen").insertarPlato("0987654321")); // Precio negativo
    respuesta.add(await Plato.registrar("Carne", "Carne asada", 15000, 10, "").insertarPlato("0987654321")); // Imagen vacia
    respuesta.add(await Plato.registrar("Carne", "Carne asada", 15000, 10, "imagen").insertarPlato("0987654321")); //Insert correcto
    expect(respuesta, esperado);
  });

  test("Registrase como tipo de usuario cliente", () async {
    List<String> esperado = [
      "Error este restaurante no existe",
      "La fecha ingreseda no es la actual",
      "Error este usuario no existe",
      "Error El precio es un valor no esperado",
      "correcto"
    ];
    List<String> respuesta = [];
    List<ReservaPlato> platos = [];
    respuesta.add(await Reserva.registro(DateTime.now(), 20000, platos).insertarReserva("1234567890", "0000000000", DateTime(0,0,0,12,0,0))); // Restaurante Incorrecto
    respuesta.add(await Reserva.registro(DateTime(0), 20000, platos).insertarReserva("1234567890", "0987654321", DateTime(0,0,0,12,0,0))); // Fecha incorrecta
    respuesta.add(await Reserva.registro(DateTime.now(), 20000, platos).insertarReserva("0000000000", "0987654321", DateTime(0,0,0,12,0,0))); // Usuario Incorrecto
    respuesta.add(await Reserva.registro(DateTime.now(), -20000, platos).insertarReserva("1234567890", "0987654321", DateTime(0,0,0,12,0,0))); // Precio negativo
    respuesta.add(await Reserva.registro(DateTime.now(), 20000, platos).insertarReserva("1234567890", "0987654321", DateTime(0,0,0,12,0,0))); // Insert correcto
    expect(respuesta, esperado);
  });

}
