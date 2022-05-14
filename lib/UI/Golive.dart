// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:wikolo/CommonFiles/common.dart';

class GoLive extends StatelessWidget {
  const GoLive({Key? key}) : super(key: key);

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
      body: GoLiveExtension(),
    ));
  }
}

class GoLiveExtension extends StatefulWidget {
  const GoLiveExtension({Key? key}) : super(key: key);

  @override
  State<GoLiveExtension> createState() => _GoLiveExtensionState();
}

class _GoLiveExtensionState extends State<GoLiveExtension> {
  bool isFree = true; // true for Free and false For Paid
  bool letUserJoin = false; // true for Yes and false For No

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
                      //         builder: (context) => UploadPost()));
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
          SizedBox(
            height: 40,
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
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
              paidView()
            ],
          ),
        ),
      ),
    );
  }
}
