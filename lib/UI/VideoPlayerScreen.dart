// ignore_for_file: prefer_const_constructors
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:better_player/better_player.dart';
import 'package:flutter/services.dart';
import 'package:wikolo/CommonFiles/common.dart';

class UsingVideoControllerExample extends StatefulWidget {
  UsingVideoControllerExample({Key? key}) : super(key: key);

  @override
  _UsingVideoControllerExampleState createState() =>
      _UsingVideoControllerExampleState();
}

class _UsingVideoControllerExampleState
    extends State<UsingVideoControllerExample> {
  late BetterPlayerController _betterPlayerController;
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
      "https://bitdash-a.akamaihd.net/content/sintel/hls/playlist.m3u8",
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
    _betterPlayerController = BetterPlayerController(betterPlayerConfiguration);
    _betterPlayerController.setupDataSource(_betterPlayerDataSource);
    super.initState();
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
                            textCapitalization: TextCapitalization.words,
                            autofocus: false,
                            textAlign: TextAlign.left,
                            decoration: InputDecoration(
                              hintText: 'Reply to this comment',
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
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: colorLocalPink.withOpacity(0.5),
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Icon(Icons.arrow_back),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.black,
        child: Stack(
          children: [
            AspectRatio(
              aspectRatio: 1.4,
              child: BetterPlayer(controller: _betterPlayerController),
            ),
            Align(
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
                                  setState(() {
                                    likeStatus = likeStatus != 2 ? 2 : 1;
                                  });
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
                                  setState(() {
                                    likeStatus = likeStatus != 3 ? 3 : 1;
                                  });
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
                              width: 40,
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
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
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
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
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
                                                myCategoryArray[index].first,
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.black,
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
                        Padding(
                          padding: const EdgeInsets.only(top: 5, bottom: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Lofi hip hop mix - Beats",
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
                              Text(
                                " San Francisco",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Quicksand',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
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
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Container(
                                          child: InkWell(
                                            child: CircleAvatar(
                                              radius: 20,
                                              backgroundImage: AssetImage(
                                                  'assets/images/ic_demoprofile.png'),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 12, bottom: 5),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              child: Center(
                                                child: Text(
                                                  " Divya Sharma",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontFamily: 'Quicksand',
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
                                  Padding(
                                    padding: const EdgeInsets.only(right: 20),
                                    child: Text(
                                      'Follow',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.pink,
                                          fontFamily: 'Quicksand',
                                          fontWeight: FontWeight.bold),
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
                              textAlign: TextAlign.left,
                              decoration: InputDecoration(
                                hintText: 'Leave a Comment',
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
          ],
        ),
      ),
    );
  }
}
