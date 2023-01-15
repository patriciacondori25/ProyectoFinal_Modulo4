// ignore_for_file: file_names, camel_case_types, depend_on_referenced_packages

import 'package:appconferencia/domain/entity_manager/cronograma.dart';
import 'package:appconferencia/domain/entity_manager/cronogramaDetalleEdit.dart';
import 'package:appconferencia/domain/entity_manager/usuario.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:intl/intl.dart';

class updateData {
  Future<Usuario> updateUsuario(Usuario data) async {
    var docUsuario = FirebaseFirestore.instance.collection('usuario');
    docUsuario.doc(data.usuario).update(data.toJson());
    return data;
  }

  Future<Cronograma> updateCronograma(
      cronogramaDetalleEdit data, String fecha) async {
    DateTime formatohora = DateFormat("yyyy-MM-dd").parse(fecha);

    String name = DateFormat('EEEE').format(formatohora);

    switch (name) {
      case 'Monday':
        {
          name = 'Lunes';
        }
        break;
      case 'Tuesday':
        {
          name = 'Martes';
        }
        break;
      case 'Wednesday':
        {
          name = 'Miercoles';
        }
        break;
      case 'Thursday':
        {
          name = 'Jueves';
        }
        break;
      case 'Friday':
        {
          name = 'Viernes';
        }
        break;
      case 'Saturday':
        {
          name = 'Sabado';
        }
        break;
      case 'Sunday':
        {
          name = 'Dominigo';
        }
        break;
    }

    final cronograma = Cronograma(
        data.area,
        data.cronograma,
        formatohora.day,
        data.horaInicio, //hora
        data.horaInicio, //horabase
        data.horabase, //horaReal
        name,
        1,
        data.textocronograma,
        fecha,
        data.usuario,
        data.duracionmin,
        data.avisos,
        data.descripcioncronograma,
        data.detallesespecificos,
        data.linkvideo,
        0);

    var docCronograma = FirebaseFirestore.instance
        .collection('evento')
        .doc(data.evento)
        .collection('cronograma');

    docCronograma.doc(data.cronograma).update(cronograma.toJson());

    return cronograma;
  }
}
