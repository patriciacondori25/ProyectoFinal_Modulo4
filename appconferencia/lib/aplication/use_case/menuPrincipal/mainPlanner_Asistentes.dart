// ignore_for_file: camel_case_types, no_logic_in_create_state, library_private_types_in_public_api, prefer_const_constructors, unnecessary_new, file_names

import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:appconferencia/domain/entity_manager/usuario.dart';
import '../../../../constants.dart';
import '../../../infraestructure/controller/readData.dart';
import '../mantenimientoAsistentes/asistenteIngreso.dart';
import '../mantenimientoAsistentes/expositorIngreso.dart';

class mainplanner_asistentes extends StatefulWidget {
  final String idevento;
  final String tipousuario;
  final String imagenPrincipal;

  const mainplanner_asistentes(
      {Key? key,
      required this.idevento,
      required this.tipousuario,
      required this.imagenPrincipal})
      : super(key: key);
  @override
  _mainplanner_asistentesState createState() =>
      _mainplanner_asistentesState(idevento);
}

class _mainplanner_asistentesState extends State<mainplanner_asistentes> {
  final String idevento;
  List<bool> estados = [true, false];
  readData leerdatos = readData();

  _mainplanner_asistentesState(this.idevento);

  Future<List<Usuario>> datosLista() async {
    int indiceActual = 0;
    for (int i = 0; i < estados.length; i++) {
      if (estados[i] == true) {
        indiceActual = i;
      }
    }

    var conectate = await leerdatos.listadoParticipantes(
        idevento, indiceActual == 0 ? "Asistente" : "Ponente");

    return conectate;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        botones(size, estados),
        buildFutureBuilder(size),

        Row(
          children: [
            Spacer(),
            //estados[1] == true &&
            (widget.tipousuario == "Organizador" ||
                    widget.tipousuario == "Administrador")
                ? Center(
                    child: SizedBox(
                      height: 60,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: kDefaultPadding / 3,
                        ),
                        child: FloatingActionButton(
                          // mini: true,
                          onPressed: () {
                            if (estados[1] == true) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ExpositorIngreso(
                                      usuario: "",
                                      evento: widget.idevento,
                                      imagenPrincipal: widget.imagenPrincipal,
                                      edicion: 0,
                                      tipousuario: widget.tipousuario),
                                ),
                              ).then((value) => setState(() {}));
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AsistentesIngreso(
                                    usuario: "",
                                    evento: widget.idevento,
                                    edicion: 0,
                                    tipousuario: widget.tipousuario,
                                    imagenPrincipal: widget.imagenPrincipal,
                                  ),
                                ),
                              ).then((value) => setState(() {}));
                            }
                          },
                          foregroundColor: ColorNegro,
                          backgroundColor: Colors.grey.shade300,
                          child: const Icon(Icons.add),
                          // splashColor: kBackgroudColor,
                        ),
                      ),
                    ),
                  )
                : Container(
                    height: 0,
                  ),
            const SizedBox(
              width: 10,
            )
          ],
        ),

        //ListaDeDetalles(size: size)
      ],
    );
  }

  void entraPonenteIngreso(int edita, String usuario) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ExpositorIngreso(
          evento: widget.idevento,
          usuario: usuario,
          imagenPrincipal: widget.imagenPrincipal,
          edicion: 1,
          tipousuario: widget.tipousuario,
        ),
        settings: RouteSettings(name: '/ExpositorIngreso'), //69HYL0J4XX
      ),
    ).then((value) => setState(() {}));
  }

  void entraAsistenteIngreso(int edita, String usuario) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AsistentesIngreso(
          evento: widget.idevento,
          usuario: usuario,
          edicion: 1,
          tipousuario: widget.tipousuario,
          imagenPrincipal: widget.imagenPrincipal,
        ),
        settings: RouteSettings(name: '/AsistentesIngreso'),
      ),
    ).then((value) => setState(() {}));
  }

  FutureBuilder<List> buildFutureBuilder(Size size) {
    return new FutureBuilder<List<Usuario>>(
      future: datosLista(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Usuario> pcronogramaeventos = (snapshot.data!);
          return new Expanded(
              child: GroupedListView<dynamic, String>(
                  sort: true,
                  elements: pcronogramaeventos,
                  groupBy: (element) =>
                      element.apellidoPaterno.toString().substring(0, 1),
                  groupComparator: (value1, value2) => value2.compareTo(value1),
                  itemComparator: (item1, item2) =>
                      item1.apellidoPaterno.compareTo(item2.apellidoPaterno),
                  order: GroupedListOrder.DESC,
                  useStickyGroupSeparators: true,
                  groupSeparatorBuilder: (String value) =>
                      LineaPlomaAsistentes(size: size, texto: value),
                  itemBuilder: (c, element) {
                    return FilaNueva(
                      nombres: element.nombre +
                          " " +
                          element.apellidoPaterno +
                          " " +
                          element.apellidoMaterno,
                      descripcionpuesto: element.descripcionPuesto,
                      origenusuario: element.origenUsuario,
                      ubicacion: element.ubicacion,
                      size: size,
                      evento: element.evento,
                      usuario: element.usuario,
                      context: context,
                      indicador: estados[1],
                      imagenPrincipal: widget.imagenPrincipal,
                      tipoUsuario: widget.tipousuario,
                      estado: estados[1],
                      presseditponente: () =>
                          {entraPonenteIngreso(0, element.usuario)},
                      presseditasistente: () =>
                          {entraAsistenteIngreso(0, element.usuario)},
                      dosIniciales: element.apellidoPaterno.substring(0, 2),
                      pressvisualizaasistente: () =>
                          {entraAsistenteIngreso(1, element.usuario)},
                      pressvisualizaponente: () =>
                          {entraPonenteIngreso(1, element.usuario)},
                    );
                  }));
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return new CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(Colors.transparent));
      },
    );
  }

  Container botones(Size size, List<bool> isSelected) {
    return Container(
      padding: EdgeInsets.fromLTRB(kDefaultPadding / 2, kDefaultPadding / 2,
          kDefaultPadding / 2, kDefaultPadding / 2),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Spacer(),
              ToggleButtons(
                isSelected: isSelected,
                fillColor: ColorPrimario,
                selectedColor: ColorBackground,
                renderBorder: false,
                //borderRadius: ,
                children: <Widget>[
                  BottonP(
                    texto: "Asistentes",
                    size: size.width - 5,
                    icono: Icons.bookmark,
                  ),
                  BottonP(
                    texto: "Ponentes",
                    size: size.width - 5,
                    icono: Icons.bookmark,
                  ),
                ],
                onPressed: (int newindex) {
                  setState(() {
                    for (int index = 0; index < isSelected.length; index++) {
                      if (index == newindex) {
                        isSelected[index] = true;
                      } else {
                        isSelected[index] = false;
                      }
                    }
                    datosLista();
                  });
                },
              ),
              Spacer(),
            ],
          )
        ],
      ),
    );
  }
}

class LineaPlomaAsistentes extends StatelessWidget {
  final String texto;
  const LineaPlomaAsistentes({
    Key? key,
    required this.size,
    required this.texto,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width,
      height: 38,
      child: Column(
        children: [
          SizedBox(height: 10),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: size.width / 1.05,
                height: 28,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(0),
                    color: ColorBackground),
                padding: const EdgeInsets.only(
                  left: 9,
                  top: 3,
                  bottom: 1,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      texto,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class FilaNueva extends StatelessWidget {
  final Size size;
  final bool estado;
  final String tipoUsuario;
  final String nombres;
  final String descripcionpuesto;
  final String origenusuario;
  final String ubicacion;
  final String usuario;
  final String evento;
  final BuildContext context;
  final bool indicador;
  final String imagenPrincipal;
  final Function presseditponente;
  final Function presseditasistente;
  final Function pressvisualizaponente;
  final Function pressvisualizaasistente;
  final String dosIniciales;
  const FilaNueva({
    Key? key,
    required this.size,
    required this.nombres,
    required this.descripcionpuesto,
    required this.origenusuario,
    required this.ubicacion,
    required this.context,
    required this.usuario,
    required this.evento,
    required this.indicador,
    required this.imagenPrincipal,
    required this.tipoUsuario,
    required this.estado,
    required this.presseditponente,
    required this.presseditasistente,
    required this.pressvisualizaponente,
    required this.pressvisualizaasistente,
    required this.dosIniciales,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.fromLTRB(10, 2, 10, 2),
          width: size.width - 20,
          height: 70,
          child: Stack(
            children: [
              Positioned(
                left: 0,
                top: 11,
                child: GestureDetector(
                  onTap: () => {
                    if (estado == true)
                      {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ExpositorIngreso(
                              evento: evento,
                              usuario: usuario,
                              imagenPrincipal: imagenPrincipal,
                              edicion: 1,
                              tipousuario: tipoUsuario,
                            ),
                            settings: RouteSettings(
                                name: '/ExpositorIngreso'), //69HYL0J4XX
                          ),
                        )
                      }
                  },
                  child: Container(
                      width: 40,
                      height: 40,
                      decoration: new BoxDecoration(
                        color: ColorPrimario,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          dosIniciales,
                          style: TextStyle(color: ColorBackground),
                        ),
                      )),
                ),

                //IconButton(icon: Icon(Icons.people), onPressed: press),
              ),
              Positioned(
                left: 50,
                top: 10,
                child: SizedBox(
                  width: 277,
                  child: Text(
                    nombres,
                    style: TextStyle(
                      color: ColorNegro,
                      fontSize: 14,
                    ),
                    maxLines: 1,
                  ),
                ),
              ),
              Positioned(
                left: 50,
                top: 28,
                child: SizedBox(
                  width: 277,
                  child: Text(
                    "$descripcionpuesto-$origenusuario",
                    style: TextStyle(
                      color: ColorNegro,
                      fontSize: 11,
                    ),
                    maxLines: 1,
                  ),
                ),
              ),
              Positioned(
                left: 50,
                top: 41,
                child: SizedBox(
                  width: 277,
                  child: Text(
                    ubicacion,
                    style: TextStyle(
                      color: ColorNegro,
                      fontSize: 11,
                    ),
                    maxLines: 1,
                  ),
                ),
              ),
              //  estado == true &&
              (tipoUsuario == "Organizador" || tipoUsuario == "Administrador")
                  ? Positioned(
                      left: size.width * 0.83,
                      top: -5,
                      child: IconButton(
                        icon: Icon(Icons.edit_note),
                        onPressed: () => {
                          if (estado == true)
                            {presseditponente()}
                          else
                            {presseditasistente()}
                        },
                      ),
                    )
                  : Container(
                      height: 1,
                    ),

              (tipoUsuario == "Organizador" || tipoUsuario == "Administrador")
                  ? Positioned(
                      left: size.width * 0.83,
                      top: 28,
                      child: IconButton(
                        icon: Icon(Icons.keyboard_arrow_right),
                        onPressed: () => {
                          if (estado == true)
                            {pressvisualizaponente()}
                          else
                            {pressvisualizaasistente()}
                        },
                      ),
                    )
                  : Container(
                      height: 1,
                    ),
            ],
          ),
        )
      ],
    );
  }
}

class BottonP extends StatelessWidget {
  const BottonP({
    Key? key,
    required this.texto,
    required this.size,
    required this.icono,
  }) : super(key: key);
  final String texto;
  final double size;
  final IconData icono;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.fromLTRB(2.0, 0.0, 2.0, 0.0),
        width: size / 2.16,
        height: 53,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(6),
            topRight: Radius.circular(6),
            bottomLeft: Radius.circular(6),
            bottomRight: Radius.circular(6),
          ),
          border: Border.all(
            color: ColorPrimario,
            width: 1,
          ),
        ),
        child: Container(
          margin:
              EdgeInsets.fromLTRB(kDefaultPadding, 0.0, kDefaultPadding, 0.0),
          child: Row(
            children: [
              Icon(
                icono,
                color: ColorPrimario,
              ),
              Center(
                child: Text(
                  "  $texto",
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ));
  }
}
