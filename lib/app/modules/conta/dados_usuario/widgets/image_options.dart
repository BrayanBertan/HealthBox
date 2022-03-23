import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageOptionsSheet extends StatelessWidget {
  final Function(File) onImageSelected;

  ImageOptionsSheet(this.onImageSelected);

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
        onClosing: () {},
        builder: (_) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text('Escolha foto',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
              TextButton(
                  onPressed: getFromCamera,
                  child: const Text(
                    'Câmera',
                    style: TextStyle(fontSize: 25, color: Colors.black),
                  )),
              TextButton(
                  onPressed: getFromGallery,
                  child: const Text(
                    'Galeria',
                    style: TextStyle(fontSize: 25, color: Colors.black),
                  )),
            ],
          );
        });
  }

  void getFromCamera() async {
    final file = await ImagePicker().pickImage(source: ImageSource.camera);
    if (file == null) return;
    final image = File(file.path);
    imageSelected(image);
  }

  void getFromGallery() async {
    final file = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (file == null) return;
    final image = File(file.path);
    imageSelected(image);
  }

  void imageSelected(File image) async {
    final pic = await ImageCropper().cropImage(
        sourcePath: image.path,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
        androidUiSettings:
            const AndroidUiSettings(toolbarTitle: 'editar imagem'),
        iosUiSettings: const IOSUiSettings(title: 'editar imagem'));

    if (image != null) onImageSelected(pic!);
  }
}
