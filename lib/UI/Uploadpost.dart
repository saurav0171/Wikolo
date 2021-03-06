// ignore_for_file: prefer_const_constructors
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:wikolo/CommonFiles/common.dart';
import 'package:wikolo/ServerFiles/service_api.dart';
import 'package:wikolo/UI/ChoosePlan.dart';
import 'package:wikolo/UI/Golive.dart';

class UploadPost extends StatefulWidget {
  final Map object;
  final int updateFor; // 2 for Videos, 3 for Images
  final Function updateVideoList;
  const UploadPost(
      {Key? key,
      required this.object,
      required this.updateFor,
      required this.updateVideoList})
      : super(key: key);
  @override
  UploadPostState createState() => UploadPostState();
}

class UploadPostState extends State<UploadPost> {
  String typeselected = "Go live";
  var buttonIndex = 1; //1 for Live, 2 for Videos, 3 for Images
  var _video;
  var _imageList;
  var pickedVideoFile;
  TextEditingController categoryController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  late VideoPlayerController _videoPlayerController;
  late VideoPlayerController _cameraVideoPlayerController;
  ImagePicker picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    if (widget.object.isNotEmpty) {
      setState(() {
        buttonIndex = widget.updateFor;
        categoryController.text = widget.object[kDataCategory];
        titleController.text = widget.object[kDataTitle];
        descriptionController.text = widget.object[kDataDescription];
        locationController.text = widget.object[kDataLocation];
      });
    }
  }

  pickVideo() async {
    pickedVideoFile = await picker.pickVideo(source: ImageSource.gallery);

    _video = File(pickedVideoFile!.path);

    _videoPlayerController = VideoPlayerController.file(_video)
      ..initialize().then((_) {
        setState(() {});
        _videoPlayerController.play();
      });
  }

  // This funcion will helps you to pick a Video File from Camera
  pickVideoFromCamera() async {
    pickedVideoFile = await picker.pickVideo(source: ImageSource.camera);

    _video = File(pickedVideoFile!.path);

    _videoPlayerController = VideoPlayerController.file(_video)
      ..initialize().then((_) {
        setState(() {});
        _videoPlayerController.play();
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
                  width: MediaQuery.of(context).size.width,
                  child: GridView.count(
                    crossAxisCount: 4,
                    crossAxisSpacing: 7,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
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
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: colorLocalPink,
          actions: <Widget>[
            TextButton(
              onPressed: () {},
              child: Text(""),
            ),
          ],
          leading: BackButton(
            color: Colors.white,
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Center(
            child: Text(
              'Upload a Post',
              style: TextStyle(
                color: Colors.white,
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
                              backgroundColor: MaterialStateProperty.all<Color>(
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
                              backgroundColor: MaterialStateProperty.all<Color>(
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
                              backgroundColor: MaterialStateProperty.all<Color>(
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
                    ? GoLiveExtension(
                        isGoLive: false,
                        object: widget.object,
                        updateData: updatePost,
                      )
                    : Column(
                        children: [
                          Padding(
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
                            padding: EdgeInsets.only(
                                top: 10.0, left: 30.0, right: 30.0),
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
                                textInputAction: TextInputAction.done,
                                controller: categoryController,
                                textAlign: TextAlign.left,
                                decoration: InputDecoration(
                                  hintText: 'Choose your Category',
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  disabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: colorLocalPink)),
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
                            padding: EdgeInsets.only(
                                top: 15.0, left: 30.0, right: 30.0),
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
                            padding: EdgeInsets.only(
                                top: 10.0, left: 30.0, right: 30.0),
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
                                textInputAction: TextInputAction.done,
                                controller: locationController,
                                textAlign: TextAlign.left,
                                decoration: InputDecoration(
                                  hintText: 'Enter your Location',
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  disabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: colorLocalPink)),
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
                            padding: EdgeInsets.only(
                                top: 15.0, left: 30.0, right: 30.0),
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
                            padding: EdgeInsets.only(
                                top: 10.0, left: 30.0, right: 30.0),
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
                                textInputAction: TextInputAction.done,
                                controller: titleController,
                                textAlign: TextAlign.left,
                                decoration: InputDecoration(
                                  hintText: 'Enter Title',
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  disabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: colorLocalPink)),
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
                          widget.object.isEmpty
                              ? buttonIndex == 2
                                  ? designForVideo()
                                  : designForImage()
                              : Container(),
                          Padding(
                            padding: EdgeInsets.only(
                                top: 15.0, left: 30.0, right: 30.0),
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
                              textInputAction: TextInputAction.done,
                              controller: descriptionController,
                              keyboardType: TextInputType.multiline,
                              maxLines: 10,
                              textAlign: TextAlign.left,
                              decoration: InputDecoration(
                                hintText: 'Description in 250 words',
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide:
                                        BorderSide(color: Colors.white)),
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
                                onPressed: () {
                                  // Navigator.of(context).push(PageRouteBuilder(
                                  //     opaque: false,
                                  //     pageBuilder:
                                  //         (BuildContext context, _, __) =>
                                  //             ChoosePlan()));
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) => ChoosePlan()));
                                  ShowLoader(context);
                                  if (widget.object.isNotEmpty) {
                                    updatePost();
                                  } else {
                                    uploadPostToServer();
                                  }
                                },
                                child: Text(
                                  "Upload",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Quicksand',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            colorLocalPink),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                    ))),
                              ),
                            ),
                          ),
                        ],
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }

  updatePost() async {
    final url = "$baseUrl/uwbid/";
    Map param = Map();
    param['id'] = widget.object[kDataID].toString();
    param['category'] = categoryController.text;
    param['location'] = locationController.text;
    param['title'] = titleController.text;
    param['description'] = descriptionController.text;
    param['utype'] = buttonIndex == 2 ? 'video' : 'images';
    var result = await CallApi("PUT", param, url, context);
    HideLoader(context);
    if (result[kDataCode] == "200") {
      print(result);
      widget.updateVideoList();
      ShowSuccessMessage("Post Updated Successfully", context);
      Timer(Duration(seconds: 1), () {
        Navigator.pop(context);
      });
    } else {
      ShowErrorMessage(result[kDataMessage], context);
    }
  }

  uploadPostToServer() async {
    var uri = Uri.parse("$baseUrl/cwbi/");
    http.MultipartRequest request = new http.MultipartRequest('POST', uri);
    Map<String, String> headers = {
      "Accept": "application/json",
      "Authorization": "Token b4bd31d869887c5e03dc87bd38bc045bfe1b09e1"
    }; // ignore this headers if there is no authentication

//add headers
    request.headers.addAll(headers);
    request.fields['category'] = categoryController.text;
    request.fields['location'] = locationController.text;
    request.fields['title'] = titleController.text;
    request.fields['description'] = descriptionController.text;
    request.fields['utype'] = buttonIndex == 2 ? 'video' : 'images';
    //multipartFile = new http.MultipartFile("imagefile", stream, length, filename: basename(imageFile.path));
    if (buttonIndex == 2) {
      var pic =
          await http.MultipartFile.fromPath("wikfile", pickedVideoFile!.path);
      //add multipart to request
      request.files.add(pic);
    } else {
      List<MultipartFile> newList = [];
      for (int i = 0; i < _imageList.length; i++) {
        var pic =
            await http.MultipartFile.fromPath("wikimgs", _imageList[i].path);
        newList.add(pic);
      }
      request.files.addAll(newList);
    }
    var response = await request.send();
    var jsonResponse = {};
    HideLoader(context);
    var responseObject = await http.Response.fromStream(response);
    jsonResponse[kDataResult] = convert.jsonDecode(responseObject.body);
    if (response.statusCode == 200) {
      print("Image Uploaded");
      widget.updateVideoList();
      ShowSuccessMessage("Post Uploaded Successfully", context);
      Timer(Duration(seconds: 1), () {
        Navigator.pop(context);
      });
    } else {
      print("Upload Failed");
    }
    // response.stream.transform(utf8.decoder).listen((value) {
    //   print(value);
    // });
  }
}
