// ignore_for_file: camel_case_types, file_names

import 'package:cloud_firestore/cloud_firestore.dart';

class deleteData {
  Future deleteCronogramaDetalle(
      String cronograma, String cronogramaDetalle, String evento) async {
    final docDetalleCronograma = FirebaseFirestore.instance
        .collection('evento')
        .doc(evento)
        .collection('cronograma')
        .doc(cronograma)
        .collection('cronogramaDetalle')
        .doc(cronogramaDetalle);

    await docDetalleCronograma.delete();
  }

  Future deleteCronograma(String cronograma, String evento) async {
    final docCronograma = FirebaseFirestore.instance
        .collection('evento')
        .doc(evento)
        .collection('cronograma')
        .doc(cronograma);

    await docCronograma.delete();
  }

  Future deleteEvento(String evento) async {
    final docEvento =
        FirebaseFirestore.instance.collection('evento').doc(evento);

    await docEvento.delete();
  }

  Future deleteUsuario(String usuario, String evento) async {
    final docUsuario =
        FirebaseFirestore.instance.collection('usuario').doc(usuario);

    await docUsuario.delete();
  }
}
