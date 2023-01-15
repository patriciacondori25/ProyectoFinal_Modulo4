class cronogramaDetalleVista {
  final String cronograma,
      usuario,
      cronogramadetalle,
      textocronograma,
      conferencista,
      area,
      hora,
      avisos,
      descripcioncronograma,
      detallesEspecificos,
      link;
  final int duracionmin, participantes;

  cronogramaDetalleVista(
      {required this.cronograma,
      required this.usuario,
      required this.cronogramadetalle,
      required this.textocronograma,
      required this.conferencista,
      required this.area,
      required this.hora,
      required this.avisos,
      required this.descripcioncronograma,
      required this.detallesEspecificos,
      required this.link,
      required this.duracionmin,
      required this.participantes});

  Map<String, dynamic> toJson() => {
        'cronograma': cronograma,
        'usuario': usuario,
        'cronogramadetalle': cronogramadetalle,
        'textocronograma': textocronograma,
        'conferencista': conferencista,
        'area': area,
        'hora': hora,
        'avisos': avisos,
        'descripcioncronograma': descripcioncronograma,
        'detallesEspecificos': detallesEspecificos,
        'link': link,
        'duracionmin': duracionmin,
        'participantes': participantes,
      };

  factory cronogramaDetalleVista.fromJson(Map<String, dynamic> jsonData) {
    return cronogramaDetalleVista(
      cronograma: jsonData['cronograma'],
      usuario: jsonData['usuario'],
      cronogramadetalle: jsonData['cronogramadetalle'],
      textocronograma: jsonData['textocronograma'],
      conferencista: jsonData['conferencista'],
      area: jsonData['area'],
      hora: jsonData['hora'],
      avisos: jsonData['avisos'],
      descripcioncronograma: jsonData['descripcioncronograma'],
      detallesEspecificos: jsonData['detallesEspecificos'],
      link: jsonData['link'],
      duracionmin: jsonData['duracionmin'],
      participantes: jsonData['participantes'],
    );
  }
}
