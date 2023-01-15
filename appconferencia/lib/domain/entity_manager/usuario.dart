class Usuario {
  final String usuario;
  final String tipoUsuario;
  late final String rolUsuario;
  final String nombre;
  final String apellidoPaterno;
  final String apellidoMaterno;
  final String origenUsuario;
  final String descripcionPuesto;
  final String ubicacion;
  final String correo;
  final String redSocial;
  final String foto;
  final String biografia;
  final String telefono;
  final String codigoInvitacion;
  final String qr;
  final int certificadogenerado;
  final String fechageneracioncert;
  late final String evento;

  Usuario(
      {required this.usuario,
      required this.tipoUsuario,
      required this.rolUsuario,
      required this.nombre,
      required this.apellidoPaterno,
      required this.apellidoMaterno,
      required this.origenUsuario,
      required this.descripcionPuesto,
      required this.ubicacion,
      required this.correo,
      required this.redSocial,
      required this.foto,
      required this.biografia,
      required this.telefono,
      required this.codigoInvitacion,
      required this.qr,
      required this.certificadogenerado,
      required this.fechageneracioncert,
      required this.evento,
      required});

  Map<String, dynamic> toJson() => {
        'usuario': usuario,
        'tipoUsuario': tipoUsuario,
        'rolUsuario': rolUsuario,
        'nombre': nombre,
        'apellidoPaterno': apellidoPaterno,
        'apellidoMaterno': apellidoMaterno,
        'origenUsuario': origenUsuario,
        'descripcionPuesto': descripcionPuesto,
        'ubicacion': ubicacion,
        'correo': correo,
        'redSocial': redSocial,
        'foto': foto,
        'biografia': biografia,
        'telefono': telefono,
        'codigoInvitacion': codigoInvitacion,
        'qr': qr,
        'certificadogenerado': certificadogenerado,
        'fechageneracioncert': fechageneracioncert,
        'evento': evento,
      };

  static Usuario fromJson(Map<String, dynamic> json) => Usuario(
        usuario: json['usuario'],
        tipoUsuario: json['tipoUsuario'],
        rolUsuario: json['rolUsuario'],
        nombre: json['nombre'] ?? "",
        apellidoPaterno: json['apellidoPaterno'] ?? "",
        apellidoMaterno: json['apellidoMaterno'] ?? "",
        origenUsuario: json['origenUsuario'] ?? "",
        descripcionPuesto: json['descripcionPuesto'] ?? "",
        ubicacion: json['ubicacion'] ?? "",
        correo: json['correo'] ?? "",
        redSocial: json['redSocial'] ?? "",
        foto: json['foto'] ?? "",
        biografia: json['biografia'] ?? "",
        telefono: json['telefono'] ?? "",
        codigoInvitacion: json['codigoInvitacion'] ?? "",
        qr: json['qr'] ?? "",
        certificadogenerado: json['certificadogenerado'] ?? 0,
        fechageneracioncert:
            json['fechageneracioncert'] ?? DateTime.now().toString(),
        evento: json['evento'],
      );
}
