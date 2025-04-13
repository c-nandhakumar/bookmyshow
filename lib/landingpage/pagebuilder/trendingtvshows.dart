import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class TrendingTvShows extends StatelessWidget {
  List? trendingShows;
  String? titleText;
  TrendingTvShows({Key? key, this.trendingShows, this.titleText})
      : super(key: key) {}
  @override
  Widget build(BuildContext context) {
    double h = (MediaQuery.of(context).size.height);
    double w = (MediaQuery.of(context).size.width);

    return Container(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: EdgeInsets.only(left: w * 0.02),
          child: Text(
            titleText!,
            style: TextStyle(
              // fontFamily: 'RobotoCondensed',
              fontWeight: FontWeight.w500,
              fontSize: MediaQuery.of(context).size.height / 45,
            ),
          ),
        ),
        SizedBox(
          height: h * 0.015,
        ),
        Container(
          height: h * 0.33,
          child: ListView.builder(
              key: const PageStorageKey<String>('page3'),
              itemCount: trendingShows?.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {},
                  child: Container(
                      //width: w / 2.8,
                      margin: EdgeInsets.only(right: h * 0.01),
                      child: trendingShows![index]['poster_path'] == null
                          ? Container()
                          : Column(
                              children: [
                                Container(
                                  height: h * 0.26,
                                  width: w * 0.33,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          'https://image.tmdb.org/t/p/w500/' +
                                              trendingShows![index]
                                                  ['poster_path']),
                                    ),
                                  ),
                                ),

                                // Container(
                                //   height: h * 0.26,
                                //   width: w * 0.33,
                                //   decoration: BoxDecoration(
                                //     shape: BoxShape.rectangle,
                                //     borderRadius:
                                //         BorderRadius.all(Radius.circular(10.0)),
                                //     image: DecorationImage(
                                //       image: NetworkImage(
                                //           'https://image.tmdb.org/t/p/w500/' +
                                //               trendingShows![index]['poster_path']),
                                //     ),
                                //   ),
                                // ),
                                SizedBox(
                                  height: h * 0.008,
                                ),
                                Container(
                                    width: w * 0.32,
                                    child: Text(
                                        trendingShows![index]['name'] != null
                                            ? trendingShows![index]['name']
                                            : "Loading",
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: GoogleFonts.roboto(
                                          fontWeight: FontWeight.w400,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.015,
                                        ))),
                              ],
                            )),
                );
              }),
        )
      ]),
    );
  }
}
