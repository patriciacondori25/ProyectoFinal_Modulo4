class CronogramaDetalle {
  final String cronogramaDetalle;
  final String hora;
  final String horaReal;
  final int principal;
  final String textoCronograma;

  CronogramaDetalle(
    this.cronogramaDetalle,
    this.hora,
    this.horaReal,
    this.principal,
    this.textoCronograma,
  );

  Map<String, dynamic> toJson() => {
        'cronogramaDetalle': cronogramaDetalle,
        'hora': hora,
        'horaReal': horaReal,
        'principal': principal,
        'textoCronograma': textoCronograma,
      };

  factory CronogramaDetalle.fromJson(Map<String, dynamic> jsonData) {
    return CronogramaDetalle(
      jsonData['cronogramaDetalle'],
      jsonData['hora'],
      jsonData['horaReal'],
      jsonData['principal'],
      jsonData['textoCronograma'],
    );
  }
}
