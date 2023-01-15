// ignore_for_file: depend_on_referenced_packages

import 'dart:math';
import 'package:appconferencia/domain/entity_manager/listadoDias.dart';
import 'package:appconferencia/domain/entity_manager/usuario.dart';
import 'package:appconferencia/infraestructure/controller/createData.dart';
import 'package:appconferencia/infraestructure/controller/updateData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Procesos {
  List<ListadoDias> generaDias(DateTime fechaInicio) {
    List<ListadoDias> listaDias = [
      ListadoDias(nombreDia: "", dia: 1, fechacompleta: DateTime.now())
    ];
    listaDias.clear();

    for (int i = 0; i < 14; i++) {
      String diacadena = '';

      switch (DateFormat('EEEE').format(fechaInicio.add(Duration(days: i)))) {
        case 'Monday':
          diacadena = 'Lunes';
          break;
        case 'Tuesday':
          diacadena = 'Martes';
          break;
        case 'Wednesday':
          diacadena = 'Miercoles';
          break;
        case 'Thursday':
          diacadena = 'Jueves';
          break;
        case 'Friday':
          diacadena = 'Viernes';
          break;
        case 'Saturday':
          diacadena = 'Sabado';
          break;
        case 'Sunday':
          diacadena = 'Domingo';
          break;
      }

      listaDias.add(ListadoDias(
          nombreDia: diacadena,
          dia: fechaInicio.add(Duration(days: i)).day,
          fechacompleta: fechaInicio.add(Duration(days: i))));
    }

    return listaDias;
  }

  Future<Usuario> crearmodificarusuario(Usuario data) async {
    createData crear = createData();
    updateData actualizar = updateData();
    if (data.usuario == "") {
      return crear.createUsuario(data);
    } else {
      return await actualizar.updateUsuario(data);
    }
  }

  Future<String> generacodigoInvitacion(String evento) async {
    Random random = Random();
    int contador = 1;
    String number = "";
    while (contador != 0) {
      number = "";

      for (int i = 0; i < 6; i++) {
        number = number + random.nextInt(9).toString();
      }

      final usuarioCodigo = await FirebaseFirestore.instance
          .collection('usuario')
          .where("codigoInvitacion", isEqualTo: number)
          .get();

      List<Object?> listaparticipantes =
          usuarioCodigo.docs.map((DocumentSnapshot doc) {
        return doc.data();
      }).toList();

      List<Usuario> lista = listaparticipantes.map((ponente) {
        return Usuario.fromJson(ponente as Map<String, dynamic>);
      }).toList();

      contador = lista.length;
    }

    return number;
  }
}
