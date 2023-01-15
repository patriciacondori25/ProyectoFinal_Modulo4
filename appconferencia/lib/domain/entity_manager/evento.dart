import 'package:cloud_firestore/cloud_firestore.dart';

class Evento {
  final String evento;
  final String fotoeventos;
  final String nombreevento, ubicacion;
  final DateTime fechainicio, fechafin;
  final String fotoeventop;
  final String descripcionevento, nombrecorto, rutaservidor;
  final String codigoEvento, correoContacto, telefonoContacto;
  final int activo;

  Evento(
      {required this.evento,
      required this.fotoeventos,
      required this.nombreevento,
      required this.ubicacion,
      required this.fechainicio,
      required this.fechafin,
      required this.fotoeventop,
      required this.descripcionevento,
      required this.nombrecorto,
      required this.rutaservidor,
      required this.codigoEvento,
      required this.correoContacto,
      required this.telefonoContacto,
      required this.activo});

  Map<String, dynamic> toJson() => {
        'evento': evento,
        'fotoeventos': fotoeventos,
        'nombreevento': nombreevento,
        'ubicacion': ubicacion,
        'fechainicio': fechainicio,
        'fechafin': fechafin,
        'fotoeventop': fotoeventop,
        'descripcionevento': descripcionevento,
        'nombrecorto': nombrecorto,
        'rutaservidor': rutaservidor,
        'codigoEvento': codigoEvento,
        'correoContacto': correoContacto,
        'telefonoContacto': telefonoContacto,
        'activo': activo
      };

  factory Evento.fromJson(Map<String, dynamic> jsonData) {
    return Evento(
      evento: jsonData['evento'],
      fotoeventos: jsonData['fotoeventos'],
      nombreevento: jsonData['nombreevento'],
      ubicacion: jsonData["ubicacion"],
      fechainicio: (jsonData["fechainicio"] as Timestamp).toDate(),
      fechafin: (jsonData["fechafin"] as Timestamp).toDate(),
      fotoeventop: jsonData["fotoeventop"],
      descripcionevento: jsonData["descripcionevento"],
      nombrecorto: jsonData["nombrecorto"],
      rutaservidor: jsonData["rutaservidor"],
      codigoEvento: jsonData["codigoEvento"],
      correoContacto: jsonData["correoContacto"],
      telefonoContacto: jsonData["telefonoContacto"],
      activo: jsonData["activo"],
    );
  }
}
