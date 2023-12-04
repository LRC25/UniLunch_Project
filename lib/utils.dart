import 'dart:math';

String randomDigits(int length) {
  final random = Random();
  String result = '';
  for (int i = 0; i < length; i++) {
    int digit = random.nextInt(10);
    result += digit.toString();
  }
  return result;
}

String convertDate(DateTime fecha) {
  String fechaPostgres = "${fecha.year}/${fecha.month}/${fecha.day}";
  return fechaPostgres;
}

String convertTimeSQL(DateTime tiempo) {
  String tiempoPostgres = "${tiempo.hour}:${tiempo.minute}:${tiempo.second}";
  return tiempoPostgres;
}

DateTime converDateTime(String fecha, String hora) {
  List<String> partes = fecha.split('-');
  List<String> partesHora = hora.split(':');
  DateTime fechaDateTime = DateTime(int.parse(partes[0]), int.parse(partes[1]), int.parse(partes[2]),
      int.parse(partesHora[0]), int.parse(partesHora[1]), int.parse(partesHora[2]));
  return fechaDateTime;
}

DateTime convertTime(String hora) {
  List<String> partesHora = hora.split(':');
  return DateTime(0, 0, 0, int.parse(partesHora[0]), int.parse(partesHora[1]), int.parse(partesHora[2]));
}