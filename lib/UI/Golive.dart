// ignore_for_file: prefer_const_constructors
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wikolo/CommonFiles/common.dart';
import 'package:wikolo/ServerFiles/service_api.dart';
import 'package:wikolo/UI/PaymentScreen.dart';
import 'package:wikolo/UI/join_channel_video.dart';

class GoLive extends StatelessWidget {
  bool isGoLive;
  final Map object;
  Function updateData;
  GoLive(
      {Key? key,
      required this.isGoLive,
      required this.object,
      required this.updateData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Center(
          child: Text(
            'Go Live',
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Quicksand',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
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
      ),
      body: GoLiveExtension(
        isGoLive: isGoLive,
        object: object,
        updateData: updateData,
      ),
    ));
  }
}

class GoLiveExtension extends StatefulWidget {
  bool isGoLive;
  final Map object;
  Function updateData;
  GoLiveExtension(
      {Key? key,
      required this.isGoLive,
      required this.object,
      required this.updateData})
      : super(key: key);

  @override
  State<GoLiveExtension> createState() => _GoLiveExtensionState();
}

class _GoLiveExtensionState extends State<GoLiveExtension> {
  bool isFree = true; // true for Free and false For Paid
  bool letUserJoin = false; // true for Yes and false For No
  TextEditingController categoryController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController pricePerUserController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.object.isNotEmpty) {
      setState(() {
        categoryController.text = widget.object[kDataCategory];
        titleController.text = widget.object[kDataTitle];
        descriptionController.text = widget.object[kDataDescription];
        locationController.text = widget.object[kDataLocation];
        priceController.text = widget.object[kDataStreamType] == "paid"
            ? widget.object[kDataPrice].toString()
            : '';
        pricePerUserController.text =
            widget.object[kDataLiveStreamJoin] == "yes"
                ? widget.object[kDataPricePerUser].toString()
                : '';
        isFree = widget.object[kDataStreamType] == "paid" ? false : true;
        letUserJoin =
            widget.object[kDataLiveStreamJoin] == "yes" ? true : false;
      });
    }
  }

  Widget paidView() {
    return Visibility(
      visible: !isFree,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 10.0, left: 30.0, right: 30.0),
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
                controller: priceController,
                keyboardType: TextInputType.datetime,
                textInputAction: TextInputAction.done,
                textAlign: TextAlign.left,
                decoration: InputDecoration(
                  hintText: 'Enter your Price',
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
          Padding(
            padding: EdgeInsets.only(top: 15.0, left: 30.0, right: 30.0),
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
            padding: EdgeInsets.only(top: 10.0, left: 30.0, right: 30.0),
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
                controller: categoryController,
                textInputAction: TextInputAction.done,
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
          Padding(
            padding: EdgeInsets.only(top: 15.0, left: 30.0, right: 30.0),
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
            padding: EdgeInsets.only(top: 10.0, left: 30.0, right: 30.0),
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
                controller: titleController,
                textInputAction: TextInputAction.done,
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
          Padding(
            padding: EdgeInsets.only(top: 15.0, left: 30.0, right: 30.0),
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
            padding:
                EdgeInsets.only(top: 10, left: 30.0, right: 30.0, bottom: 10),
            child: TextFormField(
              textCapitalization: TextCapitalization.words,
              autofocus: false,
              controller: descriptionController,
              keyboardType: TextInputType.multiline,
              maxLines: 10,
              textInputAction: TextInputAction.done,
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
            padding: EdgeInsets.only(top: 15.0, left: 30.0, right: 30.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Let the users to join the live stream ?",
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Quicksand',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 5),
            width: MediaQuery.of(context).size.width * 0.65,
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
                        letUserJoin = true;
                      });
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => PaymentScreen()));
                    },
                    child: Text(
                      "Yes",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Quicksand',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            !letUserJoin ? colorLocalDarkGrey : colorLocalPink),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
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
                        letUserJoin = false;
                      });
                    },
                    child: Text(
                      "No",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Quicksand',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            letUserJoin ? colorLocalDarkGrey : colorLocalPink),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ))),
                  ),
                ),
              ],
            ),
          ),
          Visibility(
            visible: letUserJoin,
            child: Padding(
              padding: EdgeInsets.only(
                  top: 10.0, left: 30.0, right: 30.0, bottom: 20),
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
                  keyboardType: TextInputType.datetime,
                  controller: pricePerUserController,
                  textAlign: TextAlign.left,
                  decoration: InputDecoration(
                    hintText: 'Enter fee per user',
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
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: widget.isGoLive
          ? MediaQuery.of(context).size.height
          : MediaQuery.of(context).size.height - 120,
      decoration: BoxDecoration(
          // color: Color.fromRGBO(252, 252, 252, 1),
          ),
      child: Scrollbar(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 15.0, left: 30.0, right: 30.0),
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
                padding: EdgeInsets.only(top: 10.0, left: 30.0, right: 30.0),
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
                    controller: locationController,
                    textInputAction: TextInputAction.done,
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
                padding: EdgeInsets.only(top: 15.0, left: 30.0, right: 30.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Stream Type",
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Quicksand',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 5),
                width: MediaQuery.of(context).size.width * 0.65,
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
                            isFree = false;
                          });
                        },
                        child: Text(
                          "Paid",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Quicksand',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                isFree ? colorLocalDarkGrey : colorLocalPink),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
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
                            isFree = true;
                          });
                        },
                        child: Text(
                          "Free",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Quicksand',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                !isFree ? colorLocalDarkGrey : colorLocalPink),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ))),
                      ),
                    ),
                  ],
                ),
              ),
              paidView(),
              Padding(
                padding: const EdgeInsets.only(bottom: 80),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.28,
                  height: 40.0,
                  child: ElevatedButton(
                    onPressed: () {
                      ShowLoader(context);
                      updateLivePost();
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
                            MaterialStateProperty.all<Color>(colorLocalPink),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ))),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  updateLivePost() async {
    Map param = Map();
    var http = "POST";
    var url = "$baseUrl/cwbi/";
    if (widget.object.isNotEmpty) {
      url = "$baseUrl/uwbid/";
      param['status'] = "l"; // l for Live and o for Offline
      http = "PUT";
      param['id'] = widget.object[kDataID].toString();
    }

    param['category'] = categoryController.text;
    param['location'] = locationController.text;
    param['title'] = titleController.text;
    param['description'] = descriptionController.text;
    param['price'] = priceController.text;
    param['priceperuser'] = pricePerUserController.text;
    param['streamtype'] = isFree ? "free" : "paid";
    param['livestreamjoin'] = letUserJoin ? "yes" : "no";
    param['utype'] = 'golive';
    var result = await CallApi(http, param, url, context);
    HideLoader(context);
    if (result[kDataCode] == "200") {
      if (widget.object.isNotEmpty) {
        widget.updateData();
        ShowSuccessMessage("Post Updated Successfully", context);
        Timer(Duration(seconds: 1), () {
          Navigator.pop(context);
        });
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => JoinChannelVideo()),
        );
      }
    } else {
      ShowErrorMessage(result[kDataMessage], context);
    }
  }
}
