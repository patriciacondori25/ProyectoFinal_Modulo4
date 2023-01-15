// ignore_for_file: file_names

import 'package:shared_preferences/shared_preferences.dart';

class PreferenciasUsuario {
// await pref.getTokenNotificacion() ?? "";
//pref.setTokenNotificacion(tokenStr);
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  //static Future init() async => _prefs = (await SharedPreferences.getInstance()) as Future<SharedPreferences>;

  setCodigoUsuario(String codigoUsuario) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString('codigoUsuario', codigoUsuario);
  }

  getCodigoUsuario() async {
    final SharedPreferences prefs = await _prefs;
    String? intValue = prefs.getString('codigoUsuario');
    return intValue ?? 0;
  }

  setTokenNotificacion(String tokenNotificacion) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString('tokenNotificacion', tokenNotificacion);
  }

  getTokenNotificacion() async {
    final SharedPreferences prefs = await _prefs;
    String? strValue = prefs.getString('tokenNotificacion');
    return strValue ?? "";
  }

  setevento(String evento) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString('codigoevento', evento);
  }

  getevento() async {
    final SharedPreferences prefs = await _prefs;
    String? intValue = prefs.getString('codigoevento');
    return intValue ?? 0;
  }

  setTipoUsuario(String tipoUsuario) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString('tipoUsuario', tipoUsuario);
  }

  getTipoUsuario() async {
    final SharedPreferences prefs = await _prefs;
    String? intValue = prefs.getString('tipoUsuario');
    return intValue ?? 0;
  }

  setRolUsuario(String rolUsuario) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString('rolUsuario', rolUsuario);
  }

  getRolUsuario() async {
    final SharedPreferences prefs = await _prefs;
    String? intValue = prefs.getString('rolUsuario');
    return intValue ?? 0;
  }

  setFotoEventoPrincipal(String fotoEventoP) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString('fotoEventoP', fotoEventoP);
  }

  getFotoEventoPrincipal() async {
    final SharedPreferences prefs = await _prefs;
    String? intValue = prefs.getString('fotoEventoP');
    return intValue ?? 0;
  }

  setActivaNotificaciones(int notificaciones) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setInt('notificaciones', notificaciones);
  }

  getActivaNotificaciones() async {
    final SharedPreferences prefs = await _prefs;
    int? intValue = prefs.getInt('notificaciones');
    return intValue ?? 1;
  }

  setNombreEvento(String nombreEvento) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString('nombreEvento', nombreEvento);
  }

  getNombreEvento() async {
    final SharedPreferences prefs = await _prefs;
    String? intValue = prefs.getString('nombreEvento');
    return intValue ?? 0;
  }
}
