// ignore_for_file: prefer_const_constructors
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:wikolo/CommonFiles/common.dart';
import 'package:wikolo/UI/Golive.dart';

class UploadPost extends StatefulWidget {
  @override
  UploadPostState createState() => UploadPostState();
}

class UploadPostState extends State<UploadPost> {
  String typeselected = "Go live";
  var buttonIndex = 1; //1 for Live, 2 for Videos, 3 for Images
  var _video;
  var _cameraVideo;
  var _imageList;
  late VideoPlayerController _videoPlayerController;
  late VideoPlayerController _cameraVideoPlayerController;
  ImagePicker picker = ImagePicker();

  pickVideo() async {
    var pickedFile = await picker.pickVideo(source: ImageSource.gallery);

    _video = File(pickedFile!.path);

    _videoPlayerController = VideoPlayerController.file(_video)
      ..initialize().then((_) {
        setState(() {});
        _videoPlayerController.play();
      });
  }

  // This funcion will helps you to pick a Video File from Camera
  pickVideoFromCamera() async {
    var pickedFile = await picker.pickVideo(source: ImageSource.camera);

    _cameraVideo = File(pickedFile!.path);

    _cameraVideoPlayerController = VideoPlayerController.file(_cameraVideo)
      ..initialize().then((_) {
        setState(() {});
        _cameraVideoPlayerController.play();
      });
  }

  void showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: Wrap(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Upload Video',
                          style: TextStyle(color: labelColor, fontSize: 18),
                        ),
                        TextButton(
                            style: ButtonStyle(
                                padding: MaterialStateProperty.all(
                                    EdgeInsets.symmetric(
                                        vertical: 0.0, horizontal: 0.0))),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.close_rounded,
                              color: colorLocalGrey,
                              size: 24,
                            ))
                      ],
                    ),
                  ),
                  Container(
                    height: 2,
                    width: MediaQuery.of(context).size.width,
                    color: colorLocalBackgroundLightGrey,
                  ),
                  ListTile(
                    leading: Icon(Icons.photo_camera),
                    title: Text(
                      'Record Video',
                      style: TextStyle(color: labelColor, fontSize: 16),
                    ),
                    onTap: () {
                      pickVideoFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 40),
                    child: ListTile(
                        leading: Icon(Icons.image_rounded),
                        title: Text(
                          'Choose Existing Video',
                          style: TextStyle(color: labelColor, fontSize: 16),
                        ),
                        onTap: () {
                          pickVideo();
                          Navigator.of(context).pop();
                        }),
                  ),
                ],
              ),
            ),
          );
        });
  }

  pickImageFromGallery() async {
    var image = await ImagePicker().pickMultiImage(
      imageQuality: 70,
    );
    // Uint8List imagebytes = await  File(image!.path).readAsBytes(); //convert to bytes
    // String base64string = "data:image/png;base64,"+base64Encode(imagebytes);//convert bytes to base64 string
    setState(() {
      _imageList = image;
    });
  }

  Widget designForVideo() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 15.0, left: 30.0, right: 30.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Upload Video",
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Quicksand',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Padding(
            padding:
                EdgeInsets.only(top: 10, left: 30.0, right: 30.0, bottom: 10),
            child: Container(
              height: 200,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Color(0xFFF3F3F3),
              ),
              child: Stack(
                children: [
                  if (_video != null)
                    _videoPlayerController.value.isInitialized
                        ? InkWell(
                            onTap: () {
                              if (_videoPlayerController.value.isPlaying) {
                                _videoPlayerController.pause();
                              } else {
                                _videoPlayerController.play();
                              }
                            },
                            child: Container(
                              height: 200,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                color: Color(0xFFF3F3F3),
                              ),
                              width: MediaQuery.of(context).size.width,
                              child: AspectRatio(
                                aspectRatio:
                                    _videoPlayerController.value.aspectRatio,
                                child: VideoPlayer(_videoPlayerController),
                              ),
                            ),
                          )
                        : Container(),
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                        onPressed: () {
                          showPicker(context);
                        },
                        icon: Icon(
                          Icons.add_circle_sharp,
                          color: Colors.grey,
                        )),
                  )
                ],
              ),
            ))
      ],
    );
  }

  Widget designForImage() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 15.0, left: 30.0, right: 30.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Upload Images",
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Quicksand',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Padding(
            padding:
                EdgeInsets.only(top: 10, left: 30.0, right: 30.0, bottom: 10),
            child: Container(
              height: 150,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Color(0xFFF3F3F3),
              ),
              child: Stack(
                children: [
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Color(0xFFF3F3F3),
                    ),
                    width: MediaQuery.of(context).size.width,
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                        onPressed: () {
                          pickImageFromGallery();
                        },
                        icon: Icon(
                          Icons.add_circle_sharp,
                          color: Colors.grey,
                        )),
                  )
                ],
              ),
            )),
        (_imageList != null && _imageList.length > 0)
            ? Padding(
                padding: EdgeInsets.only(
                    top: 10, left: 30.0, right: 30.0, bottom: 10),
                child: Container(
                  height: 300,
                  width: MediaQuery.of(context).size.width,
                  child: GridView.count(
                    crossAxisCount: 4,
                    crossAxisSpacing: 7,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.7,
                    children: [
                      ..._imageList.map(
                        (i) => Container(
                          child: Stack(
                            children: [
                              Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Image.file(File(i.path)),
                              ),
                              Align(
                                alignment: Alignment(1.5, -1.2),
                                child: IconButton(
                                    padding: EdgeInsets.all(0),
                                    onPressed: () {
                                      setState(() {
                                        _imageList.remove(i);
                                      });
                                    },
                                    icon: Icon(
                                      Icons.remove_circle,
                                      color: Colors.grey,
                                    )),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : Container()
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          actions: <Widget>[
            TextButton(
              onPressed: () {},
              child: Text(""),
            ),
          ],
          leading: BackButton(
            color: Colors.black,
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Center(
            child: Text(
              'Upload a Post',
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Quicksand',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: Color.fromRGBO(252, 252, 252, 1),
          ),
          child: Scrollbar(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 5),
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 80,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width * 0.28,
                          height: 40.0,
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                typeselected = "Go Live";
                                buttonIndex = 1;
                              });
                            },
                            child: Text(
                              "Go Live",
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Quicksand',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        buttonIndex == 1
                                            ? colorLocalPink
                                            : colorLocalDarkGrey),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                ))),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.28,
                          height: 40.0,
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                typeselected = "Video";
                                buttonIndex = 2;
                              });
                            },
                            child: Text(
                              "Video",
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Quicksand',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        buttonIndex == 2
                                            ? colorLocalPink
                                            : colorLocalDarkGrey),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                ))),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.28,
                          height: 40.0,
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                typeselected = "Images";
                                buttonIndex = 3;
                              });
                            },
                            child: Text(
                              "Images",
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Quicksand',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        buttonIndex == 3
                                            ? colorLocalPink
                                            : colorLocalDarkGrey),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                ))),
                          ),
                        ),
                      ],
                    ),
                  ),
                  buttonIndex == 1
                      ? GoLiveExtension()
                      : Padding(
                          padding: EdgeInsets.only(
                              top: 15.0, left: 30.0, right: 30.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Category",
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Quicksand',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                  Padding(
                    padding:
                        EdgeInsets.only(top: 10.0, left: 30.0, right: 30.0),
                    child: Container(
                      padding: EdgeInsets.only(top: 0.0),
                      height: 50.0,
                      width: MediaQuery.of(context).size.width * 0.85,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5),
                            bottomLeft: Radius.circular(5),
                            topRight: Radius.circular(5),
                            bottomRight: Radius.circular(5),
                          ),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromRGBO(240, 240, 240, 1),
                              blurRadius: 9.0,
                              spreadRadius: 1.0,
                            ),
                          ]),
                      child: TextFormField(
                        textCapitalization: TextCapitalization.words,
                        autofocus: false,
                        textAlign: TextAlign.left,
                        decoration: InputDecoration(
                          hintText: 'Choose your Category',
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: Colors.white)),
                          disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: Colors.white)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: colorLocalPink)),
                          fillColor: Color(0xFFF3F3F3),
                          filled: true,
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontFamily: 'Quicksand',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding:
                        EdgeInsets.only(top: 15.0, left: 30.0, right: 30.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Location",
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Quicksand',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(top: 10.0, left: 30.0, right: 30.0),
                    child: Container(
                      padding: EdgeInsets.only(top: 0.0),
                      height: 50.0,
                      width: MediaQuery.of(context).size.width * 0.85,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5),
                            bottomLeft: Radius.circular(5),
                            topRight: Radius.circular(5),
                            bottomRight: Radius.circular(5),
                          ),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromRGBO(240, 240, 240, 1),
                              blurRadius: 9.0,
                              spreadRadius: 1.0,
                            ),
                          ]),
                      child: TextField(
                        textCapitalization: TextCapitalization.words,
                        autofocus: false,
                        textAlign: TextAlign.left,
                        decoration: InputDecoration(
                          hintText: 'Enter your Location',
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: Colors.white)),
                          disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: Colors.white)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: colorLocalPink)),
                          fillColor: Color(0xFFF3F3F3),
                          suffixIcon: Icon(
                            Icons.my_location,
                            color: colorLocalPink,
                          ),
                          filled: true,
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontFamily: 'Quicksand',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(top: 15.0, left: 30.0, right: 30.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Title",
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Quicksand',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(top: 10.0, left: 30.0, right: 30.0),
                    child: Container(
                      padding: EdgeInsets.only(top: 0.0),
                      height: 50.0,
                      width: MediaQuery.of(context).size.width * 0.85,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5),
                            bottomLeft: Radius.circular(5),
                            topRight: Radius.circular(5),
                            bottomRight: Radius.circular(5),
                          ),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromRGBO(240, 240, 240, 1),
                              blurRadius: 9.0,
                              spreadRadius: 1.0,
                            ),
                          ]),
                      child: TextFormField(
                        textCapitalization: TextCapitalization.words,
                        autofocus: false,
                        textAlign: TextAlign.left,
                        decoration: InputDecoration(
                          hintText: 'Enter Title',
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: Colors.white)),
                          disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: Colors.white)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: colorLocalPink)),
                          fillColor: Color(0xFFF3F3F3),
                          filled: true,
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontFamily: 'Quicksand',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  buttonIndex == 2 ? designForVideo() : designForImage(),
                  Padding(
                    padding:
                        EdgeInsets.only(top: 15.0, left: 30.0, right: 30.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Description",
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Quicksand',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: 10, left: 30.0, right: 30.0, bottom: 10),
                    child: TextFormField(
                      textCapitalization: TextCapitalization.words,
                      autofocus: false,
                      keyboardType: TextInputType.multiline,
                      maxLines: 10,
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
                        hintText: 'Description in 250 words',
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(color: Colors.white)),
                        disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(color: Colors.white)),
                        focusedBorder: InputBorder.none,
                        fillColor: Color(0xFFF3F3F3),
                        filled: true,
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontFamily: 'Quicksand',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 20),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.28,
                      height: 40.0,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          "Upload",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Quicksand',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                colorLocalPink),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ))),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
