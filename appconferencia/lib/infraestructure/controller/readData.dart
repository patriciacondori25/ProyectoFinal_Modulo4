// ignore_for_file: camel_case_types, non_constant_identifier_names, depend_on_referenced_packages, file_names

import 'package:appconferencia/domain/entity_manager/cronograma.dart';
import 'package:appconferencia/domain/entity_manager/cronogramaDetalle.dart';
import 'package:appconferencia/domain/entity_manager/cronogramaDetalleEdit.dart';
import 'package:appconferencia/domain/entity_manager/cronogramaDetalleEdit_Actividad.dart';
import 'package:appconferencia/domain/entity_manager/cronogramaDetalleVista.dart';
import 'package:appconferencia/domain/entity_manager/cronogramaEvento.dart';
import 'package:appconferencia/domain/entity_manager/evento.dart';
import 'package:appconferencia/domain/entity_manager/ponentesHabilitados.dart';
import 'package:appconferencia/domain/entity_manager/usuario.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class readData {
  Stream<List<Evento>> readEventos() {
    Stream<List<Evento>> a = FirebaseFirestore.instance
        .collection('evento')
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Evento.fromJson(doc.data())).toList());

    return a;
  }

  Future<Evento> datosEvento(String evento) async {
    final a = await FirebaseFirestore.instance
        .collection('evento')
        .where("evento", isEqualTo: evento)
        .get();

    List<Object?> list = a.docs.map((DocumentSnapshot doc) {
      return doc.data();
    }).toList();

    Evento event = Evento.fromJson(list[0] as Map<String, dynamic>);

    return event;
  }

  Future<Usuario> cargarUsuario(String idusuario, String idevento) async {
    final a = await FirebaseFirestore.instance
        .collection('usuario')
        .where("usuario", isEqualTo: idusuario)
        .where("evento", isEqualTo: idevento)
        .get();

    List<Object?> list = a.docs.map((DocumentSnapshot doc) {
      return doc.data();
    }).toList();

    if (list.isEmpty == false) {
      Usuario user = Usuario.fromJson(list[0] as Map<String, dynamic>);

      return user;
    } else {
      final b = await FirebaseFirestore.instance
          .collection('usuario')
          .where("usuario", isEqualTo: idusuario)
          .get();

      List<Object?> list2 = b.docs.map((DocumentSnapshot doc) {
        return doc.data();
      }).toList();

      Usuario user2 = Usuario.fromJson(list2[0] as Map<String, dynamic>);

      if (user2.rolUsuario == "Administrador") {
        return user2;
      }
    }

    return Usuario(
      usuario: '',
      tipoUsuario: '',
      rolUsuario: '',
      nombre: '',
      apellidoPaterno: '',
      apellidoMaterno: '',
      origenUsuario: '',
      descripcionPuesto: '',
      ubicacion: '',
      correo: '',
      redSocial: '',
      foto: '',
      biografia: '',
      telefono: '',
      codigoInvitacion: '',
      qr: '',
      certificadogenerado: 0,
      fechageneracioncert: '',
      evento: '',
    );
  }

  Future<Usuario> validarUsuario(String codigo, String evento) async {
    final a = await FirebaseFirestore.instance
        .collection('usuario')
        .where("codigoInvitacion", isEqualTo: codigo)
        .where("evento", isEqualTo: evento)
        .get();

    //await Future.delayed(const Duration(seconds: 2));

    List<Object?> list = a.docs.map((DocumentSnapshot doc) {
      return doc.data();
    }).toList();

    if (list.isNotEmpty) {
      Usuario user = Usuario.fromJson(list[0] as Map<String, dynamic>);

      return user;
    } else {
      var b = await FirebaseFirestore.instance
          .collection('usuario')
          .where("codigoInvitacion", isEqualTo: codigo)
          .get();

      List<Object?> list2 = b.docs.map((DocumentSnapshot doc) {
        return doc.data();
      }).toList();

      Usuario user2 = Usuario.fromJson(list2[0] as Map<String, dynamic>);

      if (user2.rolUsuario == "Administrador") {
        //user2.evento = evento;
        return user2;
      }
    }

    return Usuario(
      usuario: '',
      tipoUsuario: '',
      rolUsuario: '',
      nombre: '',
      apellidoPaterno: '',
      apellidoMaterno: '',
      origenUsuario: '',
      descripcionPuesto: '',
      ubicacion: '',
      correo: '',
      redSocial: '',
      foto: '',
      biografia: '',
      telefono: '',
      codigoInvitacion: '',
      qr: '',
      certificadogenerado: 0,
      fechageneracioncert: '',
      evento: '',
    );
  }

  /*Stream<List<Cronograma>> readCronograma(String evento) => FirebaseFirestore
      .instance
      .collection('evento')
      .doc(evento)
      .collection('cronograma')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Cronograma.fromJson(doc.data())).toList());*/

  Future<List<Cronograma>> readCronograma(String Evento, String fecha) async {
    final cronograma = await FirebaseFirestore.instance
        .collection('evento')
        .doc(Evento)
        .collection('cronograma')
        .where('fecha', isEqualTo: fecha)
        .get();

    List<Object?> listacronograma = cronograma.docs.map((DocumentSnapshot doc) {
      return doc.data();
    }).toList();

    List<Cronograma> lista = listacronograma.map((cronograma) {
      return Cronograma.fromJson(cronograma as Map<String, dynamic>);
    }).toList();

    return lista;
  }

  Future<List<CronogramaDetalle>> readCronogramaDetalle(
      String Evento, String cronograma) async {
    final cronogramaDetalle = await FirebaseFirestore.instance
        .collection('evento')
        .doc(Evento)
        .collection('cronograma')
        .doc(cronograma)
        .collection('cronogramaDetalle')
        .get();

    List<Object?> listacronogramaDetalle =
        cronogramaDetalle.docs.map((DocumentSnapshot doc) {
      return doc.data();
    }).toList();

    List<CronogramaDetalle> lista =
        listacronogramaDetalle.map((cronogramaDetalle) {
      return CronogramaDetalle.fromJson(
          cronogramaDetalle as Map<String, dynamic>);
    }).toList();

    return lista;
  }

  /* Stream<List<CronogramaDetalle>> readCronogramaDetalle(
          String evento, String cronograma) =>
      FirebaseFirestore.instance
          .collection('evento')
          .doc(evento)
          .collection('cronograma')
          .doc(cronograma)
          .collection('cronogramaDetalle')
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => CronogramaDetalle.fromJson(doc.data()))
              .toList());*/

  Future<List<CronogramaEvento>> cronogramaEvento(
      String evento, String fecha) async {
    Evento event = await datosEvento(evento);
    List<Cronograma> crono = await readCronograma(evento, fecha);

    List<CronogramaEvento> dataFinal = [
      CronogramaEvento(
          cronograma: "",
          cronogramaDetalle: "",
          area: "",
          dia: 0,
          evento: evento,
          fecha: "",
          hora: "",
          horaBase: "",
          horaReal: "",
          nombreDia: "",
          nombreEvento: "",
          principal: 0,
          textoCronograma: "")
    ];

    if (crono.isEmpty) {
    } else {
      dataFinal.clear();
      for (Cronograma cronograma in crono) {
        dataFinal.add(CronogramaEvento(
            cronograma: cronograma.cronograma,
            cronogramaDetalle: "",
            area: cronograma.area,
            dia: cronograma.dia,
            evento: evento,
            fecha: cronograma.fecha,
            hora: cronograma.hora,
            horaBase: cronograma.horaBase,
            horaReal: cronograma.horaReal,
            nombreDia: cronograma.nombreDia,
            nombreEvento: event.nombreevento,
            principal: 1,
            textoCronograma: cronograma.textoCronograma));

        List<CronogramaDetalle> cronoDetalle =
            await readCronogramaDetalle(evento, cronograma.cronograma);

        for (CronogramaDetalle cronogramaDetalle in cronoDetalle) {
          dataFinal.add(CronogramaEvento(
              cronograma: cronograma.cronograma,
              cronogramaDetalle: cronogramaDetalle.cronogramaDetalle,
              area: "",
              dia: cronograma.dia,
              evento: evento,
              fecha: cronograma.fecha,
              hora: cronogramaDetalle.hora,
              horaBase: cronograma.horaBase,
              horaReal: cronogramaDetalle.horaReal,
              nombreDia: cronograma.nombreDia,
              nombreEvento: event.nombreevento,
              principal: 0,
              textoCronograma: cronogramaDetalle.textoCronograma));
        }
      }
    }

    return dataFinal;
  }

  Future<cronogramaDetalleVista> readCronogramaDetalleVista(
      String evento, String cronograma) async {
    final cd = await FirebaseFirestore.instance
        .collection('evento')
        .doc(evento)
        .collection('cronograma')
        .doc(cronograma)
        .get();

    Cronograma data1 = Cronograma.fromJson(cd.data() as Map<String, dynamic>);

    final u = await FirebaseFirestore.instance
        .collection('usuario')
        .doc(data1.usuario)
        .get();

    Usuario data2 = Usuario.fromJson(u.data() as Map<String, dynamic>);

    DateTime horaInicial =
        DateFormat("hh:mm").parse(data1.hora.substring(0, 5));
    DateTime horaFinal = horaInicial.add(Duration(minutes: data1.duracionMin));
    String finalhour =
        "${DateFormat("hh:mm").format(horaInicial)} -${DateFormat("hh:mm").format(horaFinal)}";

    var b = await FirebaseFirestore.instance
        .collection('usuario')
        .where("evento", isEqualTo: evento)
        .where("tipoUsuario", isEqualTo: "Asistente")
        .get();

    List<Object?> list2 = b.docs.map((DocumentSnapshot doc) {
      return doc.data();
    }).toList();

    cronogramaDetalleVista dataFinal = cronogramaDetalleVista(
        area: data1.area,
        avisos: data1.avisos,
        conferencista:
            "${data2.apellidoPaterno} ${data2.apellidoMaterno}, ${data2.nombre}",
        cronograma: data1.cronograma,
        cronogramadetalle: "",
        descripcioncronograma: data1.descripcionCronograma,
        detallesEspecificos: data1.detallesEspecificos,
        duracionmin: data1.duracionMin,
        hora: finalhour,
        link: data1.link,
        participantes: list2.length,
        textocronograma: data1.textoCronograma,
        usuario: data1.usuario);

    return dataFinal;
  }

  Future<cronogramaDetalleEdit> readCronogramaDetalleEdit(
      String cronograma, String evento, String cronogramadetalle) async {
    if (cronograma != "") {
      final cr = await FirebaseFirestore.instance
          .collection('evento')
          .doc(evento)
          .collection('cronograma')
          .doc(cronograma)
          .get();

      Cronograma data1 = Cronograma.fromJson(cr.data() as Map<String, dynamic>);

      DateTime formatohora =
          DateFormat("hh:mm").parse(data1.horaReal.substring(0, 5));

      DateTime horaFinal =
          formatohora.add(Duration(minutes: data1.duracionMin));

      final u = await FirebaseFirestore.instance
          .collection('usuario')
          .doc(data1.usuario)
          .get();

      Usuario data2 = Usuario.fromJson(u.data() as Map<String, dynamic>);

      cronogramaDetalleEdit edit = cronogramaDetalleEdit(
          evento: evento,
          cronograma: cronograma,
          cronogramadetalle: cronograma,
          textocronograma: data1.textoCronograma,
          duracionmin: data1.duracionMin,
          usuario: data1.usuario,
          ponente:
              "${data2.apellidoPaterno} ${data2.apellidoMaterno}, ${data2.nombre}",
          area: data1.area,
          horaInicio: data1.horaReal,
          horabase: data1.horaBase,
          horafinal: horaFinal.toString().substring(11, 16),
          avisos: data1.avisos,
          descripcioncronograma: data1.descripcionCronograma,
          detallesespecificos: data1.detallesEspecificos,
          linkvideo: data1.link);

      return edit;
    } else {
      cronogramaDetalleEdit edit = cronogramaDetalleEdit(
          evento: "",
          cronograma: "",
          cronogramadetalle: "",
          textocronograma: "",
          duracionmin: 0,
          usuario: "",
          ponente: "",
          area: "",
          horaInicio: "00:00",
          horabase: "0:00 AM",
          horafinal: "00:00",
          avisos: "",
          descripcioncronograma: "",
          detallesespecificos: "",
          linkvideo: "");

      return edit;
    }
  }

  Future<List<ponentesHabilitados>> readPonentesHabilitados(
      String evento) async {
    List<ponentesHabilitados> datafinal = [];

    final ponentes = await FirebaseFirestore.instance
        .collection('usuario')
        .where("evento", isEqualTo: evento)
        .where("tipoUsuario", isEqualTo: "Ponente")
        .get();

    List<Object?> listaponentes = ponentes.docs.map((DocumentSnapshot doc) {
      return doc.data();
    }).toList();

    List<Usuario> lista = listaponentes.map((ponente) {
      return Usuario.fromJson(ponente as Map<String, dynamic>);
    }).toList();
    datafinal.add(ponentesHabilitados(
        usuario: "",
        nombre: "Seleccione un ponente",
        apellidopaterno: "",
        apellidomaterno: "",
        nombrecompleto: "${"Seleccione un ponente"} ${""} ${""}",
        evento: lista[0].evento));
    for (Usuario usuario in lista) {
      datafinal.add(ponentesHabilitados(
          usuario: usuario.usuario,
          nombre: usuario.nombre,
          apellidopaterno: usuario.apellidoPaterno,
          apellidomaterno: usuario.apellidoMaterno,
          nombrecompleto:
              "${usuario.apellidoPaterno} ${usuario.apellidoMaterno} ${usuario.nombre}",
          evento: usuario.evento));
    }

    return datafinal;
  }

  Future<List<cronogramaDetalleEdit_Actividad>> readCronogramaDetalleActividad(
      String evento, String cronograma, String fecha) async {
    List<cronogramaDetalleEdit_Actividad> datafinal = [];

    if (cronograma != "") {
      final cd = await FirebaseFirestore.instance
          .collection('evento')
          .doc(evento)
          .collection('cronograma')
          .doc(cronograma)
          .collection('cronogramaDetalle')
          // .where("fecha", isEqualTo: fecha)
          .get();

      List<Object?> lista = cd.docs.map((DocumentSnapshot doc) {
        return doc.data();
      }).toList();

      List<CronogramaDetalle> data1 = lista.map((cronograma) {
        return CronogramaDetalle.fromJson(cronograma as Map<String, dynamic>);
      }).toList();

      for (CronogramaDetalle x in data1) {
        datafinal.add(cronogramaDetalleEdit_Actividad(
          evento,
          cronograma,
          x.cronogramaDetalle,
          x.hora,
          x.horaReal,
          x.textoCronograma,
        ));
      }

      return datafinal;
    } else {
      datafinal.add(cronogramaDetalleEdit_Actividad(
        evento,
        cronograma,
        "",
        "00:00",
        "00:00",
        "",
      ));
      return datafinal;
    }
  }

// Metodo que devuelve el listado de usuarios para
// panalla de asistentes
  Future<List<Usuario>> listadoParticipantes(
      String evento, String tipoUsuario) async {
    final partcipantes = await FirebaseFirestore.instance
        .collection('usuario')
        .where("evento", isEqualTo: evento)
        .where("tipoUsuario", isEqualTo: tipoUsuario)
        .get();

    List<Object?> listaparticipantes =
        partcipantes.docs.map((DocumentSnapshot doc) {
      return doc.data();
    }).toList();

    List<Usuario> lista = listaparticipantes.map((ponente) {
      return Usuario.fromJson(ponente as Map<String, dynamic>);
    }).toList();

    return lista;
  }

  Future<List<Usuario>> getusuario(String usuario) async {
    final partcipantes = await FirebaseFirestore.instance
        .collection('usuario')
        .where("usuario", isEqualTo: usuario)
        .get();

    List<Object?> listaparticipantes =
        partcipantes.docs.map((DocumentSnapshot doc) {
      return doc.data();
    }).toList();

    List<Usuario> lista = listaparticipantes.map((ponente) {
      return Usuario.fromJson(ponente as Map<String, dynamic>);
    }).toList();

    return lista;
  }
}
