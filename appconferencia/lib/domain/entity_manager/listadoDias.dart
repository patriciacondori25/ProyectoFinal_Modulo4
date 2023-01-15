// ignore_for_file: file_names

class ListadoDias {
  final String nombreDia;
  final int dia;
  final DateTime fechacompleta;

  ListadoDias(
      {required this.nombreDia,
      required this.dia,
      required this.fechacompleta});

  Map<String, dynamic> toJson() => {
        'nombreDia': nombreDia,
        'dia': dia,
        'fechacompleta': fechacompleta.toIso8601String(),
      };

  factory ListadoDias.fromJson(Map<String, dynamic> jsonData) {
    return ListadoDias(
      nombreDia: jsonData['nombreDia'],
      dia: jsonData['dia'],
      fechacompleta: DateTime.parse(jsonData['fechacompleta']),
    );
  }
}
