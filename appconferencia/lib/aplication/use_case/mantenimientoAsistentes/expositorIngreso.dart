// ignore_for_file: file_names, library_private_types_in_public_api

import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import '../../../infraestructure/componentes/blueButton.dart';
import '../../../infraestructure/componentes/imageCard.dart';
import '../../../infraestructure/componentes/modales.dart';
import '../../../infraestructure/componentes/multimediaSelection.dart';
import '../../../infraestructure/componentes/preferenciasUsuario.dart';
import '../../../constants.dart';
import '../../../infraestructure/controller/deleteData.dart';
import '../../../infraestructure/controller/procesos.dart';
import '../../../infraestructure/controller/readData.dart';
import '../../../domain/entity_manager/usuario.dart';
import '../../../infraestructure/componentes/imagenprincipal.dart';

class ExpositorIngreso extends StatelessWidget {
  final String usuario;
  final String evento;
  final int edicion;
  final String imagenPrincipal;
  final String tipousuario;

  const ExpositorIngreso(
      {Key? key,
      required this.usuario,
      required this.evento,
      required this.imagenPrincipal,
      required this.edicion,
      required this.tipousuario})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(),
        body: Bodyexin(
          usuario: usuario,
          evento: evento,
          imagenPrincipal: imagenPrincipal,
          edicion: edicion,
          tipousuario: tipousuario,
        ));
  }

  AppBar buildAppBar() {
    return AppBar(
      centerTitle: true,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: const <Widget>[
          Text(
            "Expositor",
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class Bodyexin extends StatefulWidget {
  final String usuario;
  final String evento;
  final String imagenPrincipal;
  final int edicion;
  final String tipousuario;

  const Bodyexin(
      {Key? key,
      required this.usuario,
      required this.evento,
      required this.imagenPrincipal,
      required this.edicion,
      required this.tipousuario})
      : super(key: key);

  @override
  _BodyexinState createState() => _BodyexinState();
}

class _BodyexinState extends State<Bodyexin> {
  readData leerdatos = readData();

  Future<List<Usuario>> getUsuario(
      String usuario //, int tipousuario, int rolusuario
      ) async {
    var conectate = await leerdatos.getusuario(usuario);

    return conectate;
  }

  @override
  Widget build(BuildContext context) {
    // var conectate = ConVCurriculum(widget.usuario, widget.evento);
    Size size = MediaQuery.of(context).size;

    return Form(
        child: ListView(
      children: [
        ImagePrincipal(size: size, imagenPrincipal: widget.imagenPrincipal),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: size.width,
                child: const Text(
                  'Ponente',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              FutureBuilder<List<Usuario>>(
                  future: getUsuario(widget.usuario),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<Usuario> vusuario = snapshot.data!;
                      return FotoNombre(
                        size: size,
                        evento: widget.evento,
                        vusuario: vusuario,
                        edicion: widget.edicion,
                        tipousuario: widget.tipousuario,
                      );
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }
                    return const CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Colors.transparent));
                  }),
            ],
          ),
        )
      ],
    ));
  }
}

class FotoNombre extends StatefulWidget {
  final List<Usuario> vusuario;
  final String evento;
  final Size size;
  final int edicion;
  final String tipousuario;

  const FotoNombre(
      {Key? key,
      required this.size,
      required this.vusuario,
      required this.evento,
      required this.edicion,
      required this.tipousuario})
      : super(key: key);

  @override
  _FotoNombreState createState() => _FotoNombreState();
}

class _FotoNombreState extends State<FotoNombre> {
  TextEditingController nombre = TextEditingController();
  TextEditingController apellidoPaterno = TextEditingController();
  TextEditingController apellidoMaterno = TextEditingController();
  TextEditingController institucion = TextEditingController();
  TextEditingController cargo = TextEditingController();
  TextEditingController pais = TextEditingController();
  TextEditingController biografia = TextEditingController();
  TextEditingController correoelectronico = TextEditingController();
  TextEditingController redsocial = TextEditingController();
  TextEditingController codigoInvitacion = TextEditingController();
  PreferenciasUsuario pref = PreferenciasUsuario();

  String pusuario = "";
  int estado = 0;

  late File _imageFile;
  String imagen = "assets/images/Ellipse 129.png";
  Procesos procesar = Procesos();
  multimediaSelection multimedia = multimediaSelection();
  PlatformFile? pickedFileP;

  desabilita() {
    setState(() {
      estado = 1;
    });
  }

  habilita() {
    setState(() {
      estado = 0;
    });
  }

  Future<Usuario> getInsertarUsuarios(Usuario datos) async {
    var conectate = await procesar.crearmodificarusuario(datos);
    return conectate;
  }

  @override
  void initState() {
    super.initState();

    estado = widget.edicion;
    int nroregistros = widget.vusuario.length;
    imagen = nroregistros > 0 ? widget.vusuario[0].foto : imagenUsuarioDefecto;
    pusuario = nroregistros > 0 ? widget.vusuario[0].usuario : "";
    nombre = TextEditingController(
      text: nroregistros == 0 ? "" : widget.vusuario[0].nombre,
    );
    apellidoPaterno = TextEditingController(
      text: nroregistros == 0 ? "" : widget.vusuario[0].apellidoPaterno,
    );
    apellidoMaterno = TextEditingController(
      text: nroregistros == 0 ? "" : widget.vusuario[0].apellidoMaterno,
    );
    institucion = TextEditingController(
      text: nroregistros == 0 ? "" : widget.vusuario[0].origenUsuario,
    );
    cargo = TextEditingController(
      text: nroregistros == 0 ? "" : widget.vusuario[0].descripcionPuesto,
    );
    pais = TextEditingController(
      text: nroregistros == 0 ? "" : widget.vusuario[0].origenUsuario,
    );
    biografia = TextEditingController(
      text: nroregistros == 0 ? "" : widget.vusuario[0].biografia,
    );
    correoelectronico = TextEditingController(
      text: nroregistros == 0 ? "" : widget.vusuario[0].correo,
    );
    redsocial = TextEditingController(
      text: nroregistros == 0 ? "" : widget.vusuario[0].redSocial,
    );
    codigoInvitacion = TextEditingController(
      text: nroregistros == 0 ? "" : widget.vusuario[0].codigoInvitacion,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const SizedBox(
        height: 20,
      ),
      SizedBox(
        height: 280,
        child: Stack(
          children: [
            Positioned(
              left: 80,
              child: SizedBox(
                width: widget.size.width * 0.72,
                child: TextFormField(
                  enabled: estado == 1 ? false : true,
                  style: const TextStyle(fontSize: 14),
                  controller: nombre,

                  decoration: InputDecoration(
                      errorStyle: const TextStyle(height: 0, fontSize: 9),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      contentPadding: const EdgeInsets.only(
                          left: 15, bottom: 5, top: 11, right: 15),
                      hintText: "Nombres"),
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Debe ingresar el nombre del ponente';
                    }
                    return null;
                  },
                ),
              ),
            ),
            Positioned(
              left: 80,
              top: 55,
              child: SizedBox(
                //height: 38,
                width: widget.size.width * 0.72,
                child: TextFormField(
                  enabled: estado == 1 ? false : true,
                  style: const TextStyle(fontSize: 14),
                  controller: apellidoPaterno,
                  decoration: InputDecoration(
                      errorStyle: const TextStyle(height: 0, fontSize: 9),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      contentPadding: const EdgeInsets.only(
                          left: 15, bottom: 5, top: 11, right: 15),
                      hintText: "Apellido paterno"),
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Debe ingresar el apellido paterno';
                    }
                    return null;
                  },
                ),
              ),
            ),
            Positioned(
                left: 80,
                top: 110,
                child: Container(
                  //height: 38,
                  alignment: Alignment.centerLeft,
                  width: widget.size.width * 0.72,
                  child: TextFormField(
                    enabled: estado == 1 ? false : true,
                    style: const TextStyle(fontSize: 14),
                    controller: apellidoMaterno,
                    decoration: InputDecoration(
                        errorStyle: const TextStyle(height: 0, fontSize: 9),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        contentPadding: const EdgeInsets.only(
                            left: 15, bottom: 5, top: 11, right: 15),
                        hintText: "Apellido materno"),
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Debe ingresar el apellido materno';
                      }
                      return null;
                    },
                  ),
                )),
            Positioned(
              left: 0,
              top: 45,
              child: ImageCard(
                onTap: () async {
                  pickedFileP = (await multimedia.selectFile())!;
                  setState(() {
                    _imageFile = File(pickedFileP!.path as String);
                    imagen = _imageFile.path;
                  });
                },
                alto: 70,
                ancho: 70,
                imagePath: imagen,
              ),
            ),
            Positioned(
                left: 10,
                top: 165,
                child: Container(
                  //height: 38,
                  alignment: Alignment.centerLeft,
                  width: widget.size.width * 0.9,
                  child: TextFormField(
                    enabled: estado == 1 ? false : true,
                    style: const TextStyle(fontSize: 14),
                    controller: institucion,
                    decoration: InputDecoration(
                        errorStyle: const TextStyle(height: 0, fontSize: 9),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        contentPadding: const EdgeInsets.only(
                            left: 15, bottom: 5, top: 11, right: 15),
                        hintText: "Institución"),
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Debe ingresar la institución';
                      }
                      return null;
                    },
                  ),
                )),
            Positioned(
                left: 10,
                top: 225,
                child: Row(
                  children: [
                    Container(
                      //height: 38,
                      alignment: Alignment.centerLeft,
                      width: widget.size.width * 0.42,
                      child: TextFormField(
                        enabled: estado == 1 ? false : true,
                        style: const TextStyle(fontSize: 14),
                        controller: cargo,
                        decoration: InputDecoration(
                            errorStyle: const TextStyle(height: 0, fontSize: 9),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            contentPadding: const EdgeInsets.only(
                                left: 15, bottom: 5, top: 11, right: 15),
                            hintText: "Cargo"),
                        // The validator receives the text that the user has entered.
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Debe ingresar el cargo';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Container(
                      //height: 38,
                      alignment: Alignment.centerLeft,
                      width: widget.size.width * 0.42,
                      child: TextFormField(
                        enabled: estado == 1 ? false : true,
                        style: const TextStyle(fontSize: 14),
                        controller: pais,
                        decoration: InputDecoration(
                            errorStyle: const TextStyle(height: 0, fontSize: 9),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            contentPadding: const EdgeInsets.only(
                                left: 15, bottom: 5, top: 11, right: 15),
                            hintText: "Pais"),
                        // The validator receives the text that the user has entered.
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Debe ingresar el país';
                          }
                          return null;
                        },
                      ),
                    )
                  ],
                ))
          ],
        ),
      ),
      const SizedBox(height: 20),
      SizedBox(
        //margin: EdgeInsets.fromLTRB(kDefaultPadding / 2,
        //  kDefaultPadding, kDefaultPadding / 2, 0),
        width: widget.size.width,
        child: const Text(
          'Biografia',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      const SizedBox(height: 5),
      Row(
        children: [
          Expanded(
            child: Container(
                width: widget.size.width,
                // height: 80,
                decoration: BoxDecoration(
                    color: ColorBackground,
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(10)),
                child: TextFormField(
                  enabled: estado == 1 ? false : true,
                  style: const TextStyle(fontSize: 14),
                  controller: biografia,
                  maxLines: null,
                  decoration: InputDecoration(
                      errorStyle: const TextStyle(height: 0, fontSize: 9),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      contentPadding: const EdgeInsets.only(
                          left: 15, bottom: 11, top: 11, right: 15),
                      hintText: "Escriba aqui"),
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Debe ingresar la biografia';
                    }
                    return null;
                  },
                )),
          )
        ],
      ),
      const SizedBox(height: 20),
      SizedBox(
        //margin: EdgeInsets.fromLTRB(kDefaultPadding / 2,
        //  kDefaultPadding, kDefaultPadding / 2, 0),
        width: widget.size.width,
        child: const Text(
          'Contacto',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      const SizedBox(height: 5),
      Row(
        children: [
          Expanded(
            child: Container(
                width: widget.size.width,
                // height: 80,
                decoration: BoxDecoration(
                    color: ColorBackground,
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(10)),
                child: TextFormField(
                  enabled: estado == 1 ? false : true,
                  style: const TextStyle(fontSize: 14),
                  controller: correoelectronico,
                  maxLines: null,
                  decoration: InputDecoration(
                      errorStyle: const TextStyle(height: 0, fontSize: 9),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      contentPadding: const EdgeInsets.only(
                          left: 15, bottom: 11, top: 11, right: 15),
                      hintText: "Ejem: correoelectronico@institucion.com"),
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Debe ingresar el correo electronico';
                    }
                    return null;
                  },
                )),
          )
        ],
      ),
      const SizedBox(height: 20),
      SizedBox(
        //margin: EdgeInsets.fromLTRB(kDefaultPadding / 2,
        //  kDefaultPadding, kDefaultPadding / 2, 0),
        width: widget.size.width,
        child: const Text(
          'Más información',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      const SizedBox(height: 5),
      Row(
        children: [
          Expanded(
            child: Container(
                width: widget.size.width,
                // height: 80,
                decoration: BoxDecoration(
                    color: ColorBackground,
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(10)),
                child: TextFormField(
                  enabled: estado == 1 ? false : true,
                  style: const TextStyle(fontSize: 14),
                  controller: redsocial,
                  maxLines: null,
                  decoration: InputDecoration(
                      errorStyle: const TextStyle(height: 0, fontSize: 9),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      contentPadding: const EdgeInsets.only(
                          left: 15, bottom: 11, top: 11, right: 15),
                      hintText: "Ejem: http://www.pagina.com"),
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Debe ingresar el correo electronico';
                    }
                    return null;
                  },
                )),
          )
        ],
      ),
      const SizedBox(
        height: 20,
      ),
      Row(children: [
        BottonBlue(
          alto: 45,
          ancho: 100,
          colorboton: Colors.red,
          texto: "Limpiar",
          colorTexto: ColorBackground,
          press: () => () {
            nombre.text = "";
            apellidoPaterno.text = "";
            apellidoMaterno.text = "";
            institucion.text = "";
            cargo.text = "";
            pais.text = "";
            correoelectronico.text = "";
            redsocial.text = "";
            biografia.text = "";
          },
          habilitado: estado == 1 ? 1 : 0,
        ),
        const SizedBox(width: 5),
        (widget.tipousuario == "Organizador" ||
                widget.tipousuario == "Administrador")
            ? BottonBlue(
                alto: 45,
                ancho: 100,
                colorboton: ColorPrimario,
                texto: "Editar",
                colorTexto: ColorBackground,
                press: () => () {
                  habilita();
                },
                habilitado: 0,
              )
            : Container(
                width: 0,
              ),
        const Spacer(),
        BottonBlue(
          alto: 45,
          ancho: 130,
          colorboton: ColorPrimario,
          texto: "Grabar datos",
          colorTexto: ColorBackground,
          press: () => () async {
            if (nombre.text.isEmpty ||
                apellidoPaterno.text.isEmpty ||
                apellidoMaterno.text.isEmpty ||
                institucion.text.isEmpty ||
                cargo.text.isEmpty ||
                pais.text.isEmpty ||
                biografia.text.isEmpty ||
                correoelectronico.text.isEmpty) {
              Modales mensajes = Modales(context);
              mensajes.modalTextoBoton(
                  'Debe ingresar todos los datos', Colors.red, 'Cerrar');
            } else {
              String link = "";
              if (pickedFileP != null) {
                link =
                    await multimedia.uploadFile(pickedFileP!, 'fotosUsuarios');
              }

              Usuario vusuario = Usuario(
                usuario: widget.vusuario.isEmpty
                    ? pusuario
                    : widget.vusuario[0].usuario,
                tipoUsuario: "Ponente",
                rolUsuario: "Usuario",
                nombre: nombre.text,
                apellidoPaterno: apellidoPaterno.text,
                apellidoMaterno: apellidoMaterno.text,
                origenUsuario: institucion.text,
                descripcionPuesto: cargo.text,
                ubicacion: pais.text,
                correo: correoelectronico.text,
                redSocial: redsocial.text,
                foto: link.isEmpty
                    ? imagen
                    : link, //await pref.getRutaServidor(),
                biografia: biografia.text,
                telefono: 'telefono',
                codigoInvitacion: codigoInvitacion.text == ""
                    ? await procesar.generacodigoInvitacion(widget.evento)
                    : codigoInvitacion.text,
                qr: 'my_conf/XXICongreso_Internacional_de_Educadores/usuarios/BarCode.png',
                certificadogenerado: 0,
                fechageneracioncert: '1900-01-01', evento: widget.evento,
              );

              Usuario a = await getInsertarUsuarios(vusuario);
              setState(() {});

              pusuario = a.usuario;

              setState(() {});

              // ignore: use_build_context_synchronously
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text('Procesando')));
            }
          },
          habilitado: estado == 1 ? 1 : 0,
        ),
      ]),
      const SizedBox(height: 300),
      BottonBlue(
        alto: 45,
        ancho: widget.size.width,
        colorboton: Colors.red,
        texto: "Eliminar",
        colorTexto: ColorBackground,
        press: () => () async {
          deleteData borrar = deleteData();
          borrar.deleteUsuario(
              widget.vusuario.isEmpty ? "" : widget.vusuario[0].usuario,
              widget.evento);

          Navigator.pop(context);
        },
        habilitado: estado == 1 ? 1 : 0,
      ),
    ]);
  }
}
