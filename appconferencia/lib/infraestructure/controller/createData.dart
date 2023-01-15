// ignore_for_file: camel_case_types, prefer_const_constructors, depend_on_referenced_packages, file_names

import 'package:appconferencia/domain/entity_manager/cronograma.dart';
import 'package:appconferencia/domain/entity_manager/cronogramaDetalle.dart';
import 'package:appconferencia/domain/entity_manager/cronogramaDetalleEdit.dart';
import 'package:appconferencia/domain/entity_manager/usuario.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class createData {
  Future<String> createCronogramaDetalle(
      String cronograma,
      String textoCronograma,
      String horainicio,
      String horaReal,
      String usuarioid,
      String evento) async {
    final docDetalleCronograma = FirebaseFirestore.instance
        .collection('evento')
        .doc(evento)
        .collection('cronograma')
        .doc(cronograma)
        .collection('cronogramaDetalle')
        .doc();

    final CronogramaDetalle cronogramaDetalle = CronogramaDetalle(
        docDetalleCronograma.id, horainicio, horaReal, 0, textoCronograma);
    await docDetalleCronograma.set(cronogramaDetalle.toJson());

    return docDetalleCronograma.id;
  }

  Future<Usuario> createUsuario(Usuario data) async {
    final docUsuario = FirebaseFirestore.instance.collection('usuario').doc();

    final usuario = Usuario(
      usuario: docUsuario.id,
      nombre: data.nombre,
      apellidoMaterno: data.apellidoMaterno,
      apellidoPaterno: data.apellidoPaterno,
      correo: data.correo,
      telefono: data.telefono,
      biografia: data.biografia,
      certificadogenerado: data.certificadogenerado,
      codigoInvitacion: data.codigoInvitacion,
      foto: data.foto,
      descripcionPuesto: data.descripcionPuesto,
      evento: data.evento,
      fechageneracioncert: data.fechageneracioncert,
      origenUsuario: data.origenUsuario,
      qr: data.qr,
      redSocial: data.redSocial,
      rolUsuario: data.rolUsuario,
      tipoUsuario: data.tipoUsuario,
      ubicacion: data.ubicacion,
    );

    await docUsuario.set(usuario.toJson());
    return usuario;
  }

  Future<Cronograma> createCronograma(
      String evento, cronogramaDetalleEdit data, String fecha) async {
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

    final docCronograma = FirebaseFirestore.instance
        .collection('evento')
        .doc(evento)
        .collection('cronograma')
        .doc();

    final cronograma = Cronograma(
        data.area,
        docCronograma.id,
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

    await docCronograma.set(cronograma.toJson());
    return cronograma;
  }
}
