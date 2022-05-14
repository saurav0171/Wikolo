import 'package:flutter/material.dart';

class SocialCategory extends StatelessWidget {

  final myImageAndCaption = [
    [ "All"],
    [ "Books"],
    ["Electronics"],
    ["Games"],
    ["Music"],
    ["Podcast"],
    ["UI.Services"],
    ["Health"],
    ["Fashion"],
    ["Jobs"],
    ["Food"],
    ["Lofi"],
    ["Matrimonial"],
    ["Beauty"],
    ["Comedy"],
    ["Podcast"],
    ["UI.Services"],
    ["Health"],
    ["Fashion"],
    ["Jobs"],
    ["Food"],
    ["Lofi"],
    ["Matrimonial"],
    ["Beauty"],
    ["Comedy"],
    ["Podcast"],
    ["UI.Services"],
    ["Health"],
    ["Fashion"],
    ["Jobs"],
    ["Food"],
    ["Lofi"],
    ["Matrimonial"],
    ["Beauty"],
    ["Comedy"],
  ];

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
              onPressed: () {

              },
              child: Text(""),
              shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
            ),
          ],
          leading: BackButton(
            color: Colors.black,
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Center(child: Text('Categories', style: TextStyle(
            color: Colors.black,
            fontFamily: 'Quicksand',
            fontWeight: FontWeight.bold,
          ),
          ),
          ),
        ),
        body: Container(
          padding:  EdgeInsets.only(top: 10.0,left: 10.0,right: 10.0),
          width: MediaQuery
              .of(context)
              .size
              .width,
          height: MediaQuery
              .of(context)
              .size
              .height,
          decoration: BoxDecoration(
            color: Color.fromRGBO(252, 252, 252, 1),
          ),

          child: GridView.count(
            mainAxisSpacing: 4,
            crossAxisSpacing: 5,
            childAspectRatio: 2/1.3,
            crossAxisCount: 4,
            children: [
              ...myImageAndCaption.map(
                    (i) => Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                  children: [


                    Container(
                      height: 40,
                      width: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 5,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Center(
                      child: Text(i.first,style: TextStyle(
                        fontSize: 12,
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
}
