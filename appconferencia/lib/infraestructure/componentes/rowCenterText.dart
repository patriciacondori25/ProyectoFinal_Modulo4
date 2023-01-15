// ignore_for_file: file_names

import 'package:flutter/material.dart';
import '../../../../constants.dart';

class RowCenterText extends StatelessWidget {
  const RowCenterText({
    Key? key,
    required this.texto,
  }) : super(key: key);
  final String texto;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(kDefaultPadding / 2),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              texto,
              style: const TextStyle(
                color: ColorNegro,
                fontSize: 16,
                fontFamily: "Poppins",
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
