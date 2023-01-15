// ignore_for_file: camel_case_types, file_names

class ponentesHabilitados {
  final String usuario;
  final String nombre;
  final String apellidopaterno;
  final String apellidomaterno;
  final String nombrecompleto;
  final String evento;

  ponentesHabilitados({
    required this.usuario,
    required this.nombre,
    required this.apellidopaterno,
    required this.apellidomaterno,
    required this.nombrecompleto,
    required this.evento,
  });

  Map<String, dynamic> toJson() => {
        'usuario': usuario,
        'nombre': nombre,
        'apellidopaterno': apellidopaterno,
        'apellidomaterno': apellidomaterno,
        'nombrecompleto': nombrecompleto,
        'evento': evento,
      };

  factory ponentesHabilitados.fromJson(Map<String, dynamic> jsonData) {
    return ponentesHabilitados(
      usuario: jsonData['usuario'],
      nombre: jsonData['nombre'],
      apellidopaterno: jsonData['apellidopaterno'],
      apellidomaterno: jsonData['apellidomaterno'],
      nombrecompleto: jsonData['nombrecompleto'],
      evento: jsonData['evento'],
    );
  }
}
