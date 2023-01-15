class cronogramaDetalleEdit_Actividad {
  final String evento;
  final String cronograma;
  final String cronogramadetalle;
  final String hora;
  final String horaReal;
  final String textocronograma;

  cronogramaDetalleEdit_Actividad(this.evento, this.cronograma,
      this.cronogramadetalle, this.hora, this.horaReal, this.textocronograma);

  Map<String, dynamic> toJson() => {
        'evento': evento,
        'cronograma': cronograma,
        'cronogramadetalle': cronogramadetalle,
        'hora': hora,
        'horaReal': horaReal,
        'textocronograma': textocronograma,
      };

  factory cronogramaDetalleEdit_Actividad.fromJson(
      Map<String, dynamic> jsonData) {
    return cronogramaDetalleEdit_Actividad(
      jsonData['evento'],
      jsonData['cronograma'],
      jsonData['cronogramadetalle'],
      jsonData['hora'],
      jsonData['horaReal'],
      jsonData['textocronograma'],
    );
  }
}
