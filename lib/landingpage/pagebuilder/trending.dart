import 'package:bookmyshow/landingpage/pagebuilder/descriptionpage/description.dart';
import 'package:bookmyshow/landingpage/pagebuilder/seeallpage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class TrendingMovies extends StatelessWidget {
  List? trendingMovies;
  String? titleText;
  TrendingMovies({Key? key, this.trendingMovies, this.titleText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double h = (MediaQuery.of(context).size.height);
    double w = (MediaQuery.of(context).size.width);

    return Container(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: EdgeInsets.only(left: w * 0.02),
          child: Row(
            children: [
              Text(
                titleText!,
                style: TextStyle(
                  // fontFamily: 'RobotoCondensed',
                  fontWeight: FontWeight.w500,
                  fontSize: MediaQuery.of(context).size.height * 0.0225,
                ),
              ),
              const Spacer(),
              Padding(
                padding: EdgeInsets.only(right: h * 0.01),
                child: InkWell(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          SeeAllPage(trendingList: trendingMovies))),
                  child: Row(children: [
                    Text(
                      "See All",
                      style: TextStyle(
                        fontSize: h * 0.018,
                        color: const Color.fromARGB(255, 190, 25, 13),
                      ),
                    ),
                    Icon(
                      Icons.chevron_right_outlined,
                      size: h * 0.02,
                      color: const Color.fromARGB(255, 190, 25, 13),
                    )
                  ]),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: h * 0.015,
        ),
        Container(
          height: h * 0.32,
          child: ListView.builder(
              key: const PageStorageKey<String>('page2'),
              itemCount: trendingMovies?.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return trendingMovies![index]['poster_path'] == null
                    ? Container()
                    : InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            //Description page
                            PageRouteBuilder(
                                pageBuilder: (context, animation,
                                        secondaryAnimation) =>
                                    ListenableProvider(
                                      create: (context) => animation,
                                      builder: (context, child) => Description(
                                        id: trendingMovies![index]['id'],
                                        name: trendingMovies![index]['title'] ??
                                            "Loading",
                                        description: trendingMovies![index]
                                            ['overview'],
                                        vote: trendingMovies![index]
                                                ['vote_average']
                                            .toString(),
                                        bannerurl:
                                            'https://image.tmdb.org/t/p/w500/${trendingMovies![index]['backdrop_path']}',
                                        posterurl:
                                            'https://image.tmdb.org/t/p/w500/${trendingMovies![index]['poster_path']}',
                                        launchon: trendingMovies![index]
                                                ['release_date'] ??
                                            "Loading",
                                        movieImgUrl:
                                            'https://image.tmdb.org/t/p/w500/${trendingMovies![index]['poster_path']}',
                                      ),
                                    ),
                                transitionDuration:
                                    const Duration(milliseconds: 500)),
                          );
                        },
                        child: Container(
                          //width: w / 2.8,
                          margin: EdgeInsets.only(right: h * 0.01),
                          child: Column(
                            children: [
                              Container(
                                height: h * 0.26,
                                width: w * 0.33,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          // ignore: prefer_interpolation_to_compose_strings
                                          'https://image.tmdb.org/t/p/w500/' +
                                              trendingMovies![index]
                                                  ['poster_path'])),
                                ),
                              ),
                              SizedBox(
                                height: h * 0.008,
                              ),
                              SizedBox(
                                width: w * 0.32,
                                child: Text(
                                  trendingMovies![index]['title'] ?? "Loading",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: GoogleFonts.roboto(
                                    fontWeight: FontWeight.w400,
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.014,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
              }),
        )
      ]),
    );
  }
}
