import 'package:flutter/material.dart';

void showChooseImageDialog({required BuildContext context,required Function onCameraTap,required Function onGalleryTap,required Function onRemoveTap}) {
  showDialog(
    context: context,
    

    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Choose Option"),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library,color: Colors.amber,),
                title: const Text('Gallery'),
                onTap: () {
                 onGalleryTap();
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera,color: Colors.blue),
                title: const Text('Camera'),
                onTap: () {
                 
                  onCameraTap();
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.remove_circle,color: Colors.red ,),
                title: const Text('Remove'),
                onTap: () {
                  onRemoveTap();
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
      );
    },
  );
}
