// ignore_for_file: file_names, library_private_types_in_public_api

import 'package:flutter/material.dart';

class InputTextFormulario extends StatefulWidget {
  const InputTextFormulario({
    Key? key,
    required this.controladorTexto,
    required this.textoEntrada,
    required this.textoValidacion,
    required this.icon,
    required this.oscurecer,
    required this.tipoValidacion,
    required this.textoContrasena,
    required this.icono,
    required this.colorborde,
    required this.habilita,
  }) : super(key: key);

  final TextEditingController controladorTexto;
  final String textoEntrada;
  final String textoValidacion;
  final int icono; //1-con icono 0-sin icono
  final IconData icon;
  final Color colorborde;
  final bool oscurecer;
  final int tipoValidacion; //0-vacio ,1- email ,2 -contrasena
  final TextEditingController textoContrasena;
  final int habilita; //0-habilita 1deshabilita

  @override
  _InputTextFormularioState createState() => _InputTextFormularioState();
}

class _InputTextFormularioState extends State<InputTextFormulario> {
  Color colortexto = Colors.black;

  @override
  void initState() {
    super.initState();
    colortexto = Colors.black;
  }

  @override
  Widget build(BuildContext context) {
    String? validateEmail(String value) {
      String pattern =
          r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
          r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
          r"{0,253}[a-zA-Z0-9])?)*$";
      RegExp regex = RegExp(pattern);
      if (!regex.hasMatch(value)) {
        return 'Ingrese una direccion de correo valida';
      } else {
        return null;
      }
    }

    return TextFormField(
      //maxLines: 2,
      enabled: widget.habilita == 1 ? false : true,
      maxLines: null,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      style: TextStyle(fontSize: 12, color: colortexto),
      controller: widget.controladorTexto,
      obscureText: widget.oscurecer,
      decoration: widget.icono == 1
          ? InputDecoration(
              errorStyle: const TextStyle(
                  fontFamily: 'DM Sans', height: 0, fontSize: 9),
              prefixIcon: Icon(
                widget.icon,
                color: const Color(0xFF757575),
                size: 18,
              ),
              contentPadding: const EdgeInsets.all(8.0),
              fillColor: const Color(0xFFFFFFFF).withOpacity(0.7),
              filled: true,
              border: InputBorder.none,
              enabledBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                borderSide: BorderSide(
                  color: widget.colorborde,
                ),
              ),
              hintText: widget.textoEntrada,
              hintStyle: const TextStyle(
                  fontFamily: 'DM Sans',
                  fontSize: 12,
                  color: Color(0xFF707070)),
              focusedBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                borderSide: BorderSide(
                  color: widget.colorborde,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                borderSide: BorderSide(
                  color: widget.colorborde,
                ),
              ),
            )
          : InputDecoration(
              errorStyle: const TextStyle(
                  fontFamily: 'DM Sans', height: 0, fontSize: 9),
              contentPadding: const EdgeInsets.all(8.0),
              fillColor: const Color(0xFFFFFFFF).withOpacity(0.7),
              filled: true,
              border: InputBorder.none,
              enabledBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                borderSide: BorderSide(
                  color: widget.colorborde,
                ),
              ),
              hintText: widget.textoEntrada,
              hintStyle: const TextStyle(
                  fontFamily: 'DM Sans',
                  fontSize: 12,
                  color: Color(0xFF707070)),
              focusedBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                borderSide: BorderSide(
                  color: widget.colorborde,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                borderSide: BorderSide(
                  color: widget.colorborde,
                ),
              ),
            ),
      validator: (value) {
        /*  if (widget.tipoValidacion == 4) {
          return widget.textoValidacion;
          // colortexto = Colors.red;
          //widget.controladorTexto.text = widget.textoValidacion;
          //setState(() {});

          //return 'ok';

        }*/
        if (widget.tipoValidacion == 0) {
          if (value == null || value.isEmpty) {
            return widget.textoValidacion;
            // colortexto = Colors.red;
            //widget.controladorTexto.text = widget.textoValidacion;
            //setState(() {});

            //return 'ok';
          }
        }
        if (widget.tipoValidacion == 1) {
          return validateEmail(value!);
          //colortexto = Colors.red;
          //widget.controladorTexto.text = widget.textoValidacion;
          //setState(() {});
          //return null;
        }
        if (widget.tipoValidacion == 2) {
          if (value == null || value != widget.textoContrasena.text) {
            //colortexto = Colors.red;
            //widget.controladorTexto.text = widget.textoValidacion;
            //setState(() {});
            //return null;
            return widget.textoValidacion;
          }
        }
        return null;
      },
    );

    //);
  }
}
