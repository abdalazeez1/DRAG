import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

enum take { camera, gallery }

class InputImage extends StatefulWidget {
  final Function onSelectImage;
  final bool post ;
  InputImage(this.onSelectImage,this.post);

  @override
  _InputImageState createState() => _InputImageState();
}

class _InputImageState extends State<InputImage>
    with SingleTickerProviderStateMixin {
  File _imageStorage;
  File pathImage;




  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return AnimatedContainer(
        duration: Duration(seconds: 1),
        child: Positioned(
            top: -size.height / 18,
            width: size.width / 2 + size.width / 7,
            height: !false ? size.height / 8 : 0,
            child: GestureDetector(
              onTap:()=> _chosePhoto(context),
              child:
              widget.post?TextButton.icon(onPressed:()=> _chosePhoto(context) ,
                  icon: Icon(Icons.add_to_photos
                  ,color: Colors.indigo,size: 34,), label: Text('CLICK TO ADD PHOTO',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.indigo
                  ),)):
              CircleAvatar(
                foregroundColor: Colors.tealAccent,
                backgroundImage:_imageStorage==null?null: FileImage(_imageStorage),
              ),
            )));
  }

  Future<void> _takePicture(take ta) async {
    File _imageFile;
    if (ta == take.camera)
      // ignore: deprecated_member_use
      _imageFile = await ImagePicker.pickImage(
          source: ImageSource.camera, maxWidth: 50, maxHeight: 50);
    if (ta == take.gallery)
      // ignore: deprecated_member_use
      _imageFile = await ImagePicker.pickImage(
          source: ImageSource.gallery, maxWidth: 50, maxHeight: 50);
    print('after');
    print(_imageFile);
    if (_imageFile == null) return;
    setState(() {
      _imageStorage =_imageFile;
    });
    print(_imageFile);
    print('be');
    widget.onSelectImage(_imageStorage);
//    final appDir = await prov.getApplicationDocumentsDirectory();
//    final fileName = path.basename(_imageFile.path);
//    final savedImage = await _imageStorage.copy('${appDir.path}/$fileName');
//    setState(() {
//      pathImage = savedImage;
//    });
//
//    widget.onselectimage(pathImage);
  }
  void _chosePhoto(BuildContext context){

      showDialog(
          context: context,
          builder: (_) => SimpleDialog(
            children: [
              SimpleDialogOption(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton.icon(
                      onPressed: () {
                        _takePicture(take.camera);
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.photo_camera,color: Colors.indigo,),
                      label: Text('take photo',
                      style: TextStyle(color: Colors.indigo),)),
                ),
              ),
              SimpleDialogOption(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton.icon(
                        onPressed: () {
                          _takePicture(take.gallery);
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.photo_library_sharp,color: Colors.indigo),
                        label: Text('chose photo from gallery',  style: TextStyle(color: Colors.indigo),)),
                  )),
            ],
          ));
    }

}
