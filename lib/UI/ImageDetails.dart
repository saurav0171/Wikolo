// ignore_for_file: prefer_const_constructors
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:wikolo/ServerFiles/service_api.dart';
import 'package:wikolo/UI/Channels.dart';
import 'package:wikolo/UI/ImagePostDetails.dart';
import 'package:wikolo/UI/SocialCategory.dart';

import '../CommonFiles/common.dart';

class ImageDetails extends StatefulWidget {
  const ImageDetails({Key? key}) : super(key: key);

  @override
  State<ImageDetails> createState() => _ImageDetailsState();
}

class _ImageDetailsState extends State<ImageDetails> {
  var selectedCategory = 'All';
  List imagesList = [];
  int channelSelectedIndex = 0;
  int radioButtonIndex = 0; // 0 for NOVALUE, 1 for VIDEO, 2 for IMAGES
  bool isVideoSelected = true;
  bool isFree = false;
  final myCategoryArray = [
    ["All"],
    ["Books"],
    ["Electronics"],
    ["Games"],
    ["Fashion"],
    ["Hotels"],
    ["Bars"],
    ["Swimming"],
    ["Cart"],
  ];
  final myCategory = [
    ["assets/images/ic_all.png", "All"],
    ["assets/images/ic_book.png", "Books"],
    ["assets/images/ic_electronic.png", "Electronics"],
    ["assets/images/ic_game.png", "Games"],
    ["assets/images/ic_business.png", "Business & Industry"],
    ["assets/images/ic_pet.png", "Pets & Animals"],
    ["assets/images/ic_service.png", "UI.Services"],
    ["assets/images/ic_health.png", "Health"],
    ["assets/images/ic_fashion.png", "Fashion"],
    ["assets/images/ic_job.png", "Jobs"],
    ["assets/images/ic_food.png", "Food"],
    ["assets/images/ic_kitchen.png", "Kitchen  Appliances"],
    ["assets/images/ic_matrimonial.png", "Matrimonial"],
    ["assets/images/ic_beauty.png", "Beauty"],
    ["assets/images/ic_car.png", "Cars & Vehicles"],
  ];
  setCategory(String category) {
    setState(() {
      selectedCategory = category;
    });
  }

  @override
  void initState() {
    super.initState();
    ShowLoader(context);
    getImages();
  }

  getImages() async {
    final url = "$baseUrl/gwbi/";
    Map param = Map();
    var result = await CallApi("GET", param, url, context);
    HideLoader(context);
    if (result[kDataCode] == "200") {
      print(result);
      setState(() {
        imagesList = result[kDataResult];
      });
    } else {
      HideLoader(context);
      ShowErrorMessage(result[kDataMessage], context);
    }
  }

  Widget _buildListSampleItem(
      String title, int radioStatus, StateSetter setState) {
    var image = '';
    setState(() {
      if (radioStatus == 1) {
        image = isVideoSelected
            ? 'assets/images/ic_tick.png'
            : 'assets/images/ic_circle.png';
      } else if (radioStatus == 2) {
        image = !isVideoSelected
            ? 'assets/images/ic_tick.png'
            : 'assets/images/ic_circle.png';
      }
    });
    return InkWell(
      onTap: () {
        setState(() {
          if (radioStatus == 1) {
            isVideoSelected = true;
          } else if (radioStatus == 2) {
            isVideoSelected = false;
          }
        });
      },
      child: Container(
        height: 30,
        margin: EdgeInsets.only(bottom: 16),
        child: Row(
          children: <Widget>[
            Image.asset(
              image,
              height: 20,
              width: 20,
            ),
            Text(
              title,
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Quicksand',
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  //&*** Looking for Pop Up *********************
  showPopUp(BuildContext context) {
    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      padding: EdgeInsets.all(0),
                      onPressed: () {
                        Navigator.of(context, rootNavigator: true).pop();
                      },
                      icon: Icon(
                        Icons.filter_alt,
                        size: 20,
                      )),
                  Text(
                    "Filter",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Quicksand',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Container(
                height: 1,
                width: MediaQuery.of(context).size.width - 50,
                color: Colors.grey.shade300,
              )
            ],
          ),
          content: StatefulBuilder(
            builder: ((context, setState) {
              return Container(
                color: Colors.white,
                height: 270,
                width: 600,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 15.0),
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
                      padding: EdgeInsets.only(top: 10.0),
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
                        ),
                        child: TextFormField(
                          textAlign: TextAlign.left,
                          autofocus: false,
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: 'Choose your Category',
                            border: InputBorder.none,
                            fillColor: Color.fromRGBO(244, 243, 243, 1),
                            filled: true,
                            hintStyle: TextStyle(
                              color: Color.fromRGBO(134, 134, 134, 1),
                              fontFamily: 'Quicksand',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 15.0),
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
                      padding: EdgeInsets.only(top: 10.0),
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
                        ),
                        child: TextFormField(
                          textAlign: TextAlign.left,
                          autofocus: false,
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: 'Enter your Location',
                            border: InputBorder.none,
                            fillColor: Color.fromRGBO(244, 243, 243, 1),
                            filled: true,
                            suffixIcon: Icon(
                              Icons.my_location,
                              color: colorLocalPink,
                            ),
                            hintStyle: TextStyle(
                              color: Color.fromRGBO(134, 134, 134, 1),
                              fontFamily: 'Quicksand',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Column(children: <Widget>[
                    //   _buildListSampleItem("    Video", 1, setState),
                    //   _buildListSampleItem("    Image", 2, setState),
                    // ]),
                    // Padding(
                    //   padding: EdgeInsets.only(top: 15.0),
                    //   child: Align(
                    //     alignment: Alignment.centerLeft,
                    //     child: Text(
                    //       "Live",
                    //       style: TextStyle(
                    //         color: Colors.black,
                    //         fontFamily: 'Quicksand',
                    //         fontWeight: FontWeight.bold,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // Container(
                    //   padding: EdgeInsets.only(top: 5),
                    //   width: MediaQuery.of(context).size.width * 0.65,
                    //   height: 80,
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //     crossAxisAlignment: CrossAxisAlignment.center,
                    //     children: <Widget>[
                    //       Container(
                    //         width: MediaQuery.of(context).size.width * 0.28,
                    //         height: 40.0,
                    //         child: ElevatedButton(
                    //           onPressed: () {
                    //             setState(() {
                    //               isFree = false;
                    //             });
                    //           },
                    //           child: Text(
                    //             "Paid",
                    //             style: TextStyle(
                    //               color: Colors.white,
                    //               fontFamily: 'Quicksand',
                    //               fontWeight: FontWeight.bold,
                    //             ),
                    //           ),
                    //           style: ButtonStyle(
                    //               backgroundColor:
                    //                   MaterialStateProperty.all<Color>(isFree
                    //                       ? colorLocalDarkGrey
                    //                       : colorLocalPink),
                    //               shape: MaterialStateProperty.all<
                    //                       RoundedRectangleBorder>(
                    //                   RoundedRectangleBorder(
                    //                 borderRadius: BorderRadius.circular(18.0),
                    //               ))),
                    //         ),
                    //       ),
                    //       Container(
                    //         width: MediaQuery.of(context).size.width * 0.28,
                    //         height: 40.0,
                    //         child: ElevatedButton(
                    //           onPressed: () {
                    //             setState(() {
                    //               isFree = true;
                    //             });
                    //           },
                    //           child: Text(
                    //             "Free",
                    //             style: TextStyle(
                    //               color: Colors.white,
                    //               fontFamily: 'Quicksand',
                    //               fontWeight: FontWeight.bold,
                    //             ),
                    //           ),
                    //           style: ButtonStyle(
                    //               backgroundColor:
                    //                   MaterialStateProperty.all<Color>(!isFree
                    //                       ? colorLocalDarkGrey
                    //                       : colorLocalPink),
                    //               shape: MaterialStateProperty.all<
                    //                       RoundedRectangleBorder>(
                    //                   RoundedRectangleBorder(
                    //                 borderRadius: BorderRadius.circular(18.0),
                    //               ))),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Container(
                        padding: EdgeInsets.only(top: 0),
                        width: MediaQuery.of(context).size.width * 0.35,
                        height: 45,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context, rootNavigator: true).pop();
                          },
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                Color.fromRGBO(252, 37, 117, 1),
                              ),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ))),
                          child: Text(
                            "Apply",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontFamily: 'Quicksand',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          )),
    );
  }

  // ********* show category ***************
  showCategory(BuildContext context) {
    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
          contentPadding: EdgeInsets.all(10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop();
              },
              child: Text(
                "Close",
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Quicksand',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
          title: Text(
            "Categories",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Quicksand',
              fontWeight: FontWeight.bold,
            ),
          ),
          content: StatefulBuilder(
            builder: ((context, setState) {
              return Container(
                width: MediaQuery.of(context).size.width * 1.0,
                child: GridView.count(
                  crossAxisCount: 3,
                  shrinkWrap: true,
                  childAspectRatio: (2.0),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  children: [
                    ...myCategory.map(
                      (i) => Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                selectedCategory = i.last;
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: selectedCategory == i.last
                                    ? colorLocalPink
                                    : Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 3,
                                    blurRadius: 4,
                                    offset: Offset(
                                        0, 1), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: FittedBox(
                                fit: BoxFit.fill,
                                child: Text(
                                  i.last,
                                  maxLines: 2,
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: selectedCategory == i.last
                                        ? Colors.white
                                        : Colors.black,
                                    fontFamily: 'Quicksand',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
          )),
    );
  }

// ********* show Channels ***************
  showChannels(BuildContext context) {
    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        actions: <Widget>[
          ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  Color.fromRGBO(252, 37, 117, 1),
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ))),
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop();
            },
            child: Text(
              "Close",
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Quicksand',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
        title: Text(
          "Channels",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Quicksand',
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Container(
          height: 330,
          width: MediaQuery.of(context).size.width * 0.95,
          child: GridView.count(
            crossAxisCount: 4,
            childAspectRatio: (1 / 1),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            children: [
              ...myCategory.map(
                (i) => Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      child: FittedBox(
                        child: Text(
                          i.last,
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.black,
                            fontFamily: 'Quicksand',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _backImageStream(Map imgObj) {
    return Stack(children: [
      AspectRatio(
        aspectRatio: 0.83,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.network(
            imgObj[kDataWbi][0][kDataWikImages],
            fit: BoxFit.cover,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 3, top: 2),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: InkWell(
                  child: CircleAvatar(
                      radius: 12,
                      backgroundImage: imgObj[kDataUser][kDataUserProfile] !=
                              null
                          ? NetworkImage(
                              imgObj[kDataUser][kDataUserProfile][kDataUserImg])
                          : null),
                ),
              ),
              Container(
                child: Center(
                  child: Text(
                    imgObj[kDataUser][kDataUsername],
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Quicksand',
                        fontWeight: FontWeight.bold,
                        fontSize: 12),
                  ),
                ),
              ),
              // IconButton(
              //   onPressed: () {},
              //   icon: Icon(
              //     Icons.person_add_alt_rounded,
              //     color: colorLocalPink,
              //     size: 15,
              //   ),
              // )
            ]),
      ),
    ]);
  }

  Widget _cardBottom(bool isImage) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 1.0,
        ),
        Text(
          "Lofi Hip Hop - Beats",
          maxLines: 2,
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Quicksand',
            fontWeight: FontWeight.bold,
            fontSize: 11,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 0.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/ic_location.png',
                      height: 10,
                      width: 10,
                    ),
                    Text(
                      " San Francisco",
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Quicksand',
                          fontWeight: FontWeight.bold,
                          fontSize: 13),
                    ),
                  ],
                ),
              ),
              Container(
                height: 18,
                width: 18,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    border: Border.all(color: colorLocalPink, width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Center(
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {},
                    icon: Icon(
                      Icons.person_add_alt_rounded,
                      color: colorLocalPink,
                      size: 12,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(height: 1.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              '400k Views',
              style: TextStyle(
                color: Colors.grey,
                fontFamily: 'Quicksand',
                fontWeight: FontWeight.bold,
                fontSize: 11,
              ),
            ),
            Text(
              '40k Comments',
              style: TextStyle(
                color: Colors.grey,
                fontFamily: 'Quicksand',
                fontWeight: FontWeight.bold,
                fontSize: 11,
              ),
            ),
          ],
        ),
        SizedBox(height: 1.0),
        SizedBox(height: 3.0),
      ],
    );
  }

  Widget mainVideoTile() {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.fromLTRB(0, 16, 0, 19),
      child: GridView.builder(
        itemCount: imagesList.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: Platform.isIOS ? 0.67 : 0.65,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10),
        itemBuilder: (context, index) {
          Map imgObj = imagesList[index];
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ImagePostDetails(
                          imageObject: imgObj,
                        )),
              );
            },
            child: Container(
              height: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                border: Border.all(color: Colors.white),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      blurRadius: 2,
                      offset: Offset(0.0, 4)),
                ],
                color: Color.fromRGBO(251, 251, 251, 1),
              ),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  _backImageStream(imgObj),
                  Container(
                    padding: EdgeInsets.only(left: 4.0, right: 4.0),
                    child: _cardBottom(true),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          Padding(
            padding: EdgeInsets.only(top: 10.0, left: 15.0),
            child: Container(
              padding: EdgeInsets.only(top: 0.0),
              height: 50.0,
              width: 50.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(11),
                  bottomLeft: Radius.circular(11),
                  topRight: Radius.circular(11),
                  bottomRight: Radius.circular(11),
                ),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromRGBO(240, 240, 240, 1),
                    blurRadius: 9.0,
                    spreadRadius: 1.0,
                  ),
                ],
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        showPopUp(context);
                      },
                      child: Image.asset(
                        'assets/images/ic_net.png',
                        height: 20,
                        width: 20,
                      ),
                    ),
                  ]),
            ),
          ),
        ],
        leading: BackButton(
          color: Colors.black,
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: Text(
          'Images',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Quicksand',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(
                top: 15,
              ),
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Categories",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Quicksand',
                        fontWeight: FontWeight.bold,
                        fontSize: 11,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        // showCategory(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SocialCategory(
                                      setCategory: setCategory,
                                    )));
                      },
                      child: Text(
                        "See All",
                        style: TextStyle(
                          color: Color.fromRGBO(145, 145, 145, 1),
                          fontFamily: 'Quicksand',
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 10),
              height: MediaQuery.of(context).size.height * 0.08,
              width: MediaQuery.of(context).size.width,
              child: GridView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: myCategoryArray.length,
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 250,
                    childAspectRatio: 0.75,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 0),
                itemBuilder: (context, index) {
                  return GridTile(
                      child: Container(
                    alignment: Alignment.center,
                    child: Card(
                      color: Color.fromRGBO(251, 251, 251, 1),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              setState(() {
                                selectedCategory = myCategoryArray[index].first;
                              });
                            },
                            child: Container(
                              height: 35,
                              decoration: BoxDecoration(
                                color: selectedCategory ==
                                        myCategoryArray[index].first
                                    ? colorLocalPink
                                    : Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      blurRadius: 2,
                                      offset: Offset(0.0, 2)),
                                ],
                              ),
                              child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    myCategoryArray[index].first,
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: selectedCategory ==
                                              myCategoryArray[index].first
                                          ? Colors.white
                                          : Colors.black,
                                      fontFamily: 'Quicksand',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )),
                            ),
                          )
                        ],
                      ),
                    ),
                  ));
                },
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 15, bottom: 10),
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Channels",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Quicksand',
                        fontWeight: FontWeight.bold,
                        fontSize: 11,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Channels()),
                        );
                      },
                      child: Text(
                        "See All",
                        style: TextStyle(
                          color: Color.fromRGBO(145, 145, 145, 1),
                          fontFamily: 'Quicksand',
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
                height: 48,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: GridView.builder(
                    shrinkWrap: true,
                    itemCount: 9,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      childAspectRatio: 0.36,
                    ),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(
                          right: 10,
                        ),
                        child: GridTile(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 4, bottom: 4),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  channelSelectedIndex = index;
                                });
                              },
                              child: Container(
                                height: 22,
                                width: 130,
                                decoration: BoxDecoration(
                                  color: channelSelectedIndex == index
                                      ? colorLocalPink
                                      : Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  border: Border.all(color: Colors.white),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.withOpacity(0.4),
                                        blurRadius: 1,
                                        spreadRadius: 1,
                                        offset: Offset(2, 4)),
                                  ],
                                ),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        child: InkWell(
                                          child: CircleAvatar(
                                            radius: 20,
                                            backgroundImage: AssetImage(
                                                'assets/images/ic_demoprofile.png'),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: Center(
                                          child: Text(
                                            " Divya Sharma",
                                            style: TextStyle(
                                                color: channelSelectedIndex ==
                                                        index
                                                    ? Colors.white
                                                    : Colors.black,
                                                fontFamily: 'Quicksand',
                                                fontWeight: FontWeight.bold,
                                                fontSize: 10),
                                          ),
                                        ),
                                      ),
                                    ]),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    scrollDirection: Axis.horizontal,
                  ),
                )),
            Expanded(child: mainVideoTile())
          ],
        ),
      ),
    ));
  }
}
