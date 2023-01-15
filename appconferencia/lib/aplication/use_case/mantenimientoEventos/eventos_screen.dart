// ignore_for_file: camel_case_types, file_names

import 'dart:io';
import 'package:appconferencia/aplication/use_case/mantenimientoAjustes/ajustes_screen.dart';
import 'package:appconferencia/domain/entity_manager/evento.dart';
import 'package:appconferencia/infraestructure/componentes/blueButton.dart';
import 'package:appconferencia/infraestructure/componentes/inputTextFormulario.dart';
import 'package:appconferencia/infraestructure/componentes/video_player_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:appconferencia/constants.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

class listAdminP extends StatelessWidget {
  const listAdminP({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: buildAppBar(), body: const listAdmin());
    // Body(),
  }
}

class listAdmin extends StatefulWidget {
  const listAdmin({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _listAdmin();
}

class _listAdmin extends State<listAdmin> {
  @override
  Widget build(BuildContext context) {
    // ignore: todo
    // TODO: implement build
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LineArrow(
            size: size,
            texto: "Creacion Eventos",
            ultimo: Icons.arrow_forward_ios_outlined,
            press: () => () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const createEvent(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

AppBar buildAppBar() {
  return AppBar(
    centerTitle: true,
    elevation: 0,
    //leading: IconButton(
    //icon: SvgPicture.asset("assets/icons/menu.svg"),
    //onPressed: () {},
    //),
    title: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: const <Widget>[
        Text(
          "Gestión de eventos",
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}

class createEvent extends StatelessWidget {
  const createEvent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: buildAppBar(), body: const createEventP());
  }

  AppBar buildAppBar() {
    return AppBar(
      centerTitle: true,
      elevation: 0,
      //leading: IconButton(
      //icon: SvgPicture.asset("assets/icons/menu.svg"),
      //onPressed: () {},
      //),
      title: const Text(
        "Ingresar Eventos",
        textAlign: TextAlign.center,
      ),
    );
  }
}

class createEventP extends StatefulWidget {
  const createEventP({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _createEventP();
}

class _createEventP extends State<createEventP> {
  PlatformFile? pickedFileP;
  PlatformFile? pickedFileS;
  UploadTask? uploadTask;

  TextEditingController nombreEvento = TextEditingController();
  TextEditingController descripcionEvento = TextEditingController();
  TextEditingController fechaInicio = TextEditingController();
  TextEditingController fechaFin = TextEditingController();
  TextEditingController fotoEventoP = TextEditingController();
  TextEditingController fotoEventoS = TextEditingController();
  TextEditingController codigoEvento = TextEditingController();
  TextEditingController correoContacto = TextEditingController();
  TextEditingController telefonoContacto = TextEditingController();
  TextEditingController activo = TextEditingController();
  TextEditingController nombreCorto = TextEditingController();
  TextEditingController ubicacion = TextEditingController();
  TextEditingController rutaServidor = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  child: InputTextFormulario(
                    controladorTexto: nombreEvento,
                    textoEntrada: "Nombre Evento",
                    textoValidacion: "Debe ingresar Evento",
                    icono: 0,
                    icon: Icons.person_outline,
                    oscurecer: false,
                    tipoValidacion: 4,
                    textoContrasena: nombreEvento,
                    key: null,
                    colorborde: Colors.grey,
                    habilita: 0,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  child: InputTextFormulario(
                    controladorTexto: descripcionEvento,
                    textoEntrada: "Descripcion Evento",
                    textoValidacion: "Debe ingresar Descripcion",
                    icono: 0,
                    icon: Icons.person_outline,
                    oscurecer: false,
                    tipoValidacion: 4,
                    textoContrasena: descripcionEvento,
                    key: null,
                    colorborde: Colors.grey,
                    habilita: 0,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  child: DateTimeField(
                      controller: fechaInicio,
                      decoration: InputDecoration(
                        errorStyle: const TextStyle(
                            fontFamily: 'DM Sans', height: 0, fontSize: 9),
                        contentPadding: const EdgeInsets.all(8.0),
                        fillColor: const Color(0xFFFFFFFF).withOpacity(0.7),
                        filled: true,
                        border: InputBorder.none,
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        hintText: 'Fecha inicio',
                        hintStyle: const TextStyle(
                            fontFamily: 'DM Sans',
                            fontSize: 12,
                            color: Color(0xFF707070)),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        focusedErrorBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      format: DateFormat('yyyy-MM-dd'),
                      onShowPicker: (context, currentValue) {
                        return showDatePicker(
                            context: context,
                            firstDate: DateTime(1900),
                            initialDate: currentValue ?? DateTime.now(),
                            lastDate: DateTime(2100));
                      }),
                ),
                const SizedBox(height: 10),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  child: DateTimeField(
                      controller: fechaFin,
                      decoration: InputDecoration(
                        errorStyle: const TextStyle(
                            fontFamily: 'DM Sans', height: 0, fontSize: 9),
                        contentPadding: const EdgeInsets.all(8.0),
                        fillColor: const Color(0xFFFFFFFF).withOpacity(0.7),
                        filled: true,
                        border: InputBorder.none,
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        hintText: 'Fecha fin',
                        hintStyle: const TextStyle(
                            fontFamily: 'DM Sans',
                            fontSize: 12,
                            color: Color(0xFF707070)),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        focusedErrorBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      format: DateFormat('yyyy-MM-dd'),
                      onShowPicker: (context, currentValue) {
                        return showDatePicker(
                            context: context,
                            firstDate: DateTime(1900),
                            initialDate: currentValue ?? DateTime.now(),
                            lastDate: DateTime(2100));
                      }),
                ),
                const SizedBox(height: 10),
                if (pickedFileP != null)
                  Container(
                    height: size.height * 0.2,
                    width: size.width * 0.85,
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.grey)),
                    child: buildMediaPreview(pickedFileP),
                  ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  child: BottonBlue(
                    alto: 50,
                    ancho: size.width * 0.95,
                    colorboton: Colors.grey,
                    colorTexto: Colors.black,
                    habilitado: 0,
                    texto: 'Foto principal',
                    press: () => () {
                      selectFile('Principal');
                    },
                  ),
                ),
                const SizedBox(height: 10),
                if (pickedFileS != null)
                  Container(
                    height: size.height * 0.2,
                    width: size.width * 0.85,
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.grey)),
                    child: buildMediaPreview(pickedFileS),
                  ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  child: BottonBlue(
                    alto: 50,
                    ancho: size.width * 0.95,
                    colorboton: Colors.grey,
                    colorTexto: Colors.black,
                    habilitado: 0,
                    texto: 'Foto Secundaria',
                    press: () => () {
                      selectFile('Secundaria');
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  child: InputTextFormulario(
                    controladorTexto: codigoEvento,
                    textoEntrada: "Codigo Evento",
                    textoValidacion: "Debe ingresar Descripcion",
                    icono: 0,
                    icon: Icons.person_outline,
                    oscurecer: false,
                    tipoValidacion: 4,
                    textoContrasena: descripcionEvento,
                    key: null,
                    colorborde: Colors.grey,
                    habilita: 0,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  child: InputTextFormulario(
                    controladorTexto: correoContacto,
                    textoEntrada: "Correo contacto",
                    textoValidacion: "Debe ingresar Descripcion",
                    icono: 0,
                    icon: Icons.person_outline,
                    oscurecer: false,
                    tipoValidacion: 4,
                    textoContrasena: descripcionEvento,
                    key: null,
                    colorborde: Colors.grey,
                    habilita: 0,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  child: InputTextFormulario(
                    controladorTexto: activo,
                    textoEntrada: "Activo",
                    textoValidacion: "Debe ingresar 1 o 0",
                    icono: 0,
                    icon: Icons.person_outline,
                    oscurecer: false,
                    tipoValidacion: 4,
                    textoContrasena: descripcionEvento,
                    key: null,
                    colorborde: Colors.grey,
                    habilita: 0,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  child: InputTextFormulario(
                    controladorTexto: nombreCorto,
                    textoEntrada: "Nombre corto del Evento",
                    textoValidacion: "Debe ingresar nombreCorto",
                    icono: 0,
                    icon: Icons.person_outline,
                    oscurecer: false,
                    tipoValidacion: 4,
                    textoContrasena: descripcionEvento,
                    key: null,
                    colorborde: Colors.grey,
                    habilita: 0,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  child: InputTextFormulario(
                    controladorTexto: ubicacion,
                    textoEntrada: "Ubicacion del Evento",
                    textoValidacion: "Debe ingresar Ubicacion",
                    icono: 0,
                    icon: Icons.person_outline,
                    oscurecer: false,
                    tipoValidacion: 4,
                    textoContrasena: descripcionEvento,
                    key: null,
                    colorborde: Colors.grey,
                    habilita: 0,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  child: InputTextFormulario(
                    controladorTexto: rutaServidor,
                    textoEntrada: "Ruta servidor",
                    textoValidacion: "Debe ingresar rutaServidor",
                    icono: 0,
                    icon: Icons.person_outline,
                    oscurecer: false,
                    tipoValidacion: 4,
                    textoContrasena: descripcionEvento,
                    key: null,
                    colorborde: Colors.grey,
                    habilita: 0,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  child: InputTextFormulario(
                    controladorTexto: telefonoContacto,
                    textoEntrada: "Telefono Contacto",
                    textoValidacion: "Debe ingresar Tele",
                    icono: 0,
                    icon: Icons.person_outline,
                    oscurecer: false,
                    tipoValidacion: 4,
                    textoContrasena: descripcionEvento,
                    key: null,
                    colorborde: Colors.grey,
                    habilita: 0,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  child: BottonBlue(
                    alto: 50,
                    ancho: size.width * 0.95,
                    colorboton: ColorPrimario,
                    colorTexto: ColorBackground,
                    habilitado: 0,
                    texto: 'Grabar',
                    press: () => () async {
                      String eventoid = await createEvento();
                      uploadFile(pickedFileS, 'no', eventoid);
                      uploadFile(pickedFileP, 'Principal', eventoid);
                    },
                  ),
                ),
                const SizedBox(height: 10),
              ],
            )),
      ),
    );
  }

  Future<String> createEvento() async {
    final docEvento = FirebaseFirestore.instance.collection('evento').doc();

    final evento = Evento(
        evento: docEvento.id,
        fotoeventos: fotoEventoS.text, //'fotosEventos/${pickedFileS!.name}',
        nombreevento: nombreEvento.text,
        ubicacion: ubicacion.text,
        fechainicio: DateTime.parse(fechaInicio.text), //DateTime(2021, 11, 20),
        fechafin: DateTime.parse(fechaFin.text),
        fotoeventop: fotoEventoP.text, //'fotosEventos/${pickedFileP!.name}',
        descripcionevento: descripcionEvento.text,
        nombrecorto: nombreCorto.text,
        rutaservidor: rutaServidor.text,
        codigoEvento: codigoEvento.text,
        correoContacto: correoContacto.text,
        telefonoContacto: telefonoContacto.text,
        activo: int.parse(activo.text));

    await docEvento.set(evento.toJson());
    return docEvento.id;
  }

  Future selectFile(String tipoimagen) async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;

    setState(() {
      if (tipoimagen == 'Principal') {
        pickedFileP = result.files.first;
      } else {
        pickedFileS = result.files.first;
      }
    });
  }

  Widget buildMediaPreview(PlatformFile? archivo) {
    final file = File(archivo!.path!);

    switch (archivo.extension!.toLowerCase()) {
      case 'jpg':
      case 'jpeg':
      case 'png':
        return Image.file(
          file,
          width: double.infinity,
          fit: BoxFit.cover,
        );
      case 'mp4':
        return VideoPlayerWidget(file: file);
      default:
        return Center(child: Text(archivo.name));
    }
  }

  Future uploadFile(
      PlatformFile? archivo, String tipoimagen, String evento) async {
    final path = 'fotosEventos/${archivo!.name}';
    final file = File(archivo.path!);

    final ref = FirebaseStorage.instance.ref().child(path);
    setState(() {
      uploadTask = ref.putFile(file);
    });

    final snapshot = await uploadTask!.whenComplete(() {});

    final urlDownload = await snapshot.ref.getDownloadURL();

    if (tipoimagen == 'Principal') {
      fotoEventoP.text = urlDownload;
      var docUsuario = FirebaseFirestore.instance.collection('evento');
      docUsuario.doc(evento).update({
        'fotoeventop': urlDownload,
      });
    } else {
      fotoEventoS.text = urlDownload;
      var docUsuario = FirebaseFirestore.instance.collection('evento');
      docUsuario.doc(evento).update({
        'fotoeventos': urlDownload,
      });
    }

    setState(() {
      uploadTask = null;
    });
  }
}
