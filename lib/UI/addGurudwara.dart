import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:wikolo/ServerFiles/service_api.dart';

import '../CommonFiles/common.dart';
import '../Globals/loginData.dart';

class AddGurudwara extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Stack(
        children: <Widget>[
          Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(color: appBackgroundColor)),
          Scaffold(
            backgroundColor: Colors.white,
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              title: const Text(
                "vwihgurU",
                style: TextStyle(color: Colors.white, fontSize: 40),
              ),
            ),
            body: const AddGurudwaraExtension(),
          ),
        ],
      ),
    );
  }
}

class AddGurudwaraExtension extends StatefulWidget {
  const AddGurudwaraExtension({Key? key}) : super(key: key);

  @override
  State<AddGurudwaraExtension> createState() => _AddGurudwaraExtensionState();
}

class _AddGurudwaraExtensionState extends State<AddGurudwaraExtension> {
  // FocusNode gurudwaraNameNode = FocusNode();
  FocusNode firstNameFocusNode = FocusNode();
  FocusNode lastNameFocusNode = FocusNode();
  FocusNode usernameFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode dateNode = FocusNode();
  FocusNode phoneNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  TextEditingController gurudwarNameController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  final dateFormat = DateFormat("yyyy-MM-dd");
  KeyboardActionsConfig _buildConfig(BuildContext context) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
      keyboardBarColor: Colors.grey[200],
      nextFocus: true,
      actions: [
        KeyboardActionsItem(
          focusNode: firstNameFocusNode,
        ),
        KeyboardActionsItem(
          focusNode: lastNameFocusNode,
        ),
        KeyboardActionsItem(
          focusNode: usernameFocusNode,
        ),
        KeyboardActionsItem(
          focusNode: emailFocusNode,
        ),
        KeyboardActionsItem(
          focusNode: dateNode,
        ),
        KeyboardActionsItem(
          focusNode: phoneNode,
        ),
        KeyboardActionsItem(
          focusNode: passwordFocusNode,
        ),
      ],
    );
  }

  final loginKey = GlobalKey<FormState>();
  LoginData loginObj = new LoginData();
  DateTime? dueDate;
  String pickedDate = '';

  List teamList = [
    {'name': 'Male'},
    {'name': 'Female'},
    {"name": 'Others'}
  ];
  List<String> teamListString = ['Male', 'Female', 'Others'];
  var selectedTeam;
  Map selectedTeamObject = {};

  @override
  void initState() {
    super.initState();
    firstNameFocusNode.addListener(() {
      setState(() {});
    });
    lastNameFocusNode.addListener(() {
      setState(() {});
    });
    usernameFocusNode.addListener(() {
      setState(() {});
    });
    emailFocusNode.addListener(() {
      setState(() {});
    });
    dateNode.addListener(() {
      setState(() {});
    });
    phoneNode.addListener(() {
      setState(() {});
    });
    passwordFocusNode.addListener(() {
      setState(() {});
    });
  }

  var profileImage;
  var selectedImage;
  @override
  void dispose() {
    super.dispose();
    firstNameFocusNode.removeListener(() {
      setState(() {});
    });
    lastNameFocusNode.removeListener(() {
      setState(() {});
    });
    usernameFocusNode.removeListener(() {
      setState(() {});
    });
    emailFocusNode.removeListener(() {
      setState(() {});
    });
    dateNode.removeListener(() {
      setState(() {});
    });
    phoneNode.removeListener(() {
      setState(() {});
    });
    passwordFocusNode.removeListener(() {
      setState(() {});
    });
  }

  _imgFromCamera() async {
    var image = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 70);

    //  Uint8List imagebytes = await  File(image!.path).readAsBytes(); //convert to bytes
    //   String base64string = "data:image/png;base64,"+base64Encode(imagebytes); //convert bytes to base64 string

    setState(() {
      profileImage = File(image!.path);
      selectedImage = image.path;
    });
  }

  _imgFromGallery() async {
    var image = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 70);

    // Uint8List imagebytes = await  File(image!.path).readAsBytes(); //convert to bytes
    // String base64string = "data:image/png;base64,"+base64Encode(imagebytes);//convert bytes to base64 string

    setState(() {
      profileImage = File(image!.path);
      selectedImage = image.path;
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
                          'Change Profile Picture',
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
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text(
                      'Take Photo',
                      style: TextStyle(color: labelColor, fontSize: 16),
                    ),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 40),
                    child: new ListTile(
                        leading: new Icon(Icons.image_rounded),
                        title: new Text(
                          'Choose Existing Photo',
                          style: TextStyle(color: labelColor, fontSize: 16),
                        ),
                        onTap: () {
                          _imgFromGallery();
                          Navigator.of(context).pop();
                        }),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardActions(
      config: _buildConfig(context),
      child: Container(
          child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Form(
                key: loginKey,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(20, 20, 20, 10),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: colorLocalOrange,
                                ),
                                child: TextButton(
                                  style: ButtonStyle(
                                      padding: MaterialStateProperty.all(
                                          EdgeInsets.symmetric(
                                              vertical: 0.0, horizontal: 0.0))),
                                  child: const Text("Sign Up",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18,
                                          color: Colors.white,
                                          fontStyle: FontStyle.normal)),
                                  onPressed: () {
                                    FocusManager.instance.primaryFocus!
                                        .unfocus();
                                    // if (loginKey.currentState!.validate()) {
                                    ShowLoader(context);
                                    SchedulerBinding.instance
                                        .addPostFrameCallback((_) =>
                                            createUser(loginObj, context));
                                    // }
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ))),
    );
  }

  void createUser(LoginData register, BuildContext context) async {
    // Map param = Map();
    // param["fullname"] = register.firstName;
    // param["user"] = register.username;
    // param["gender"] = selectedTeam;
    // param["dateOfBirth"] = pickedDate;
    // param["phonenumber"] = "+91${register.mobileno}";
    // param["email"] = register.email;
    // param["password"] = register.password;
    // param["profileimg"] = selectedImage;

    var request = http.MultipartRequest(
        "POST", Uri.parse("http://be.codefruits.in/signup/"));
    //add text fields
    //  request.fields["text_field"] = text;
    request.fields["fullname"] = register.firstName;
    request.fields["user.username"] = register.username;
    request.fields["gender"] = selectedTeam;
    request.fields["dateOfBirth"] = pickedDate;
    request.fields["phonenumber"] = "+91${register.mobileno}";
    request.fields["user.email"] = register.email;
    request.fields["user.password"] = register.password;
    //create multipart using filepath, string or bytes
    var pic = await http.MultipartFile.fromPath("profileimg", selectedImage);
    //add multipart to request
    request.files.add(pic);
    var response = await request.send();

    //Get the response from the server
    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    HideLoader(context);
    print(responseString);

    // const url = "http://wikolo.codefruits.in/gwbi/";
    // var result = await CallApi("GET", param, url, context);

    // if (result[kDataCode] == "200") {
    //   print(result);
    // } else {
    //   HideLoader(context);
    //   ShowErrorMessage(result[kDataMessage], context);
    // }
  }
}
