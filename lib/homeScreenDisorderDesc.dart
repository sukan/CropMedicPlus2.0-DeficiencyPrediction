import 'package:flutter/material.dart';
import 'Disorder/CitrusNitrogen.dart';
import 'Disorder/CornPhosphorus.dart';
import 'Disorder/GroundnutNitrogen.dart';
import 'Disorder/GuavaPotassium.dart';

class DisorderList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      width: 220,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.all(10.0),
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => GroundnutNitrogen()),
              );
            },
            child: disorder('assets/10.JPG', 'Trending', 'Groundnut Nitrogen Deficiency'),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => GuavaPotassium()),
              );
            },
            child: disorder('assets/2.jpg', 'Trending', 'Guava Potassium Deficiency'),
          ),
          GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CitrusNitrogen()),
                );
              },
              child: disorder('assets/18.jpg', 'Trending', 'Citrus Nitrogen Deficiency')
          ),
          GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CornPhosphorus()),
                );
              },
              child: disorder('assets/9.jpg', 'Trending', 'Corn Phosphorus Deficiency')
          )

        ],
      ),
    );
  }

  Widget disorder(
      String imageurl,
      String tag,
      String name,
      ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Card(
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Stack(
            children: <Widget>[
              Image.asset(
                imageurl,
                height: 340,
                width: 230,
                fit: BoxFit.cover,
              ),
              Positioned(
                top: 16,
                left: 140,
                child: Container(
                    height: 25.0,
                    width: 80.00,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3.0),
                        color: Color(0xff0F0F0F),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xff0F0F0F).withOpacity(0.3),
                          )
                        ]),
                    child: Center(
                      child: Text(
                        tag,
                        style: TextStyle(color: Colors.white),
                      ),
                    )),
              )
            ],
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 5,
          margin: EdgeInsets.all(10),
        ),
        Padding(
          padding: EdgeInsets.only(left: 16),
          child: Text(
            name,
            style: TextStyle(fontFamily: 'ConcertOne-Regular'),
          ),
        ),


      ],
    );
  }


}
