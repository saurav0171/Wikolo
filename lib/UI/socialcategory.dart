// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:wikolo/CommonFiles/common.dart';
import 'package:wikolo/ServerFiles/service_api.dart';

class SocialCategory extends StatefulWidget {
  final Function setCategory;
  const SocialCategory({Key? key, required this.setCategory}) : super(key: key);

  @override
  State<SocialCategory> createState() => _SocialCategoryState();
}

class _SocialCategoryState extends State<SocialCategory> {
  var selectedCategory = '';
  var myImageAndCaption = [];

  @override
  void initState() {
    super.initState();
    ShowLoader(context);
    getCategories();
  }

  getCategories() async {
    final url = "$baseUrl/gwc/";
    Map param = Map();
    var result = await CallApi("GET", param, url, context);
    HideLoader(context);
    if (result[kDataCode] == "200") {
      print(result);
      setState(() {
        myImageAndCaption = result[kDataResult];
      });
    } else {
      HideLoader(context);
      ShowErrorMessage(result[kDataMessage], context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          actions: <Widget>[
            FlatButton(
              height: 40,
              minWidth: 40,
              textColor: Colors.white,
              onPressed: () {},
              child: Text(""),
              shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
            ),
          ],
          leading: BackButton(
            color: Colors.black,
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Center(
            child: Text(
              'Categories',
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Quicksand',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        body: Container(
          padding: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: Color.fromRGBO(252, 252, 252, 1),
          ),
          child: GridView.count(
            mainAxisSpacing: 4,
            crossAxisSpacing: 5,
            childAspectRatio: 2 / 1.3,
            crossAxisCount: 4,
            children: [
              ...myImageAndCaption.map(
                (i) => InkWell(
                  onTap: () {
                    setState(() {
                      selectedCategory = i[kDataCategory];
                      widget.setCategory(selectedCategory);
                    });
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 40,
                        width: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: selectedCategory == i[kDataCategory]
                              ? colorLocalPink
                              : Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 1,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            i[kDataCategory],
                            style: TextStyle(
                              fontSize: 12,
                              color: selectedCategory == i[kDataCategory]
                                  ? Colors.white
                                  : Colors.black,
                              fontFamily: 'Quicksand',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
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
