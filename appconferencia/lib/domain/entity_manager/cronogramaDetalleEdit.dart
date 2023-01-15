// ignore_for_file: camel_case_types, file_names

class cronogramaDetalleEdit {
  final String evento;
  final String cronograma;
  final String cronogramadetalle;
  final String textocronograma;
  final int duracionmin;
  final String usuario;
  final String ponente;
  final String area;
  final String horaInicio;
  final String horabase;
  final String horafinal;
  final String avisos;
  final String descripcioncronograma;
  final String detallesespecificos;
  final String linkvideo;

  cronogramaDetalleEdit({
    required this.evento,
    required this.cronograma,
    required this.cronogramadetalle,
    required this.textocronograma,
    required this.duracionmin,
    required this.usuario,
    required this.ponente,
    required this.area,
    required this.horaInicio,
    required this.horabase,
    required this.horafinal,
    required this.avisos,
    required this.descripcioncronograma,
    required this.detallesespecificos,
    required this.linkvideo,
  });

  Map<String, dynamic> toJson() => {
        'evento': evento,
        'cronograma': cronograma,
        'cronogramadetalle': cronogramadetalle,
        'textocronograma': textocronograma,
        'duracionmin': duracionmin,
        'usuario': usuario,
        'ponente': ponente,
        'area': area,
        'horaInicio': horaInicio,
        'horabase': horabase,
        'horafinal': horafinal,
        'avisos': avisos,
        'descripcioncronograma': descripcioncronograma,
        'detallesespecificos': detallesespecificos,
        'linkvideo': linkvideo,
      };

  factory cronogramaDetalleEdit.fromJson(Map<String, dynamic> jsonData) {
    return cronogramaDetalleEdit(
      evento: jsonData['evento'],
      cronograma: jsonData['cronograma'],
      cronogramadetalle: jsonData['cronogramadetalle'],
      textocronograma: jsonData['textocronograma'],
      duracionmin: jsonData['duracionmin'],
      usuario: jsonData['usuario'],
      ponente: jsonData['ponente'],
      area: jsonData['area'],
      horaInicio: jsonData['horaInicio'],
      horabase: jsonData['horabase'],
      horafinal: jsonData['horafinal'],
      avisos: jsonData['avisos'] ?? "",
      descripcioncronograma: jsonData['descripcioncronograma'],
      detallesespecificos: jsonData['detallesespecificos'] ?? "",
      linkvideo: jsonData['linkvideo'] ?? "",
    );
  }
}
