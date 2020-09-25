import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
class CornPhosphorus extends StatefulWidget {
  CornPhosphorus({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _CornPhosphorusState createState() => _CornPhosphorusState();
}

class _CornPhosphorusState extends State<CornPhosphorus> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
          children: <Widget>[
            Stack(
              children: <Widget>[
                SizedBox(
                    height: 300.0,
                    child: Stack(
                      children: <Widget>[
                        Carousel(
                          images: [
                            AssetImage('assets/14.jpg'),
                            // Photo from https://unsplash.com/photos/2d4lAQAlbDA
                            AssetImage('assets/15.JPG'),
                            // Photo from https://unsplash.com/photos/FqqiAvJejto
//                            AssetImage('assets/12.jpg'),
                            // Photo from https://unsplash.com/photos/_-JR5TxKNSo

                          ],
                          dotSize: 4.0,
                          dotSpacing: 15.0,
                          autoplay: false,
                          dotColor: Colors.white,
                          indicatorBgPadding: 50.0,
                          dotBgColor: Colors.transparent,
                          borderRadius: false,
                          moveIndicatorFromBottom: 200.0,
                          noRadiusForIndicator: true,
                        ),
                      ],
                    )),
                Padding(
                  padding: EdgeInsets.only(top: 270, left: 20, right: 20),
                  child: Container(
                      height: 100.0,
                      width: MediaQuery.of(context).size.width - 24.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 2.0,
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 2.0)
                          ]),
                      child: Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Corn Phosphorus Deficiency',
                              style: new TextStyle(
                                fontFamily: "VT323",
                                fontWeight: FontWeight.bold,
                                fontSize: 22.0,),

                            ),
                            Text('', style: new TextStyle(fontSize: 15.0,),),

                          ],
                        ),
                      )),
                ),
                AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 60, bottom: 20, left: 14, right: 14),
              child: Text('SYMPTOMS',
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'ConcertOne-Regular'),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20, bottom: 20, left: 14, right: 14),
              child: Text(' Plants are dark green with reddishpurplish leaf tips and margins on older leaves. Newly emerging leaves will not show the coloration. Phosphorus deficient plants are smaller and grow more slowly than do plants with adequate phosphorus. ', style: TextStyle(
                  fontSize: 17,
                  fontFamily: 'Raleway'),textAlign: TextAlign.justify,),
            ),
            Padding(
              padding: EdgeInsets.only(top: 40, bottom: 20, left: 14, right: 14),
              child: Text(
                'Deficiency Stage',
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'ConcertOne-Regular'),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(top: 40, bottom: 20, left: 14, right: 14),
              child: Text(
                'Suitable Fertilizer',
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'ConcertOne-Regular'),
              ),

            ),
            Padding(
              padding: EdgeInsets.only(top: 20, bottom: 20, left: 14, right: 14),
              child: Text('Foliar spray of Urea @ 1-2 % at fortnightly intervals.',
                textAlign: TextAlign.justify,style: TextStyle(
                    fontSize: 17,
                    fontFamily: 'Raleway'),
              ),

            ),

          ],
        ));
  }

  Widget amenities(
      String url1,
      String url2,
      String url3,
      String features1,
      String features2,
      String features3,
      ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Container(
            width: 76,
            height: 76,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40.0),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0, 1.0),
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 0.2)
                ]),
            child: Column(
              children: <Widget>[
                Image.asset(
                  url1,
                  fit: BoxFit.contain,
                  height: 40.0,
                  width: 40.0,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(features1)
              ],
            )),
        Container(
            width: 76,
            height: 76,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40.0),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0, 1.0),
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 0.2)
                ]),
            child: Column(
              children: <Widget>[
                Image.asset(
                  url2,
                  fit: BoxFit.contain,
                  height: 40.0,
                  width: 40.0,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(features2)
              ],
            )),
        Container(
            width: 76,
            height: 76,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40.0),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0, 1.0),
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 0.2)
                ]),
            child: Column(
              children: <Widget>[
                Image.asset(
                  url3,
                  fit: BoxFit.contain,
                  height: 40.0,
                  width: 40.0,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(features3)
              ],
            )),
      ],
    );
  }

  Widget about_hotel(
      String description,
      ) {
    return Padding(
        padding: EdgeInsets.only(left: 14, top: 6, right: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              description,
              style: TextStyle(fontSize: 20, fontFamily: 'ConcertOne-Regular'),
            ),
          ],
        ));
  }
}
