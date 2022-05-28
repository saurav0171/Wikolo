// ignore_for_file: prefer_const_constructors
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:wikolo/CommonFiles/common.dart';
import 'package:wikolo/UI/ChoosePlan.dart';
import 'package:wikolo/UI/Golive.dart';
import 'package:wikolo/UI/ImageDetails.dart';
import 'package:wikolo/UI/ImagePostDetails.dart';
import 'package:wikolo/UI/ImagesProfileDetails.dart';
import 'package:wikolo/UI/JoinMeeting.dart';
import 'package:wikolo/UI/LiveStreamingDetails.dart';
import 'package:wikolo/UI/Sample.dart';
import 'package:wikolo/UI/SocialCategory.dart';
import 'package:wikolo/UI/Uploadpost.dart';
import 'package:wikolo/UI/VideoDetails.dart';
import 'package:wikolo/UI/VideoPlayerScreen.dart';
import 'package:wikolo/UI/addGurudwara.dart';
import 'package:wikolo/UI/join_channel_video.dart';

class SocialBoard extends StatefulWidget {
  const SocialBoard({Key? key}) : super(key: key);

  @override
  State<SocialBoard> createState() => _SocialBoardState();
}

class _SocialBoardState extends State<SocialBoard> {
  var top = 0.0;
  bool isRecentSort = true;
  bool isVideoSelected = true;
  bool isFree = false;
  bool isVideoViewShown = false;
  var selectedCategory = 'All';

  int radioButtonIndex =
      0; // 0 for NOVALUE, 1 for RECENT, 2 for Latest, 3 for VIDEO, 4 for IMAGES
  final myCategory = [
    ["assets/images/ic_all.png", "All"],
    ["assets/images/ic_book.png", "Books"],
    ["assets/images/ic_electronic.png", "Electronics"],
    ["assets/images/ic_game.png", "Games"],
    ["assets/images/ic_business.png", "Business & Industry"],
    ["assets/images/ic_pet.png", "Pets & Animals"],
    ["assets/images/ic_service.png", "Music"],
    ["assets/images/ic_health.png", "Health"],
    ["assets/images/ic_fashion.png", "Fashion"],
    ["assets/images/ic_job.png", "Jobs"],
    ["assets/images/ic_food.png", "Food"],
    ["assets/images/ic_kitchen.png", "Kitchen  Appliances"],
    ["assets/images/ic_matrimonial.png", "Matrimonial"],
    ["assets/images/ic_beauty.png", "Beauty"],
    ["assets/images/ic_car.png", "Cars & Vehicles"],
  ];

  final myImageAndCaption = [
    ["assets/images/ic_all.png", "All"],
    ["assets/images/ic_book.png", "Books"],
    ["assets/images/ic_electronic.png", "Electronics"],
    ["assets/images/ic_game.png", "Games"],
    ["assets/images/ic_fashion.png", "Fashion"],
  ];

  final myTextArray = [
    ["All"],
    ["Books"],
    ["Electronics"],
    ["Games"],
    ["Fashion"],
    ["Jobs"],
    ["Music"],
    ["Food"],
    ["Car"],
  ];

  setCategory(String category) {
    setState(() {
      selectedCategory = category;
    });
  }

  setVideoStatus(status) {
    setState(() {
      isVideoViewShown = status;
    });
  }

  //********************** //
  Container _buildStoryListView(context) {
    return Container(
      height: 230,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemExtent: 90,
        itemBuilder: (context, index) {
          return Container(
            width: 30,
            height: 30,
            color: Colors.green,
            alignment: Alignment.center,
            //   child:  Card(
            //   color: Color.fromRGBO(251, 251, 251, 1),
            //   elevation: 1.0,
            //   shape: RoundedRectangleBorder(
            //     borderRadius: BorderRadius.circular(10.0),
            //   ),
            //
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.start,
            //     children: <Widget>[
            //       _backImage(),
            //       Container(
            //         padding: EdgeInsets.only(left: 4.0, right: 4.0),
            //         child: _cardBottom(),
            //
            //       ),
            //     ],
            //   ),
            // ),
          );
        },
      ),
    );
  }

  Widget _backImage() {
    return AspectRatio(
      aspectRatio: 1.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Image.asset(
          'assets/images/ic_stream.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _backImageVideo() {
    return AspectRatio(
      aspectRatio: 1.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Image.asset(
          'assets/images/ic_videostream.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _backImageStream() {
    return Stack(children: [
      AspectRatio(
        aspectRatio: 0.83,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.asset(
            'assets/images/ic_imagestream.png',
            fit: BoxFit.cover,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 3, top: 2),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ImageProfileDetails()),
            );
          },
          child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  child: InkWell(
                    child: CircleAvatar(
                      radius: 12,
                      backgroundImage:
                          AssetImage('assets/images/ic_demoprofile.png'),
                    ),
                  ),
                ),
                Container(
                  child: Center(
                    child: Text(
                      " Divya Sharma",
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
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Quicksand',
            fontWeight: FontWeight.bold,
            fontSize: 11,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 0.0),
          child: Container(
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
        ),
        SizedBox(height: 1.0),
        Text(
          '400k Views',
          style: TextStyle(
            color: Colors.grey,
            fontFamily: 'Quicksand',
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
        SizedBox(height: 1.0),
        Divider(height: 1),
        SizedBox(height: 4.0),
        Visibility(
          visible: !isImage,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  child: InkWell(
                    child: CircleAvatar(
                      radius: 12,
                      backgroundImage:
                          AssetImage('assets/images/ic_demoprofile.png'),
                    ),
                  ),
                ),
                Container(
                  child: Center(
                    child: Text(
                      " Divya Sharma",
                      style: TextStyle(
                          color: Colors.black,
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
      ],
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
                Navigator.of(context).pop();
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

  Widget _buildListSampleItem(
      String title, int radioStatus, StateSetter setState) {
    var image = '';
    setState(() {
      if (radioStatus == 1) {
        image = isRecentSort
            ? 'assets/images/ic_tick.png'
            : 'assets/images/ic_circle.png';
      } else if (radioStatus == 2) {
        image = !isRecentSort
            ? 'assets/images/ic_tick.png'
            : 'assets/images/ic_circle.png';
      } else if (radioStatus == 3) {
        image = isVideoSelected
            ? 'assets/images/ic_tick.png'
            : 'assets/images/ic_circle.png';
      } else if (radioStatus == 4) {
        image = !isVideoSelected
            ? 'assets/images/ic_tick.png'
            : 'assets/images/ic_circle.png';
      }
    });
    return InkWell(
      onTap: () {
        setState(() {
          if (radioStatus == 1) {
            isRecentSort = true;
          } else if (radioStatus == 2) {
            isRecentSort = false;
          } else if (radioStatus == 3) {
            isVideoSelected = true;
          } else if (radioStatus == 4) {
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

  showPopUpFilter(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0))),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/ic_filter.png',
              height: 15,
              width: 15,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              "Sort",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Quicksand',
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return Container(
              color: Colors.white,
              height: 180,
              child: Column(
                children: <Widget>[
                  _buildListSampleItem("    Recent", 1, setState),
                  _buildListSampleItem("    Latest", 2, setState),
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Container(
                      padding: EdgeInsets.only(top: 0),
                      width: MediaQuery.of(context).size.width * 0.35,
                      height: 45,
                      child: RaisedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(26.0)),
                        child: Text(
                          "Apply",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontFamily: 'Quicksand',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        color: Color.fromRGBO(252, 37, 117, 1),
                      ),
                    ),
                  ),
                ],
              ));
        }),
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
              Container(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: Icon(
                          Icons.arrow_back_ios_new,
                          size: 20,
                        )),
                    Text(
                      "Looking for",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Quicksand',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 1,
                width: MediaQuery.of(context).size.width - 50,
                color: Colors.grey.shade300,
              )
            ],
          ),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                color: Colors.white,
                height: 500,
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
                      padding: EdgeInsets.only(top: 10.0, bottom: 10),
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
                    Column(children: <Widget>[
                      _buildListSampleItem("    Video", 3, setState),
                      _buildListSampleItem("    Image", 4, setState),
                    ]),
                    Padding(
                      padding: EdgeInsets.only(top: 15.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Live",
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
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(isFree
                                          ? colorLocalDarkGrey
                                          : colorLocalPink),
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
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(!isFree
                                          ? colorLocalDarkGrey
                                          : colorLocalPink),
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
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Container(
                        padding: EdgeInsets.only(top: 0),
                        width: MediaQuery.of(context).size.width * 0.35,
                        height: 45,
                        child: RaisedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(26.0)),
                          child: Text(
                            "Apply",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontFamily: 'Quicksand',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          color: Color.fromRGBO(252, 37, 117, 1),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    double tileWidth = Platform.isIOS ? 70 : 65;
    return MaterialApp(
      home: Scaffold(
          backgroundColor: Colors.white,
          floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UploadPost()),
                );
              },
              backgroundColor: colorLocalPink.withOpacity(0.5),
              child: Icon(Icons.add)),
          body: Stack(
            children: [
              NestedScrollView(
                headerSliverBuilder:
                    (BuildContext buildcontext, bool innerBoxIsScrolled) {
                  return <Widget>[
                    SliverAppBar(
                      backgroundColor: Colors.white,
                      expandedHeight: 300.0,
                      floating: false,
                      pinned: true,
                      flexibleSpace: LayoutBuilder(builder:
                          (BuildContext flexcontext,
                              BoxConstraints constraints) {
                        // print('constraints=' + constraints.toString());
                        WidgetsBinding.instance?.addPostFrameCallback((_) {
                          // Add Your Code here.
                          setState(() {
                            top = constraints.biggest.height;
                          });
                        });

                        // print('Top is : $top');
                        return FlexibleSpaceBar(
                          centerTitle: true,
                          background: Container(
                            padding: EdgeInsets.only(top: 50.0),
                            height: 330,
                            width: MediaQuery.of(context).size.width,
                            color: Color.fromRGBO(223, 233, 208, 1),
                            child: Column(
                              children: [
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding:
                                            EdgeInsets.only(top: 5.0, left: 15),
                                        child: InkWell(
                                          onTap: () {
                                            // Navigator.push(
                                            //   context,
                                            //   MaterialPageRoute(
                                            //       builder: (context) => Profile()),
                                            // );
                                          },
                                          child: CircleAvatar(
                                            radius: 20,
                                            backgroundImage: AssetImage(
                                                'assets/images/ic_demoprofile.png'),
                                            backgroundColor: Colors.yellow,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(left: 15),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.65,
                                        height: 60,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,

                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  top: 5.0, bottom: 5.0),
                                              child: FittedBox(
                                                fit: BoxFit.fitWidth,
                                                child: Text(
                                                  "Divya Sharma",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontFamily: 'Quicksand',
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(top: 0.0),
                                              child: Container(
                                                child: Row(
                                                  children: [
                                                    Image.asset(
                                                      'assets/images/ic_location.png',
                                                      height: 15,
                                                      width: 15,
                                                    ),
                                                    Text(
                                                      " San Francisco",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontFamily:
                                                              'Quicksand',
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 13),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                          // 1,2,3,4
                                        ),
                                      ),
                                      Container(
                                        height: 30,
                                        width: 30,
                                        child: IconButton(
                                            onPressed: () {},
                                            icon: Icon(Icons.map_outlined)),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 7, top: 7),
                                        child: Container(
                                          padding: EdgeInsets.only(right: 5.0),
                                          height: 25,
                                          width: 25,
                                          child: Image.asset(
                                            'assets/images/ic_notify.png',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ]),
                                Container(
                                    padding:
                                        EdgeInsets.only(left: 15.0, top: 5),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Looking for Something ?",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'Quicksand',
                                            fontWeight: FontWeight.bold,
                                            fontSize: 26),
                                      ),
                                    )),
                                Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: 10.0, left: 15.0),
                                      child: Container(
                                        padding: EdgeInsets.only(top: 0.0),
                                        height: 50.0,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.75,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              bottomLeft: Radius.circular(10),
                                              topRight: Radius.circular(10),
                                              bottomRight: Radius.circular(10),
                                            ),
                                            color: Colors.white,
                                            boxShadow: const [
                                              BoxShadow(
                                                color: Color.fromRGBO(
                                                    240, 240, 240, 1),
                                                blurRadius: 9.0,
                                                spreadRadius: 1.0,
                                              ),
                                            ]),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "    Search Anything",
                                            style: TextStyle(
                                              color: Color.fromRGBO(
                                                  145, 145, 145, 1),
                                              fontFamily: 'Quicksand',
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: 10.0, left: 15.0),
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
                                              color: Color.fromRGBO(
                                                  240, 240, 240, 1),
                                              blurRadius: 9.0,
                                              spreadRadius: 1.0,
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
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
                                ),
                                Container(
                                  padding: EdgeInsets.only(top: 15.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: 5.0, left: 15.0),
                                        child: Container(
                                          padding: EdgeInsets.only(top: 0.0),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.28,
                                          height: 85,
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
                                                color: Colors.grey,
                                                blurRadius: 9.0,
                                                spreadRadius: 1.0,
                                                offset: Offset(0, 7),
                                              ),
                                            ],
                                          ),
                                          child: AspectRatio(
                                            aspectRatio: 1,
                                            child: Container(
                                              height: double.infinity,
                                              child: Column(
                                                children: [
                                                  Align(
                                                    alignment: Alignment.center,
                                                    child: Image.asset(
                                                      'assets/images/social.png',
                                                      height: 60,
                                                      width: 60,
                                                    ),
                                                  ),
                                                  Text(
                                                    "Wikolo Board",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontFamily: 'Quicksand',
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 13,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: 5.0),
                                        child: InkWell(
                                          onTap: () {
                                            print("fff");
                                            // Navigator.push(
                                            //   context,
                                            //   MaterialPageRoute(
                                            //       builder: (context) => LandPage()),
                                            // );
                                          },
                                          child: Container(
                                            padding: EdgeInsets.only(top: 0.0),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.28,
                                            height: 85,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(11),
                                                bottomLeft: Radius.circular(11),
                                                topRight: Radius.circular(11),
                                                bottomRight:
                                                    Radius.circular(11),
                                              ),
                                              color: Colors.white,
                                              boxShadow: const [
                                                BoxShadow(
                                                  color: Colors.grey,
                                                  blurRadius: 9.0,
                                                  spreadRadius: 1.0,
                                                  offset: Offset(0, 7),
                                                ),
                                              ],
                                            ),
                                            child: AspectRatio(
                                              aspectRatio: 1,
                                              child: Container(
                                                height: double.infinity,
                                                child: Align(
                                                  alignment: Alignment.center,
                                                  child: Column(
                                                    children: [
                                                      Image.asset(
                                                        'assets/images/roomie1.png',
                                                        height: 60,
                                                        width: 60,
                                                      ),
                                                      Text(
                                                        "Roomie",
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontFamily:
                                                              'Quicksand',
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 13,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: 5.0, right: 15.0),
                                        child: Container(
                                          padding: EdgeInsets.only(top: 0.0),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.28,
                                          height: 85,
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
                                                color: Colors.grey,
                                                blurRadius: 9.0,
                                                spreadRadius: 1.0,
                                                offset: Offset(0, 7),
                                              ),
                                            ],
                                          ),
                                          child: AspectRatio(
                                            aspectRatio: 1,
                                            child: Container(
                                              height: double.infinity,
                                              child: Align(
                                                alignment: Alignment.center,
                                                child: Column(
                                                  children: [
                                                    Image.asset(
                                                      'assets/images/market1.png',
                                                      height: 60,
                                                      width: 60,
                                                    ),
                                                    Text(
                                                      "Market Place",
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontFamily: 'Quicksand',
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 13,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                      bottom: PreferredSize(
                        preferredSize: const Size.fromHeight(20),
                        child: AnimatedOpacity(
                          duration: Duration(milliseconds: 200),
                          opacity: top < 150 ? 1 : 0,
                          child: Container(
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(right: 5.0),
                                    child: Container(
                                      padding: EdgeInsets.only(top: 0.0),
                                      width: tileWidth,
                                      height: 60,
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 40,
                                            width: 40,
                                            padding: EdgeInsets.only(
                                                top: 5, right: 5),
                                            child: InkWell(
                                              onTap: () {
                                                // Navigator.push(
                                                //   context,
                                                //   MaterialPageRoute(
                                                //       builder: (context) => Profile()),
                                                // );
                                              },
                                              child: CircleAvatar(
                                                radius: 20,
                                                backgroundImage: AssetImage(
                                                    'assets/images/ic_demoprofile.png'),
                                                backgroundColor: Colors.yellow,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 5.0),
                                            child: Text(
                                              "Profile",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontFamily: 'Quicksand',
                                                fontWeight: FontWeight.w600,
                                                fontSize: 10,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: 5.0),
                                    child: Container(
                                      padding: EdgeInsets.only(top: 0.0),
                                      width: tileWidth,
                                      height: 60,
                                      child: Column(
                                        children: [
                                          Image.asset(
                                            'assets/images/social.png',
                                            height: 45,
                                            width: 45,
                                          ),
                                          Text(
                                            "Social Board",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: 'Quicksand',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 10,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: 5.0),
                                    child: Container(
                                      padding: EdgeInsets.only(top: 0.0),
                                      width: tileWidth,
                                      height: 60,
                                      child: Column(
                                        children: [
                                          Image.asset(
                                            'assets/images/roomie1.png',
                                            height: 45,
                                            width: 45,
                                          ),
                                          Text(
                                            "Roomie",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: 'Quicksand',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 10,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: 5.0),
                                    child: Container(
                                      padding: EdgeInsets.only(top: 0.0),
                                      width: tileWidth,
                                      height: 60,
                                      child: Column(
                                        children: [
                                          Image.asset(
                                            'assets/images/market1.png',
                                            height: 45,
                                            width: 45,
                                          ),
                                          Text(
                                            "Market Place",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: 'Quicksand',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 10,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: 0.0),
                                    child: Container(
                                      padding: EdgeInsets.only(top: 0.0),
                                      width: tileWidth,
                                      height: 60,
                                      child: Column(
                                        children: const [
                                          Icon(
                                            Icons.search,
                                            size: 45,
                                          ),
                                          Text(
                                            "Search",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: 'Quicksand',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 10,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ];
                },
                body: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Scrollbar(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            padding:
                                EdgeInsets.only(left: 20, top: 10, right: 20),
                            width: MediaQuery.of(context).size.width,
                            child: Stack(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    height: 35,
                                    width: 90,
                                    decoration: BoxDecoration(
                                      color: Color.fromRGBO(246, 55, 60, 1),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(7)),
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        // Navigator.of(context).push(
                                        //     PageRouteBuilder(
                                        //         opaque: false,
                                        //         pageBuilder:
                                        //             (BuildContext context, _,
                                        //                     __) =>
                                        //                 GoLive(
                                        //                   isGoLive: true,
                                        //                 )));

                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  MyHomePage()),
                                        );
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            'assets/images/ic_live.png',
                                            height: 25,
                                            width: 25,
                                          ),
                                          Text(
                                            'Go Live',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'Quicksand',
                                                fontWeight: FontWeight.bold,
                                                fontSize: 10),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Container(
                                    padding: EdgeInsets.only(left: 5),
                                    width:
                                        MediaQuery.of(context).size.width * 0.1,
                                    child: AspectRatio(
                                      aspectRatio: 1,
                                      child: Container(
                                        height: double.infinity,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            bottomLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                            bottomRight: Radius.circular(10),
                                          ),
                                          color:
                                              Color.fromRGBO(242, 242, 242, 1),
                                        ),
                                        child: InkWell(
                                          onTap: () {
                                            WidgetsBinding.instance!
                                                .addPostFrameCallback((_) {
                                              // Add Your Code here.
                                              showPopUpFilter(context);
                                            });
                                            SchedulerBinding.instance!
                                                .addPostFrameCallback(
                                                    (timeStamp) {});
                                          },
                                          child: Image.asset(
                                            'assets/images/ic_filter.png',
                                            height: 15,
                                            width: 15,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Container(
                            padding:
                                EdgeInsets.only(left: 20, top: 15, right: 20),
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
                                            builder: (context) =>
                                                SocialCategory(
                                                  setCategory: setCategory,
                                                )),
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
                            padding:
                                EdgeInsets.only(top: 10, right: 16, left: 16),
                            height: MediaQuery.of(context).size.height * 0.08,
                            width: MediaQuery.of(context).size.width,
                            child: GridView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: myTextArray.length,
                              gridDelegate:
                                  SliverGridDelegateWithMaxCrossAxisExtent(
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              selectedCategory =
                                                  myTextArray[index].first;
                                            });
                                          },
                                          child: Container(
                                            height: 35,
                                            decoration: BoxDecoration(
                                              color: selectedCategory ==
                                                      myTextArray[index].first
                                                  ? colorLocalPink
                                                  : Colors.white,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.5),
                                                    blurRadius: 2,
                                                    offset: Offset(0.0, 2)),
                                              ],
                                            ),
                                            child: Align(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  myTextArray[index].first,
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    color: selectedCategory ==
                                                            myTextArray[index]
                                                                .first
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

                          //******* start divider with one space **********************
                          Container(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            height: 27,
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(left: 10),
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  child: Text(
                                    "Live Streaming",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.black,
                                      fontFamily: 'Quicksand',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              LiveStreamingDetails()),
                                    );
                                  },
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      "See All",
                                      style: TextStyle(
                                          color:
                                              Color.fromRGBO(145, 145, 145, 1),
                                          fontFamily: 'Quicksand',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 11),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),

                          //******* Live Streaming **********
                          Container(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            width: MediaQuery.of(context).size.width,
                            height: 170,
                            child: GridView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 9,
                              gridDelegate:
                                  SliverGridDelegateWithMaxCrossAxisExtent(
                                      maxCrossAxisExtent: 285,
                                      childAspectRatio: 3 / 2.4,
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 0),
                              itemBuilder: (context, index) {
                                return GridTile(
                                    child: Container(
                                  alignment: Alignment.center,
                                  child: Card(
                                    color: Color.fromRGBO(251, 251, 251, 1),
                                    elevation: 1.0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        _backImage(),
                                        Container(
                                          padding: EdgeInsets.only(
                                              left: 4.0, right: 4.0),
                                          child: _cardBottom(false),
                                        ),
                                      ],
                                    ),
                                  ),
                                ));
                              },
                            ),
                          ),

                          Container(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            height: 27,
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(left: 10),
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  child: Text(
                                    "Videos",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.black,
                                      fontFamily: 'Quicksand',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => VideoDetails()),
                                    );
                                  },
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      "See All",
                                      style: TextStyle(
                                          color:
                                              Color.fromRGBO(145, 145, 145, 1),
                                          fontFamily: 'Quicksand',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 11),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),

                          //***** video streaming ******
                          Container(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            height: 170,
                            child: GridView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 9,
                              gridDelegate:
                                  SliverGridDelegateWithMaxCrossAxisExtent(
                                      maxCrossAxisExtent: 250,
                                      childAspectRatio: 3 / 2.4,
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 0),
                              itemBuilder: (context, index) {
                                return InkWell(
                                  child: GridTile(
                                      child: Container(
                                    alignment: Alignment.center,
                                    child: Card(
                                      color: Color.fromRGBO(251, 251, 251, 1),
                                      elevation: 1.0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          _backImageVideo(),
                                          Container(
                                            padding: EdgeInsets.only(
                                                left: 4.0, right: 4.0),
                                            child: _cardBottom(false),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )),
                                  onTap: () {
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //       builder: (context) =>
                                    //           UsingVideoControllerExample()),
                                    // );
                                    setState(() {
                                      isVideoViewShown = true;
                                    });
                                  },
                                );
                              },
                            ),
                          ),

                          Container(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            height: 27,
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(left: 10),
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  child: Text(
                                    "Images",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.black,
                                      fontFamily: 'Quicksand',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ImageDetails()),
                                    );
                                  },
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      "See All",
                                      style: TextStyle(
                                          color:
                                              Color.fromRGBO(145, 145, 145, 1),
                                          fontFamily: 'Quicksand',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 11),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),

                          //******* Images **********
                          Container(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            height: 230,
                            child: GridView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 9,
                              gridDelegate:
                                  SliverGridDelegateWithMaxCrossAxisExtent(
                                      maxCrossAxisExtent: 250,
                                      childAspectRatio: 1.6,
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 0),
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ImagePostDetails(
                                                  imageObject: {})),
                                    );
                                  },
                                  child: GridTile(
                                      child: Container(
                                    alignment: Alignment.center,
                                    child: Card(
                                      color: Color.fromRGBO(251, 251, 251, 1),
                                      elevation: 1.0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          _backImageStream(),
                                          Container(
                                            padding: EdgeInsets.only(
                                                left: 4.0, right: 4.0),
                                            child: _cardBottom(true),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Visibility(
                  visible: isVideoViewShown,
                  child: UsingVideoControllerExample(
                    videoStatus: setVideoStatus,
                  ))
            ],
          )),
    );
  }
}
