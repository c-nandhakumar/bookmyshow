import 'package:bookmyshow/landingpage/pagebuilder/descriptionpage/ratingpage/sliderRating.dart';
import 'package:bookmyshow/landingpage/pagebuilder/trending.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class RatingPage extends StatefulWidget {
  String? movieImgUrl, name;
  RatingPage(this.movieImgUrl, this.name, {Key? key}) : super(key: key);

  @override
  State<RatingPage> createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingPage> {
  double value = 0;
  void callback(value) {
    setState(() {
      this.value = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        elevation: 1,
        shadowColor: Colors.grey,
        title: Container(
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Positioned(
                child: Container(
                  alignment: Alignment.center,
                  child: const Text(
                    "How was the movie?",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              Positioned(
                child: Container(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    icon: Icon(Icons.disabled_by_default),
                    color: Colors.black,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(w * 0.04),
        shrinkWrap: true,
        children: [
          Container(
            padding: EdgeInsets.only(top: h * 0.02),
            alignment: Alignment.center,
            height: h * 0.24,
            width: w * 0.28,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(w * 0.01),
              child: Image(
                  fit: BoxFit.cover,
                  image: NetworkImage(widget.movieImgUrl.toString())),
            ),
          ),
          Container(
              padding: EdgeInsets.only(top: h * 0.015),
              alignment: Alignment.center,
              width: double.infinity,
              child: Text(widget.name.toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.w500, fontSize: w * 0.037))),
          SizedBox(
            height: h * 0.035,
          ),
          Text("How would you rate the movie?",
              style:
                  TextStyle(fontWeight: FontWeight.w500, fontSize: w * 0.041)),
          Container(
            padding: EdgeInsets.only(top: h * 0.03),
            height: h * 0.125,
            child: SliderPage(callback),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 2,
        child: Container(
          height: h * 0.06,
          padding: EdgeInsets.only(
              left: w * 0.03, right: w * 0.03, bottom: w * 0.02),
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
                backgroundColor: value == 0 ? Colors.grey[700] : Colors.red),
            child: Text(
              "Submit Rating",
              style: TextStyle(fontSize: w * 0.04, fontWeight: FontWeight.w400),
            ),
          ),
        ),
      ),
    );
  }
}
