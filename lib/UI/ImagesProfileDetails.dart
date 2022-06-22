// ignore_for_file: prefer_const_constructors
import 'package:carousel_slider/carousel_slider.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:wikolo/UI/Likes.dart';

import '../CommonFiles/common.dart';

final List<String> imgList = [
  'https://www.learningcontainer.com/wp-content/uploads/2020/08/Sample-Small-Image-PNG-file-Download.png',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
];

class ImageProfileDetails extends StatefulWidget {
  const ImageProfileDetails({Key? key}) : super(key: key);

  @override
  State<ImageProfileDetails> createState() => _ImageProfileDetailsState();
}

class _ImageProfileDetailsState extends State<ImageProfileDetails> {
  List<String> optionList = ['option1', 'option2', 'option3'];
  int _current = 0;
  List _currentImage = [];
  var likeStatus = 1; //1 for nothing, 2 for like, 3 for Unlike
  bool isCommented = false;
  final CarouselController _controller = CarouselController();
  ExpandableController commentController = ExpandableController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (var i = 0; i < imgList.length; i++) {
      _currentImage.add(i);
    }
  }

  final List<Widget> imageSliders = imgList
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
                            fit: BoxFit.fitHeight, height: 600, width: 1200.0),
                      ],
                    )),
              ),
            ),
          ))
      .toList();

  Widget setPostForUser(int imageIndex) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.only(top: 10, left: 20, right: 50),
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
                                AssetImage('assets/images/ic_demoprofile.png'),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 12, bottom: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
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
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: Text(
                        'Follow',
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.pink,
                            fontFamily: 'Quicksand',
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
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
              items: imageSliders,
              carouselController: _controller,
              options: CarouselOptions(
                  autoPlay: true,
                  enlargeCenterPage: true,
                  enableInfiniteScroll: true,
                  aspectRatio: 0.8,
                  viewportFraction: 0.8,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentImage[imageIndex] = index;
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
                    margin:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: (Colors.white).withOpacity(
                            _currentImage[imageIndex] == entry.key ? 1 : 0.4)),
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
                  color: likeStatus == 2 ? colorLocalPink : colorLocalGrey,
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
                  color: isCommented == true ? colorLocalPink : colorLocalGrey,
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
        child: ExpandablePanel(
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
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Container(
          height: 1,
          width: MediaQuery.of(context).size.width,
          color: colorLocalVeryLightGrey,
        ),
      ),
    ]);
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
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            // ...imgList.map((e) => setPostForUser()),
            ...imgList.map((element) {
              // get index
              var index = imgList.indexOf(element);
              return setPostForUser(index);
            }).toList(),
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 20, right: 50),
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
                                  backgroundImage: AssetImage(
                                      'assets/images/ic_demoprofile.png'),
                                ),
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
                                  child: Center(
                                    child: Text(
                                      "Mia Nore",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'Quicksand',
                                          fontWeight: FontWeight.bold,
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
                          Padding(
                            padding: const EdgeInsets.only(left: 30),
                            child: Text(
                              'Follow',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.pink,
                                  fontFamily: 'Quicksand',
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'Sponsored',
                        style: TextStyle(
                            fontSize: 10,
                            color: Colors.black,
                            fontFamily: 'Quicksand',
                            fontWeight: FontWeight.bold),
                      ),
                    ]),
              ),
            ),
            Stack(
              children: [
                Container(
                  child: CarouselSlider(
                    items: imageSliders,
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
                    alignment: Alignment(0.7, -1),
                    heightFactor: 7,
                    child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.bookmark,
                          color: Colors.red,
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
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: ExpandablePanel(
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
            ),
            SizedBox(
              height: 30,
            )
          ]),
        ),
      ),
    );
  }

  //   likeUnlikePost(context) async {
  //   final url = "$baseUrl/cwbli/";
  //   Map param = Map();
  //   param['imageid'] = widget.imageObject[kDataID].toString();
  //   var result = await CallApi("POST", param, url, context);
  //   HideLoader(context);
  //   if (result[kDataCode] == "200") {
  //     setState(() {
  //       if (result[kDataResult][kDataImageId] != null) {
  //         likeStatus = 2;
  //       } else {
  //         likeStatus = 1;
  //       }
  //     });
  //   } else {
  //     ShowErrorMessage(result[kDataMessage], context);
  //   }
  // }
}
