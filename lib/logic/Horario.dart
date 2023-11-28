class Horario {

  String idHorario;
  String dia;
  DateTime horaApertura;
  DateTime horaCierre;

  Horario (
      this.idHorario,
      this.dia,
      this.horaApertura,
      this.horaCierre
      );

  Horario.vacio():
      idHorario = '',
      dia = '',
      horaApertura = DateTime(0),
      horaCierre = DateTime(0)
  ;

}