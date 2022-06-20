// ignore_for_file: prefer_const_constructors
import 'package:carousel_slider/carousel_slider.dart';
import 'package:expandable/expandable.dart';

import 'package:flutter/material.dart';
import 'package:wikolo/CommonFiles/common.dart';
import 'package:wikolo/ServerFiles/service_api.dart';
import 'package:wikolo/UI/ChoosePlan.dart';
import 'package:wikolo/UI/Likes.dart';

// List<String> imgList = [
//   'https://www.learningcontainer.com/wp-content/uploads/2020/08/Sample-Small-Image-PNG-file-Download.png',
//   'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
//   'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
//   'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
//   'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
//   'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
// ];
List<String> imgList = [];

class ImagePostDetails extends StatefulWidget {
  final Map imageObject;
  const ImagePostDetails({Key? key, required this.imageObject})
      : super(key: key);

  @override
  State<ImagePostDetails> createState() => _ImagePostDetailsState();
}

class _ImagePostDetailsState extends State<ImagePostDetails> {
  List<String> optionList = ['option1', 'option2', 'option3'];
  int _current = 0;
  var likeStatus = 1; //1 for nothing, 2 for like, 3 for Unlike
  bool isCommented = false;
  bool isFollowed = false;
  final CarouselController _controller = CarouselController();
  ExpandableController commentController = ExpandableController();
  TextEditingController commentTextController = TextEditingController();
  TextEditingController commentThreadTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    List imageList = widget.imageObject[kDataWbi];
    imgList = [];
    for (var i = 0; i < imageList.length; i++) {
      imgList.add(imageList[i][kDataWikfile]);
    }
  }

  List<Widget> imageSliders() {
    return imgList
        .map((item) => Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Container(
                child: Container(
                  margin: EdgeInsets.all(5.0),
                  child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      child: Stack(
                        children: <Widget>[
                          Image.network(item,
                              fit: BoxFit.fitHeight,
                              height: 600,
                              width: 1200.0),
                        ],
                      )),
                ),
              ),
            ))
        .toList();
  }

  Widget setCommentSection() {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 2,
                spreadRadius: 3,
                offset: Offset(2, 2)),
          ],
        ),
        child: ListView.builder(
          padding: EdgeInsets.symmetric(vertical: 10),
          itemCount: 5,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
              child: Container(
                height: index != 4 ? 120 : 60,
                width: MediaQuery.of(context).size.width,
                child: index != 4
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    left: (index % 2 == 0) ? 40 : 0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
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
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            child: Center(
                                              child: Text(
                                                " Divya Sharma",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: 'Quicksand',
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16),
                                              ),
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: const [
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(left: 5),
                                                child: Text(
                                                  '8 Nov',
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    color: colorLocalGrey,
                                                    fontFamily: 'Quicksand',
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                '1 min ago',
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  color: colorLocalGrey,
                                                  fontFamily: 'Quicksand',
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Visibility(
                                visible: (index % 2 != 0),
                                child: TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    'Reply',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: colorLocalGrey,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Quicksand',
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          Text(
                            'When one door of happiness closes, another opens, but often we look so long at the closed door that we do not see the one that has been opened for us.@Divya',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Quicksand',
                            ),
                          ),
                        ],
                      )
                    : Padding(
                        padding:
                            EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
                        child: Container(
                          padding: EdgeInsets.only(top: 0.0),
                          height: 50.0,
                          width: MediaQuery.of(context).size.width * 0.85,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25)),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  blurRadius: 9.0,
                                  spreadRadius: 1.0,
                                ),
                              ]),
                          child: TextFormField(
                            controller: commentThreadTextController,
                            textCapitalization: TextCapitalization.words,
                            autofocus: false,
                            textAlign: TextAlign.left,
                            decoration: InputDecoration(
                              hintText: 'Reply to this comment',
                              suffixIcon: IconButton(
                                  padding: EdgeInsets.all(0),
                                  onPressed: () {
                                    ShowLoader(context);
                                    postReplyComment(
                                        commentThreadTextController.text, 2);
                                  },
                                  icon: Icon(
                                    Icons.send,
                                    color: colorLocalPink,
                                    size: 25,
                                  )),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  borderSide: BorderSide(color: Colors.white)),
                              disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  borderSide: BorderSide(color: Colors.white)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  borderSide:
                                      BorderSide(color: colorLocalPink)),
                              fillColor: Colors.white,
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
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          title: Text(
            'Images',
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Quicksand',
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(Icons.share, color: Colors.black, size: 25)),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
              child: Container(
                width: 30,
                child: PopupMenuButton<String>(
                  icon: const Icon(
                    Icons.more_vert,
                    color: Colors.black,
                    size: 30,
                  ),
                  onSelected: (value) {},
                  itemBuilder: (BuildContext context) {
                    return optionList.map((String choice) {
                      return PopupMenuItem<String>(
                        value: choice,
                        child: Text(
                          choice,
                          style: const TextStyle(
                              fontSize: 16, color: colorLocalGrey),
                        ),
                      );
                    }).toList();
                  },
                ),
              ),
            )
          ],
          leading: BackButton(
            color: Colors.black,
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
              child: Container(
                height: 60,
                width: MediaQuery.of(context).size.width,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Container(
                              child: InkWell(
                                child: CircleAvatar(
                                    radius: 20,
                                    backgroundImage:
                                        widget.imageObject[kDataUser]
                                                    [kDataUserProfile] !=
                                                null
                                            ? NetworkImage(
                                                widget.imageObject[kDataUser]
                                                        [kDataUserProfile]
                                                    [kDataUserImg])
                                            : null),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 12, bottom: 5, left: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Text(
                                    widget.imageObject[kDataUser]
                                        [kDataUsername],
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Quicksand',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                ),
                                Text(
                                  '10k Subscribers',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: colorLocalGrey,
                                    fontFamily: 'Quicksand',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          ShowLoader(context);
                          followUnfollowUser(1, context);
                        },
                        child: Text(
                          isFollowed ? 'Following' : 'Follow',
                          style: TextStyle(
                              fontSize: 14,
                              color:
                                  isFollowed ? colorLocalGrey : colorLocalPink,
                              fontFamily: 'Quicksand',
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Image.asset('assets/images/ic_chat.png'),
                        iconSize: 20,
                      )
                    ]),
              ),
            ),
            Stack(
              children: [
                Container(
                  child: CarouselSlider(
                    items: imageSliders(),
                    carouselController: _controller,
                    options: CarouselOptions(
                        autoPlay: true,
                        enlargeCenterPage: true,
                        aspectRatio: 0.8,
                        viewportFraction: 0.8,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _current = index;
                          });
                        }),
                  ),
                ),
                Align(
                    alignment: Alignment(-0.7, 1.75),
                    heightFactor: 7,
                    child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.bookmark,
                          color: Colors.white,
                          size: 25,
                        ))),
                Align(
                  alignment: Alignment.bottomCenter,
                  heightFactor: 18,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: imgList.asMap().entries.map((entry) {
                      return GestureDetector(
                        onTap: () => _controller.animateToPage(entry.key),
                        child: Container(
                          width: 8.0,
                          height: 8.0,
                          margin: EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 4.0),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: (Colors.white).withOpacity(
                                  _current == entry.key ? 1 : 0.4)),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 10, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/images/ic_location.png',
                    height: 20,
                    width: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Text(
                      widget.imageObject[kDataLocation],
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Quicksand',
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                      onTap: () {
                        setState(() {
                          likeStatus = likeStatus != 2 ? 2 : 1;
                        });
                      },
                      child: Icon(
                        Icons.thumb_up_alt_rounded,
                        size: 25,
                        color:
                            likeStatus == 2 ? colorLocalPink : colorLocalGrey,
                      )),
                  Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Likes()),
                        );
                      },
                      child: Text(
                        '400k likes',
                        style: TextStyle(
                          color: Colors.grey,
                          fontFamily: 'Quicksand',
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 25,
                  ),
                  InkWell(
                      onTap: () {
                        setState(() {
                          isCommented = !isCommented;
                        });
                      },
                      child: Icon(
                        Icons.comment,
                        size: 25,
                        color: isCommented == true
                            ? colorLocalPink
                            : colorLocalGrey,
                      )),
                  Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: Text(
                      '40k',
                      style: TextStyle(
                        color: Colors.grey,
                        fontFamily: 'Quicksand',
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 40,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  ExpandablePanel(
                    header: Container(
                      margin: EdgeInsets.only(top: 13),
                      child: Text(
                        'Description',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontFamily: 'Quicksand',
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    collapsed: Text(
                      widget.imageObject[kDataDescription],
                      softWrap: true,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    expanded: Text(
                      widget.imageObject[kDataDescription],
                      softWrap: true,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 20.0,
                    ),
                    child: Container(
                      height: 50.0,
                      width: MediaQuery.of(context).size.width * 0.90,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              blurRadius: 9.0,
                              spreadRadius: 1.0,
                            ),
                          ]),
                      child: TextFormField(
                        textCapitalization: TextCapitalization.words,
                        autofocus: false,
                        controller: commentTextController,
                        textAlign: TextAlign.left,
                        decoration: InputDecoration(
                          hintText: 'Leave a Comment',
                          suffixIcon: IconButton(
                              padding: EdgeInsets.all(0),
                              onPressed: () {
                                ShowLoader(context);
                                postComment(commentTextController.text);
                              },
                              icon: Icon(
                                Icons.send,
                                color: colorLocalPink,
                                size: 25,
                              )),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide: BorderSide(color: Colors.white)),
                          disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide: BorderSide(color: Colors.white)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide: BorderSide(color: colorLocalPink)),
                          fillColor: Colors.white,
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
                    padding: const EdgeInsets.only(top: 10),
                    child: ExpandablePanel(
                        controller: commentController,
                        header: Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.only(
                            right: 170.0,
                          ),
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(colorLocalGrey),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ))),
                              child: Text(
                                'Comments',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontFamily: 'Quicksand',
                                    fontWeight: FontWeight.bold),
                              ),
                              onPressed: () {
                                commentController.toggle();
                              }),
                        ),
                        collapsed: setCommentSection(),
                        expanded: ListView.builder(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            itemCount: 4,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return setCommentSection();
                            })),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }

  followUnfollowUser(int status, context) async {
    final url = "$baseUrl/afw/";
    Map param = Map();
    param['following'] = status.toString();
    var result = await CallApi("POST", param, url, context);
    HideLoader(context);
    if (result[kDataCode] == "200") {
      setState(() {
        isFollowed = true;
      });
    } else {
      ShowErrorMessage(result[kDataMessages], context);
    }
  }

  postComment(comment) async {
    final url = "$baseUrl/cwbic/";
    Map param = Map();
    param['imageid'] = widget.imageObject[kDataID].toString();
    param["comment"] = comment;
    var result = await CallApi("POST", param, url, context);
    HideLoader(context);
    if (result[kDataCode] == "200") {
      print(result);
    } else {
      ShowErrorMessage(result[kDataMessage], context);
    }
  }

  postReplyComment(comment, commentId) async {
    final url = "$baseUrl/crwbic/";
    Map param = Map();
    param['commentid'] = widget.imageObject[kDataID].toString();
    param["comment"] = comment;
    param["ireplyto"] = widget.imageObject[kDataUser][kDataID].toString();
    var result = await CallApi("POST", param, url, context);
    HideLoader(context);
    if (result[kDataCode] == "200") {
      print(result);
    } else {
      ShowErrorMessage(result[kDataMessage], context);
    }
  }
}
