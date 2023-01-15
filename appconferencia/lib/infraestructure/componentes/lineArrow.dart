// ignore_for_file: file_names

import 'package:flutter/material.dart';

import '../../constants.dart';

class LineArrow extends StatelessWidget {
  const LineArrow({
    Key? key,
    required this.size,
    required this.texto,
    required this.ultimo,
    required this.press,
  }) : super(key: key);

  final Size size;

  final String texto;
  final IconData ultimo;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(kDefaultPadding / 12),
        //margin: EdgeInsets.fromLTRB(kDefaultPadding, 0, 0, 0),
        width: size.width,
        height: 42,
        decoration: BoxDecoration(color: ColorBackground, boxShadow: [
          BoxShadow(
            offset: const Offset(0, 0),
            blurRadius: 0,
            color: ColorPrimario.withOpacity(0.23),
          )
        ]),
        child: Container(
            width: size.width,
            height: 50,
            margin: const EdgeInsets.fromLTRB(kDefaultPadding, 0, 0, 0),
            child: Stack(
              children: [
                Positioned(
                    left: 3,
                    top: 10,
                    child: Text(
                      texto,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w300,
                      ),
                    )),
                Positioned(
                  left: size.width - 70,
                  top: -5,
                  child: IconButton(icon: Icon(ultimo), onPressed: press()),
                ),
              ],
            )));
  }
}
