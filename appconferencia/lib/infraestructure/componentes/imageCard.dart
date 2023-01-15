// ignore_for_file: file_names

import 'dart:io';
import 'package:flutter/material.dart';
import '../../constants.dart';

class ImageCard extends StatelessWidget {
  const ImageCard({
    Key? key,
    this.onTap,
    this.imagePath,
    this.alto,
    this.ancho,
  }) : super(key: key);

  final Function()? onTap;
  final String? imagePath;

  final double? alto;
  final double? ancho;

  @override
  Widget build(BuildContext context) {
    //final size = MediaQuery.of(context).size;

    return Card(
        elevation: 0,
        child: InkWell(
          onTap: onTap,
          child: Container(
            height: alto,
            padding: const EdgeInsets.all(0),
            width: ancho,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(4.0)),
              image: imagePath!.contains("http")
                  ? DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(imagePath as String))
                  : DecorationImage(image: FileImage(File(imagePath!))),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(),
                Center(
                  child: Icon(
                    Icons.photo_camera,
                    color: ColorPrimario.withAlpha(450),
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
