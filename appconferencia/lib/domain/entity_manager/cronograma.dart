class Cronograma {
  final String area;
  final String cronograma;
  final int dia;
  final String hora;
  final String horaBase;
  final String horaReal;
  final String nombreDia;
  final int principal;
  final String textoCronograma;
  final String fecha;
  final String usuario;
  final int duracionMin;
  final String avisos;
  final String descripcionCronograma;
  final String detallesEspecificos;
  final String link;
  final int participantes;

  Cronograma(
      this.area,
      this.cronograma,
      this.dia,
      this.hora,
      this.horaBase,
      this.horaReal,
      this.nombreDia,
      this.principal,
      this.textoCronograma,
      this.fecha,
      this.usuario,
      this.duracionMin,
      this.avisos,
      this.descripcionCronograma,
      this.detallesEspecificos,
      this.link,
      this.participantes);

  Map<String, dynamic> toJson() => {
        'area': area,
        'cronograma': cronograma,
        'dia': dia,
        'hora': hora,
        'horaBase': horaBase,
        'horaReal': horaReal,
        'nombreDia': nombreDia,
        'principal': principal,
        'textoCronograma': textoCronograma,
        'fecha': fecha,
        'usuario': usuario,
        'duracionMin': duracionMin,
        'avisos': avisos,
        'descripcionCronograma': descripcionCronograma,
        'detallesEspecificos': detallesEspecificos,
        'link': link,
        'participantes': participantes,
      };

  factory Cronograma.fromJson(Map<String, dynamic> jsonData) {
    return Cronograma(
      jsonData['area'],
      jsonData['cronograma'],
      jsonData['dia'],
      jsonData['hora'],
      jsonData['horaBase'],
      jsonData['horaReal'],
      jsonData['nombreDia'],
      jsonData['principal'],
      jsonData['textoCronograma'],
      jsonData["fecha"],
      jsonData['usuario'],
      jsonData['duracionMin'],
      jsonData['avisos'],
      jsonData['descripcionCronograma'],
      jsonData['detallesEspecificos'],
      jsonData['link'],
      jsonData['participantes'],
    );
  }
}
