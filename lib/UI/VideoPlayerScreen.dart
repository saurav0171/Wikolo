// ignore_for_file: prefer_const_constructors
import 'dart:ffi';
import 'dart:io';

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:better_player/better_player.dart';
import 'package:flutter/services.dart';
import 'package:wikolo/CommonFiles/common.dart';
import 'package:wikolo/ServerFiles/service_api.dart';

import '../Globals/globals.dart';

class UsingVideoControllerExample extends StatefulWidget {
  Function videoStatus;
  Map videoObj;
  UsingVideoControllerExample(
      {Key? key, required this.videoStatus, required this.videoObj})
      : super(key: key);

  @override
  _UsingVideoControllerExampleState createState() =>
      _UsingVideoControllerExampleState();
}

class _UsingVideoControllerExampleState
    extends State<UsingVideoControllerExample> with TickerProviderStateMixin {
// Floating Video View Animation
  TextEditingController commentTextController = TextEditingController();
  TextEditingController commentThreadTextController = TextEditingController();
  List commentsList = [];
  List controllerList = [];
  late AnimationController alignmentAnimationController;
  late Animation alignmentAnimation;

  late AnimationController videoViewController;
  late Animation videoViewAnimation;

  var currentAlignment = Alignment.topCenter;
  bool isFollowed = false;
  var minVideoHeight = 200.0;
  var minVideoWidth = 240.0;

  var maxVideoHeight = 300.0;

  // This is an arbitrary value and will be changed when layout is built.
  var maxVideoWidth = 300.0;

  var currentVideoHeight = 300.0;
  var currentVideoWidth = 240.0;

  bool isInSmallMode = false;

  var videoIndexSelected = -1;

  late BetterPlayerDataSource _betterPlayerDataSource;
  var likeStatus = 1; //1 for nothing, 2 for like, 3 for Unlike
  bool isCommented = false;
  ExpandableController commentController = ExpandableController();

  final myCategoryArray = [
    ["All"],
    ["Books"],
    ["Electronics"],
    ["Games"],
  ];

  @override
  void initState() {
    alignmentAnimationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1))
          ..addListener(() {
            setState(() {
              currentAlignment = alignmentAnimation.value;
            });
          });
    alignmentAnimation =
        AlignmentTween(begin: Alignment.topCenter, end: Alignment.bottomRight)
            .animate(CurvedAnimation(
                parent: alignmentAnimationController,
                curve: Curves.fastOutSlowIn));

    videoViewController =
        AnimationController(vsync: this, duration: Duration(seconds: 1))
          ..addListener(() {
            setState(() {
              currentVideoWidth = (maxVideoWidth * videoViewAnimation.value) +
                  (minVideoWidth * (1.0 - videoViewAnimation.value));
              currentVideoHeight = (maxVideoHeight * videoViewAnimation.value) +
                  (minVideoHeight * (1.0 - videoViewAnimation.value));
            });
          });
    videoViewAnimation =
        Tween<double>(begin: 1.0, end: 0.0).animate(videoViewController);

    BetterPlayerConfiguration betterPlayerConfiguration =
        const BetterPlayerConfiguration(
      aspectRatio: 1.0,
      controlsConfiguration: BetterPlayerControlsConfiguration(
          backgroundColor: Colors.transparent,
          progressBarPlayedColor: colorLocalPink,
          progressBarHandleColor: colorLocalPink,
          loadingColor: colorLocalPink),
      fit: BoxFit.fill,
      autoPlay: true,
      looping: true,
      deviceOrientationsAfterFullScreen: [
        DeviceOrientation.portraitDown,
        DeviceOrientation.portraitUp
      ],
    );
    // _betterPlayerDataSource = BetterPlayerDataSource(
    //   BetterPlayerDataSourceType.network,
    //   "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4",
    // );

    _betterPlayerDataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      widget.videoObj.isEmpty
          ? "https://bitdash-a.akamaihd.net/content/sintel/hls/playlist.m3u8"
          : widget.videoObj[kDataWikfile],
      liveStream: false,
      useAsmsSubtitles: true,
      asmsTrackNames: ["Low quality", "Not so low quality", "Medium quality"],
      subtitles: [
        BetterPlayerSubtitlesSource(
          type: BetterPlayerSubtitlesSourceType.network,
          name: "EN",
          urls: [
            "https://dl.dropboxusercontent.com/s/71nzjo2ux3evxqk/example_subtitles.srt"
          ],
        ),
        BetterPlayerSubtitlesSource(
          type: BetterPlayerSubtitlesSourceType.network,
          name: "DE",
          urls: [
            "https://dl.dropboxusercontent.com/s/71nzjo2ux3evxqk/example_subtitles.srt"
          ],
        ),
      ],
    );
    betterPlayerController = BetterPlayerController(betterPlayerConfiguration);
    betterPlayerController.setupDataSource(_betterPlayerDataSource);
    super.initState();
    ShowLoader(context);
    getComments();
  }

  getComments() async {
    final url = "$baseUrl/gwbvc/";
    Map param = Map();
    param['pid'] = widget.videoObj[kDataID].toString();
    var result = await CallApi("GET", param, url, context);
    HideLoader(context);
    if (result[kDataCode] == "200") {
      print(result);
      setState(() {
        commentsList = result[kDataResult];
        controllerList = [];
        for (var i = 0; i < commentsList.length; i++) {
          Map obj = commentsList[i];
          obj[kDataReply] = [];
          commentsList.removeAt(i);
          commentsList.insert(i, obj);
          TextEditingController commentThreadTextController =
              TextEditingController();
          controllerList.add(commentThreadTextController);
        }
      });
    } else {
      ShowErrorMessage(result[kDataMessage], context);
    }
  }

  getReplies(commentId, index) async {
    final url = "$baseUrl/gwbrvc/";
    Map param = Map();
    param['cid'] = commentId.toString();
    var result = await CallApi("GET", param, url, context);
    HideLoader(context);
    if (result[kDataCode] == "200") {
      print(result);
      setState(() {
        List replyList = result[kDataResult];
        Map obj = commentsList[index];
        obj[kDataCount] = replyList.length;
        obj[kDataReply] = replyList;
        commentsList.removeAt(index);
        commentsList.insert(index, obj);
      });
    } else {
      ShowErrorMessage(result[kDataMessage], context);
    }
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

  Widget _cardBottom(bool isImage) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 1.0,
        ),
        Text(
          widget.videoObj[kDataTitle],
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
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Text(
                    widget.videoObj[kDataLocation],
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Quicksand',
                        fontWeight: FontWeight.bold,
                        fontSize: 13),
                  ),
                ),
              ],
            ),
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
                fontSize: 9,
              ),
            ),
            Text(
              '40k Comments',
              style: TextStyle(
                color: Colors.grey,
                fontFamily: 'Quicksand',
                fontWeight: FontWeight.bold,
                fontSize: 9,
              ),
            ),
          ],
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

  Widget setCommentSection(commentObj, commentIndex) {
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
          itemCount: commentObj[kDataReply].length + 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            String comment = '';
            String image = '';
            String username = '';
            if (index == 0) {
              comment = commentObj[kDataComment];
              image = commentObj[kDataUser][kDataUserProfile] != null
                  ? commentObj[kDataUser][kDataUserProfile][kDataUserImg]
                  : '';
              username = commentObj[kDataUser][kDataUsername];
            } else if (commentObj[kDataReply].isNotEmpty &&
                index < commentObj[kDataReply].length + 1) {
              comment = commentObj[kDataReply][index - 1][kDataComment];
              image = commentObj[kDataReply][index - 1][kDataUser]
                          [kDataUserProfile]
                      .isNotEmpty
                  ? commentObj[kDataReply][index - 1][kDataUser]
                      [kDataUserProfile][kDataUserImg]
                  : '';
              username =
                  commentObj[kDataReply][index - 1][kDataUser][kDataUsername];
            }
            return Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 30),
              child: Container(
                // height: index != 4 ? 120 : 60,
                width: MediaQuery.of(context).size.width,
                child: index != (commentObj[kDataReply].length + 1)
                    ? Padding(
                        padding:
                            EdgeInsets.only(left: (index % 2 == 0) ? 40 : 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: InkWell(
                                        child: CircleAvatar(
                                            radius: 12,
                                            backgroundImage: image.isNotEmpty
                                                ? NetworkImage(image)
                                                : null),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: Container(
                                              child: Center(
                                                child: Text(
                                                  username,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontFamily: 'Quicksand',
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  comment,
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Quicksand',
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      ShowLoader(context);
                                      if (index == 0) {
                                        deleteComment(
                                            commentObj[kDataID], commentIndex);
                                      } else {
                                        deleteReply(
                                            commentObj[kDataReply][index - 1]
                                                [kDataID],
                                            commentIndex,
                                            index - 1);
                                      }
                                    },
                                    icon: Icon(
                                      Icons.delete,
                                      size: 20,
                                      color: colorLocalGrey,
                                    ))
                              ],
                            ),
                          ],
                        ),
                      )
                    : Padding(
                        padding:
                            EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
                        child: Column(
                          children: [
                            commentObj[kDataReply].length !=
                                    commentObj[kDataCount]
                                ? Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: TextButton(
                                      onPressed: () {
                                        ShowLoader(context);
                                        getReplies(
                                            commentObj[kDataID], commentIndex);
                                      },
                                      child: Center(
                                        child: Text(
                                            'View ${commentObj[kDataCount]} Replies',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: colorLocalGrey)),
                                      ),
                                    ),
                                  )
                                : Container(),
                            Container(
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
                                textCapitalization: TextCapitalization.words,
                                autofocus: false,
                                controller: controllerList[commentIndex],
                                textAlign: TextAlign.left,
                                decoration: InputDecoration(
                                  hintText: 'Reply to this comment',
                                  suffixIcon: IconButton(
                                      padding: EdgeInsets.all(0),
                                      onPressed: () {
                                        ShowLoader(context);
                                        postReplyComment(
                                            controllerList[commentIndex].text,
                                            commentsList[commentIndex][kDataID],
                                            commentIndex);
                                      },
                                      icon: Icon(
                                        Icons.send,
                                        color: colorLocalPink,
                                        size: 25,
                                      )),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  disabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                      borderSide:
                                          BorderSide(color: Colors.white)),
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
                          ],
                        ),
                      ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget mainWidget() {
    return Container(
      // height: MediaQuery.of(context).size.height,
      // width: MediaQuery.of(context).size.width,
      // color: Colors.black,
      child: Stack(
        children: [
          Align(
            alignment: currentAlignment,
            child: GestureDetector(
              onHorizontalDragEnd: (details) => {
                //  alignmentAnimationController.forward(),
                //  widget.videoStatus(false)
              },
              onVerticalDragEnd: (details) {
                if (details.velocity.pixelsPerSecond.dy > 0) {
                  setState(() {
                    isInSmallMode = true;
                    alignmentAnimationController.forward();
                    videoViewController.forward();
                  });
                } else if (details.velocity.pixelsPerSecond.dy < 0) {
                  setState(() {
                    alignmentAnimationController.reverse();
                    videoViewController.reverse().then((value) {
                      setState(() {
                        isInSmallMode = false;
                      });
                    });
                  });
                }
              },
              child: Dismissible(
                direction: DismissDirection.horizontal,
                key: const Key('key'),
                onDismissed: (_) => widget.videoStatus(false),
                child: Container(
                  width: currentVideoWidth,
                  height: currentVideoHeight,
                  color: Colors.black,
                  child: AspectRatio(
                    aspectRatio: 1.4,
                    child: BetterPlayer(
                        controller: betterPlayerController,
                        key: betterPlayerKey),
                  ),
                ),
              ),
            ),
          ),
          currentAlignment == Alignment.topCenter
              ? Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: MediaQuery.of(context).size.height - 283,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 20, 16, 10),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                    onTap: () {
                                      ShowLoader(context);
                                      likeUnlikePost(context, "l");
                                      // setState(() {
                                      //   likeStatus = likeStatus != 2 ? 2 : 1;
                                      // });
                                    },
                                    child: Icon(
                                      Icons.thumb_up_alt_rounded,
                                      size: 25,
                                      color: likeStatus == 2
                                          ? colorLocalPink
                                          : colorLocalGrey,
                                    )),
                                Padding(
                                  padding: EdgeInsets.only(left: 5, right: 7),
                                  child: Text(
                                    '400k',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontFamily: 'Quicksand',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                InkWell(
                                    onTap: () {
                                      ShowLoader(context);
                                      likeUnlikePost(context, "d");
                                      // setState(() {
                                      //   likeStatus = likeStatus != 3 ? 3 : 1;
                                      // });
                                    },
                                    child: Icon(
                                      Icons.thumb_down_alt_rounded,
                                      size: 25,
                                      color: likeStatus == 3
                                          ? colorLocalPink
                                          : colorLocalGrey,
                                    )),
                                Padding(
                                  padding: EdgeInsets.only(left: 5, right: 7),
                                  child: Text(
                                    '40',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontFamily: 'Quicksand',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
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
                                  padding: EdgeInsets.only(left: 5, right: 7),
                                  child: Text(
                                    commentsList.length.toString(),
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontFamily: 'Quicksand',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Container(
                                  height: 20,
                                  width: 60,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
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
                                        '40k Views',
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.black,
                                          fontFamily: 'Quicksand',
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )),
                                ),
                                SizedBox(
                                  width: Platform.isIOS ? 40 : 20,
                                ),
                                InkWell(
                                    onTap: () {},
                                    child: Icon(
                                      Icons.share,
                                      size: 25,
                                      color: colorLocalGrey,
                                    ))
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 10, bottom: 10),
                              child: Container(
                                height: 1,
                                color: colorLocalVeryLightGrey,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 10),
                              height: MediaQuery.of(context).size.height * 0.08,
                              width: MediaQuery.of(context).size.width,
                              child: GridView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: myCategoryArray.length,
                                gridDelegate:
                                    SliverGridDelegateWithMaxCrossAxisExtent(
                                        maxCrossAxisExtent: 250,
                                        childAspectRatio: 3 / 5,
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
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          InkWell(
                                            onTap: () {},
                                            child: Container(
                                              height: 35,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
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
                                                    myCategoryArray[index]
                                                        .first,
                                                    style: TextStyle(
                                                      fontSize: 10,
                                                      color: Colors.black,
                                                      fontFamily: 'Quicksand',
                                                      fontWeight:
                                                          FontWeight.bold,
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
                            Padding(
                              padding: const EdgeInsets.only(top: 5, bottom: 5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    widget.videoObj[kDataTitle],
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Quicksand',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  InkWell(
                                      onTap: () {},
                                      child: Icon(
                                        Icons.bookmark,
                                        size: 25,
                                        color: colorLocalGrey,
                                      )),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5, bottom: 5),
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
                                      widget.videoObj[kDataLocation],
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
                              padding: const EdgeInsets.only(
                                top: 10,
                                bottom: 10,
                              ),
                              child: Container(
                                height: 60,
                                width: MediaQuery.of(context).size.width - 40,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        blurRadius: 3,
                                        spreadRadius: 3,
                                        offset: Offset(3, 2)),
                                  ],
                                ),
                                alignment: Alignment.center,
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: Container(
                                              child: InkWell(
                                                child: CircleAvatar(
                                                    radius: 12,
                                                    backgroundImage: widget
                                                                        .videoObj[
                                                                    kDataUser][
                                                                kDataUserProfile] !=
                                                            null
                                                        ? NetworkImage(widget
                                                                        .videoObj[
                                                                    kDataUser][
                                                                kDataUserProfile]
                                                            [kDataUserImg])
                                                        : null),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 12, bottom: 5, left: 7),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  child: Center(
                                                    child: Text(
                                                      widget.videoObj[kDataUser]
                                                          [kDataUsername],
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontFamily:
                                                              'Quicksand',
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 16),
                                                    ),
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
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(right: 20),
                                          child: Text(
                                            isFollowed ? 'Following' : 'Follow',
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: isFollowed
                                                    ? colorLocalGrey
                                                    : colorLocalPink,
                                                fontFamily: 'Quicksand',
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ]),
                              ),
                            ),
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
                                "There are many variations of passages of Lorem Ipsum available",
                                softWrap: true,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              expanded: Text(
                                'There are many variations of passages of Lorem Ipsum available, but the majority have suffered There are many variations of passages of Lorem Ipsum available, but the majority have suffered.There are many variations of passages of Lorem Ipsum available, but the majority have suffered There are many variations of passages of Lorem Ipsum available, but the majority have suffered.There are many variations of passages of Lorem Ipsum available, but the majority have suffered There are many variations of passages of Lorem Ipsum available, but the majority have suffered.',
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
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
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
                                          postComment(
                                              commentTextController.text);
                                        },
                                        icon: Icon(
                                          Icons.send,
                                          color: colorLocalPink,
                                          size: 25,
                                        )),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        borderSide:
                                            BorderSide(color: Colors.white)),
                                    disabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        borderSide:
                                            BorderSide(color: Colors.white)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
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
                                                MaterialStateProperty.all(
                                                    colorLocalGrey),
                                            shape: MaterialStateProperty.all<
                                                    RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
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
                                  collapsed: commentsList.isNotEmpty
                                      ? setCommentSection(commentsList[0], 0)
                                      : Container(),
                                  expanded: commentsList.isNotEmpty
                                      ? ListView.builder(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10),
                                          itemCount: commentsList.length,
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            Map obj = commentsList[index];
                                            return setCommentSection(
                                                obj, index);
                                          })
                                      : Container()),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Text(
                                "Recommended",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Quicksand',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 5, bottom: 10),
                              child: Container(
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
                                          color:
                                              Color.fromRGBO(251, 251, 251, 1),
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
                                        //       builder: (context) => VideoDetails()),
                                        // );
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              : Container()
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      maxVideoWidth = constraints.biggest.width;

      if (!isInSmallMode) {
        currentVideoWidth = maxVideoWidth;
      }
      return !isInSmallMode
          ? Dismissible(
              direction: DismissDirection.horizontal,
              key: const Key('key'),
              onDismissed: (_) => widget.videoStatus(false),
              child: mainWidget())
          : mainWidget();
    });
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
      ShowErrorMessage(result[kDataMessage], context);
    }
  }

  postComment(comment) async {
    final url = "$baseUrl/cwbvc/";
    Map param = Map();
    param['videoid'] = widget.videoObj[kDataID].toString();
    param["comment"] = comment;
    var result = await CallApi("POST", param, url, context);

    if (result[kDataCode] == "200") {
      print(result);
      getComments();
    } else {
      HideLoader(context);
      ShowErrorMessage(result[kDataMessage], context);
    }
  }

  postReplyComment(comment, commentId, commentIndex) async {
    final url = "$baseUrl/crwbvc/";
    Map param = Map();
    param['commentid'] = commentId.toString();
    param["comment"] = comment;
    param["replyto"] = widget.videoObj[kDataUser][kDataID].toString();
    var result = await CallApi("POST", param, url, context);
    if (result[kDataCode] == "200") {
      print(result);
      getReplies(commentId, commentIndex);
    } else {
      HideLoader(context);
      ShowErrorMessage(result[kDataMessage], context);
    }
  }

  deleteComment(commentId, commentIndex) async {
    final url = "$baseUrl/dwbivc/";
    Map param = Map();
    param['utype'] = 'video';
    param['pid'] = commentId.toString();
    var result = await CallApi("DELETE", param, url, context);
    HideLoader(context);
    if (result[kDataCode] == "200") {
      setState(() {
        commentsList.removeAt(commentIndex);
      });
    } else {
      ShowErrorMessage(result[kDataMessage], context);
    }
  }

  deleteReply(commentId, commentIndex, replyIndex) async {
    final url = "$baseUrl/dwbivrc/";
    Map param = Map();
    param['utype'] = 'video';
    param['cid'] = widget.videoObj[kDataID].toString();
    param["id"] = commentId.toString();
    var result = await CallApi("DELETE", param, url, context);
    HideLoader(context);
    if (result[kDataCode] == "200") {
      setState(() {
        Map obj = commentsList[commentIndex];
        obj[kDataReply].removeAt(replyIndex);
        commentsList.removeAt(commentIndex);
        commentsList.insert(commentIndex, obj);
      });
    } else {
      ShowErrorMessage(result[kDataMessage], context);
    }
  }

  likeUnlikePost(context, status) async {
    final url = "$baseUrl/cwblv/";
    Map param = Map();
    param['videoid'] = widget.videoObj[kDataID].toString();
    param['status'] = status;
    var result = await CallApi("POST", param, url, context);
    HideLoader(context);
    if (result[kDataCode] == "200") {
      setState(() {
        // if (result[kDataResult][kDataImageId] != null) {
        //   likeStatus = 2;
        // } else {
        //   likeStatus = 1;
        // }
      });
    } else {
      ShowErrorMessage(result[kDataMessage], context);
    }
  }
}
