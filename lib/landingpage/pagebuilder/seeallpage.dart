import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class SeeAllPage extends StatefulWidget {
  final List? trendingList;
  // ignore: use_key_in_widget_constructors
  const SeeAllPage({this.trendingList});

  @override
  State<SeeAllPage> createState() =>
      // ignore: no_logic_in_create_state
      _SeeAllPageState(trendingList: trendingList);
}

class _SeeAllPageState extends State<SeeAllPage> {
  List? trendingList;
  _SeeAllPageState({this.trendingList});
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    //int index = 0;

    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            color: Colors.white,
            icon: const Icon(Icons.chevron_left),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          backgroundColor: Color.fromARGB(255, 10, 21, 46),
          title: const Text(
            "Now Showing",
            style: TextStyle(color: Colors.white),
          )),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.only(
              left: w * 0.02,
              right: w * 0.02,
              top: w * 0.04,
            ),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: h * 0.035,
                //crossAxisSpacing: w * 0.01,
                mainAxisExtent: h * 0.41,
              ),
              itemCount: trendingList?.length,
              itemBuilder: (context, index) {
                if (trendingList![index]['poster_path'] == null) {
                  return Container(
                      color: Colors.grey,
                      height: h * 0.35,
                      width: w * 0.43,
                      child: const Center(
                        child: Text("Coming soon"),
                      ));
                }
                return CardBuilder(h, w, trendingList!, index);
              },
            ),
          ),
        ],
      ),
    );
  }

  CardBuilder(double h, double w, List trendingList, int index) {
    return Container(
      child: Column(
        children: [
          Container(
              height: h * 0.35,
              width: w * 0.43,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(7),
                child: Image(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        'https://image.tmdb.org/t/p/w500/${trendingList[index]['poster_path']}')),
              )),
          SizedBox(
            height: h * 0.008,
            // width: w * 0.32,
          ),
          SizedBox(
              // height: h * 0.10,
              width: w * 0.43,
              child: Text(trendingList[index]['title'] ?? "Loading",
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w600,
                    fontSize: trendingList[index]['title'] != null
                        ? trendingList[index]['title'].toString().length <= 24
                            ? MediaQuery.of(context).size.height * 0.018
                            : MediaQuery.of(context).size.height * 0.013
                        : MediaQuery.of(context).size.height * 0.018,
                  ))),
        ],
      ),
    );
  }
}
