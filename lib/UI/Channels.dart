// ignore_for_file: prefer_const_constructors
import 'dart:io';

import 'package:flutter/material.dart';
import 'SocialCategory.dart';

class Channels extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final myImageAndCaption = [
      ["assets/images/ic_channel.png", "Jen Kim"],
      ["assets/images/ic_channel.png", "Jen Kim"],
      ["assets/images/ic_channel.png", "Jen Kim"],
      ["assets/images/ic_channel.png", "Jen Kim"],
      ["assets/images/ic_channel.png", "Jen Kim"],
      ["assets/images/ic_channel.png", "Jen Kim"],
      ["assets/images/ic_channel.png", "Jen Kim"],
    ];

    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: BackButton(
            color: Colors.black,
            onPressed: () => Navigator.of(context).pop(),
          ),
          centerTitle: true,
          title: Text(
            'Channels',
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Quicksand',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Container(
          padding: EdgeInsets.only(
            top: 30.0,
          ),
          child: GridView.count(
            crossAxisCount: 4,
            crossAxisSpacing: 7,
            mainAxisSpacing: 10,
            childAspectRatio: Platform.isIOS ? 0.7 : 0.6,
            padding: EdgeInsets.symmetric(horizontal: 10),
            children: [
              ...myImageAndCaption.map(
                (i) => Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SocialCategory()),
                          );
                        },
                        child: Container(
                          height: 130,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 3,
                                blurRadius: 2,
                                offset:
                                    Offset(0, 2), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 0.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10)),
                                  child: Image.asset(
                                    i.first,
                                    fit: BoxFit.fitWidth,
                                    height: 70,
                                    width: 120,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                                child: SizedBox(
                                  width: 100,
                                  child: Center(
                                    child: Text(
                                      i.last,
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.black,
                                        fontFamily: 'Quicksand',
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 100,
                                child: Center(
                                  child: Text(
                                    "Follow",
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.red,
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
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
