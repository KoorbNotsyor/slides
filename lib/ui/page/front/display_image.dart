import 'dart:io';
import 'package:flutter/material.dart';

class DisplayImage extends StatelessWidget {
  final String path;

  const DisplayImage({super.key, required this.path});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: Image.file(
          File(path),
          gaplessPlayback: true,
          //fit: BoxFit.fitHeight,
          fit: BoxFit.contain,
          errorBuilder:
              (BuildContext context,
              Object exception,
              StackTrace? stackTrace) {
            final String msg = 'Failed to load $path ERROR [${exception.toString()}]';
            return Text(msg,
                style: const TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    backgroundColor: Colors.white
                ));
          },
        )
    );
  }
}