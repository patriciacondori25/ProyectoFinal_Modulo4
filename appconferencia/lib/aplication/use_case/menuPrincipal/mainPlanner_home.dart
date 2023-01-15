// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:appconferencia/infraestructure/componentes/containerConTextoSimple.dart';
import 'package:appconferencia/constants.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../../infraestructure/componentes/preferenciasUsuario.dart';
import '../../../infraestructure/controller/readData.dart';
import '../../../domain/entity_manager/usuario.dart';

class Bodymp extends StatefulWidget {
  const Bodymp({
    Key? key,
  }) : super(key: key);

  @override
  State<Bodymp> createState() => _BodympState();
}

class _BodympState extends State<Bodymp> {
  PreferenciasUsuario pref = PreferenciasUsuario();

  String idusuario = "";
  String idevento = "";
  String imagenPrincipal = "";
  String nombreEvento = "";

  void cargaPreferencias() async {
    idevento = await pref.getevento();
    idusuario = await pref.getCodigoUsuario();
    imagenPrincipal = await pref.getFotoEventoPrincipal();
    nombreEvento = await pref.getNombreEvento();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    cargaPreferencias();
  }

  Future<Usuario> cargarUsuario(String usuario, String evento) async {
    readData leerData = readData();

    return await leerData.cargarUsuario(idusuario, idevento);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(25, 20, 25, 0),
            child: Center(
                child: Text(
              nombreEvento,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            )),
          ),

          Container(
            height: 30,
          ),
          //Spacer(),
          FutureBuilder<Usuario>(
            future: cargarUsuario(idusuario, idevento),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                Usuario vdatosusuario = snapshot.data!;
                return BarCode(
                  datosUsuario: vdatosusuario,
                  tamano: size,
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              return const CircularProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation<Color>(Colors.transparent));
            },
          ),
          //Row(children: const <Widget>[Text("\n")]),
          const Padding(
            padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
            child: Text(
              "",
              style: TextStyle(
                color: ColorPrimario,
                fontSize: 18,
                fontFamily: "Poppins",
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          FutureBuilder<Usuario>(
            future: cargarUsuario(idusuario, idevento),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                Usuario vdatosusuario = snapshot.data!;
                return DatosPersonales(
                    vdatosusuario: vdatosusuario, tamano: size);
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              return const CircularProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation<Color>(Colors.transparent));
            },
          ),
        ],
      ),
    );
  }
}

class DatosPersonales extends StatelessWidget {
  final Usuario vdatosusuario;
  final Size tamano;
  const DatosPersonales({
    Key? key,
    required this.vdatosusuario,
    required this.tamano,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: tamano.width,
      padding: const EdgeInsets.fromLTRB(15, 0, 25, 0),
      child: Stack(
        children: <Widget>[
          const Positioned(
            top: 10,
            left: 10,
            child: Icon(
              Icons.route,
              color: ColorPrimario,
              size: 30,
            ),
          ),
          const Positioned(
            top: 10,
            left: 60,
            child: Text(
              "País",
              style: TextStyle(
                color: ColorNegro,
                fontSize: 12,
                fontFamily: "Poppins",
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Positioned(
            top: 26,
            left: 60,
            child: Text(
              vdatosusuario.ubicacion,
              style: const TextStyle(
                color: Colors.black54,
                fontSize: 15,
                fontFamily: "Poppins",
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Positioned(
            top: 60,
            left: 10,
            child: Icon(
              Icons.location_city,
              color: ColorPrimario,
              size: 30,
            ),
          ),
          const Positioned(
            top: 64,
            left: 60,
            child: Text(
              "Institución",
              style: TextStyle(
                color: ColorNegro,
                fontSize: 12,
                fontFamily: "Poppins",
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Positioned(
            top: 76,
            left: 60,
            child: Text(
              vdatosusuario.origenUsuario,
              style: const TextStyle(
                color: Colors.black54,
                fontSize: 15,
                fontFamily: "Poppins",
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Positioned(
            top: 110,
            left: 10,
            child: Icon(
              Icons.work,
              color: ColorPrimario,
              size: 28,
            ),
          ),
          const Positioned(
            top: 109,
            left: 60,
            child: Text(
              "Empresa / Cargo ",
              style: TextStyle(
                color: ColorNegro,
                fontSize: 12,
                fontFamily: "Poppins",
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Positioned(
            top: 126,
            left: 60,
            child: Text(
              vdatosusuario.descripcionPuesto,
              style: const TextStyle(
                color: Colors.black54,
                fontSize: 15,
                fontFamily: "Poppins",
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Positioned(
            top: 160,
            left: 10,
            child: Icon(
              Icons.mail_sharp,
              color: ColorPrimario,
              size: 28,
            ),
          ),
          const Positioned(
            top: 159,
            left: 60,
            child: Text(
              "Correo electrónico",
              style: TextStyle(
                color: ColorNegro,
                fontSize: 12,
                fontFamily: "Poppins",
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Positioned(
            top: 176,
            left: 60,
            child: Text(
              vdatosusuario.correo,
              style: const TextStyle(
                color: Colors.black54,
                fontSize: 15,
                fontFamily: "Poppins",
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Positioned(
            top: 210,
            left: 10,
            child: Icon(
              Icons.phone,
              color: ColorPrimario,
              size: 28,
            ),
          ),
          const Positioned(
            top: 210,
            left: 60,
            child: Text(
              "Teléfono",
              style: TextStyle(
                color: ColorNegro,
                fontSize: 12,
                fontFamily: "Poppins",
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Positioned(
            top: 226,
            left: 60,
            child: Text(
              vdatosusuario.telefono,
              style: const TextStyle(
                color: Colors.black54,
                fontSize: 15,
                fontFamily: "Poppins",
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class BarCode extends StatelessWidget {
  final Usuario datosUsuario;
  final Size tamano;

  const BarCode({Key? key, required this.datosUsuario, required this.tamano})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    //insetPadding: EdgeInsets.fromLTRB(10, 100, 10, 100),
                    content: SizedBox(
                      height: 330,
                      width: 100,
                      child: Column(
                        children: [
                          Container(
                            height: 250,
                            width: 250,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: ColorBackground,
                                border: Border.all(
                                    color: Colors.black26, width: 10)),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: ColorBackground,
                                  border: Border.all(
                                      color: ColorBackground, width: 5)),
                              child: QrImage(
                                data: datosUsuario.nombre +
                                    datosUsuario.apellidoPaterno +
                                    datosUsuario.apellidoMaterno +
                                    datosUsuario.evento,
                                size: 100,
                                embeddedImageStyle: QrEmbeddedImageStyle(
                                    size: const Size(100, 100)),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Text(
                            "${datosUsuario.apellidoPaterno} ${datosUsuario.apellidoMaterno}",
                            style: const TextStyle(
                              color: ColorNegro,
                              fontSize: 18,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            datosUsuario.tipoUsuario,
                            style: const TextStyle(
                              color: ColorNegro,
                              fontSize: 14,
                              fontFamily: "Poppins",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ));
        },
        child: SizedBox(
          width: tamano.width,
          height: 120,
          child: Stack(
            children: [
              Positioned(
                left: 30,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(1),
                      color: ColorBackground,
                      border: Border.all(color: Colors.black26, width: 1)),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: ColorBackground,
                        border: Border.all(color: ColorBackground, width: 5)),
                    child: QrImage(
                      data: datosUsuario.nombre +
                          datosUsuario.apellidoPaterno +
                          datosUsuario.apellidoMaterno +
                          datosUsuario.evento,
                      size: 90,
                      embeddedImageStyle:
                          QrEmbeddedImageStyle(size: const Size(90, 90)),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 170,
                top: 10,
                child: SizedBox(
                  width: 190,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Text(
                                "${datosUsuario.nombre} ${datosUsuario.apellidoPaterno} ${datosUsuario.apellidoMaterno}",
                                style: const TextStyle(
                                  color: ColorNegro,
                                  fontSize: 18,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 2),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            datosUsuario.tipoUsuario,
                            style: const TextStyle(
                              color: ColorNegro,
                              fontSize: 14,
                              fontFamily: "Poppins",
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                  left: 160,
                  top: 55,
                  child: ContainerConTextoSimple(
                      size: tamano, tamanoLetra: 14, texto: 'Código')),
              Positioned(
                  left: 160,
                  top: 75,
                  child: ContainerConTextoSimple(
                      size: tamano,
                      tamanoLetra: 14,
                      texto: datosUsuario.codigoInvitacion))
            ],
          ),
        ));
  }
}
