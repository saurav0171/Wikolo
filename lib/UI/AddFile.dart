// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';


class UploadFile extends StatefulWidget {
  const UploadFile({ Key? key }) : super(key: key);

  @override
  State<UploadFile> createState() => _UploadFileState();
}

class _UploadFileState extends State<UploadFile> {
 var _image;
 var imageList;
 var _cameraImage;
 var _video;
 var _cameraVideo;

  ImagePicker picker = ImagePicker();

  late VideoPlayerController _videoPlayerController;
  late VideoPlayerController _cameraVideoPlayerController;
  var profileImage; 
  var selectedImage;
  // This funcion will helps you to pick and Image from Gallery
  _pickImageFromGallery() async {
     var image = await ImagePicker().pickMultiImage(
            imageQuality: 70,
     );
 
      // Uint8List imagebytes = await  File(image!.path).readAsBytes(); //convert to bytes
      // String base64string = "data:image/png;base64,"+base64Encode(imagebytes);//convert bytes to base64 string

    setState(() {
      imageList = image;
    });
  }

  // This funcion will helps you to pick and Image from Camera
  _pickImageFromCamera() async {
   var image = await ImagePicker().pickImage(
        source: ImageSource.camera, imageQuality: 70);

    //  Uint8List imagebytes = await  File(image!.path).readAsBytes(); //convert to bytes
    //   String base64string = "data:image/png;base64,"+base64Encode(imagebytes); //convert bytes to base64 string

    setState(() {
      profileImage = File(image!.path);
      selectedImage = image.path;
    });
  }

  // This funcion will helps you to pick a Video File
  _pickVideo() async {
    var pickedFile = await picker.pickVideo(source: ImageSource.gallery);

    _video = File(pickedFile!.path);

    _videoPlayerController = VideoPlayerController.file(_video)
      ..initialize().then((_) {
        setState(() {});
        _videoPlayerController.play();
      });
  }

  // This funcion will helps you to pick a Video File from Camera
  _pickVideoFromCamera() async {
    var pickedFile = await picker.pickVideo(source: ImageSource.camera);

    _cameraVideo = File(pickedFile!.path);

    _cameraVideoPlayerController = VideoPlayerController.file(_cameraVideo)
      ..initialize().then((_) {
        setState(() {});
        _cameraVideoPlayerController.play();
      });
  }

  Widget _previewImages() {
    if (imageList != null) {
      return Container(
        height: 500,
        child: Semantics(
            child: ListView.builder(
              key: UniqueKey(),
              itemBuilder: (BuildContext context, int index) {
                // Why network for web?
                // See https://pub.dev/packages/image_picker#getting-ready-for-the-web-platform
                return Semantics(
                  label: 'image_picker_example_picked_image',
                  child:Image.file(File(imageList![index].path)),
                );
              },
              itemCount: imageList!.length,
            ),
            label: 'image_picker_example_picked_images'),
      );
    }else {
      return const Text(
        'You have not yet picked an image.',
        textAlign: TextAlign.center,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Image / Video Picker"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                if (_image != null)
                  Image.file(_image)
                else
                  Text(
                    "Click on Pick Image to select an Image",
                    style: TextStyle(fontSize: 18.0),
                  ),
                ElevatedButton(
                  onPressed: () {
                    _pickImageFromGallery();
                  },
                  child: Text("Pick Image From Gallery"),
                ),
                SizedBox(
                  height: 16.0,
                ),
                if (_cameraImage != null)
                  Image.file(_cameraImage)
                else
                  Text(
                    "Click on Pick Image to select an Image",
                    style: TextStyle(fontSize: 18.0),
                  ),
                ElevatedButton(
                  onPressed: () {
                    _pickImageFromCamera();
                  },
                  child: Text("Pick Image From Camera"),
                ),
                if (_video != null)
                  _videoPlayerController.value.isInitialized
                      ? AspectRatio(
                          aspectRatio: _videoPlayerController.value.aspectRatio,
                          child: VideoPlayer(_videoPlayerController),
                        )
                      : Container()
                else
                  Text(
                    "Click on Pick Video to select video",
                    style: TextStyle(fontSize: 18.0),
                  ),
                ElevatedButton(
                  onPressed: () {
                    _pickVideo();
                  },
                  child: Text("Pick Video From Gallery"),
                ),
                if (_cameraVideo != null)
                  _cameraVideoPlayerController.value.isInitialized
                      ? AspectRatio(
                          aspectRatio:
                              _cameraVideoPlayerController.value.aspectRatio,
                          child: VideoPlayer(_cameraVideoPlayerController),
                        )
                      : Container()
                else
                  Text(
                    "Click on Pick Video to select video",
                    style: TextStyle(fontSize: 18.0),
                  ),
                ElevatedButton(
                  onPressed: () {
                    _pickVideoFromCamera();
                  },
                  child: Text("Pick Video From Camera"),
                ),

              _previewImages()

              ],
            ),
          ),
        ),
      ),
    );
  }
}