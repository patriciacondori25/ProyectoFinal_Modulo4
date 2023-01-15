// ignore_for_file: file_names

class CronogramaEvento {
  final String evento;
  final String cronograma;
  final String cronogramaDetalle;
  final String nombreEvento;
  final String fecha;
  final String nombreDia;
  final int dia;
  final String horaBase;
  final String hora;
  final int principal;
  final String textoCronograma;
  final String area;
  final String horaReal;

  CronogramaEvento({
    required this.evento,
    required this.cronograma,
    required this.cronogramaDetalle,
    required this.nombreEvento,
    required this.fecha,
    required this.nombreDia,
    required this.dia,
    required this.horaBase,
    required this.hora,
    required this.principal,
    required this.textoCronograma,
    required this.area,
    required this.horaReal,
  });

  Map<String, dynamic> toJson() => {
        'evento': evento,
        'cronograma': cronograma,
        'cronogramaDetalle': cronogramaDetalle,
        'nombreEvento': nombreEvento,
        'fecha': fecha,
        'nombreDia': nombreDia,
        'dia': dia,
        'horaBase': horaBase,
        'hora': hora,
        'principal': principal,
        'textoCronograma': textoCronograma,
        'area': area,
        'horaReal': horaReal,
      };

  factory CronogramaEvento.fromJson(Map<String, dynamic> jsonData) {
    return CronogramaEvento(
      evento: jsonData['evento'],
      cronograma: jsonData['cronograma'],
      cronogramaDetalle: jsonData['cronogramaDetalle'],
      nombreEvento: jsonData['nombreEvento'],
      fecha: jsonData['fecha'],
      nombreDia: jsonData['nombreDia'],
      dia: jsonData['dia'],
      horaBase: jsonData['horaBase'],
      hora: jsonData['hora'],
      principal: jsonData['principal'],
      textoCronograma: jsonData['textoCronograma'],
      area: jsonData['area'],
      horaReal: jsonData['horaReal'],
    );
  }
}
