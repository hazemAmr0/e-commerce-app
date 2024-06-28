import 'dart:io';

import 'package:e_commerce_app/consts/choose_image_dialog.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PicImage extends StatefulWidget {
  const PicImage(
      {super.key, required this.pickedImage, required this.onCameraTap});
  final XFile? pickedImage;
  final Function onCameraTap;

  @override
  State<PicImage> createState() => _PicImageState();
}

class _PicImageState extends State<PicImage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: widget.pickedImage == null
                ? Container(
                   color: Colors.white,
                    height: 100,
                    width: 100,
                    child:Icon(Icons.person_outline,size: 100,color: Colors.black,)
                  )
                : 
                   Container(
                    height: 100,
                    width: 100,
                    child: Image.file(
                        File(widget.pickedImage!.path),
                        fit: BoxFit.cover,
                      ),
                  
                ),
          ),
        ),
        Positioned(
          right: 0,
          child: Material(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            child: InkWell(
              onTap: () {
                widget.onCameraTap();
              },
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Icon(
                  Icons.camera_alt,
                  size: 20,
                  color: Colors.blue,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
