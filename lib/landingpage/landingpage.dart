import 'package:bookmyshow/landingpage/cardgeneration/carouselbuilder.dart';
import 'package:bookmyshow/landingpage/cardgeneration/gridview.dart';
import 'package:bookmyshow/landingpage/cardgeneration/homeicon.dart';
import 'package:bookmyshow/landingpage/pagebuilder/descriptionpage/description.dart';
import 'package:bookmyshow/notifications/notification_page.dart';
import 'package:bookmyshow/provider/movielist_provider.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:bookmyshow/landingpage/pagebuilder/trendingtvshows.dart';
import 'package:bookmyshow/landingpage/pagebuilder/trending.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../models/movie_model.dart';

class LandingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LandingPageState();
  }
}

double? h, w, size;

class LandingPageState extends State<LandingPage> {
  String? qrCode = 'Unknown';

  @override
  Widget build(BuildContext context) {
    final movieListProvider = Provider.of<MovieList>(context);
    h = MediaQuery.of(context).size.height * 0.23;
    w = MediaQuery.of(context).size.width * 0.25;
    //size = MediaQuery.of(context).size;
    List<String> items = ['English', 'Tamil', 'Hindi'];
    String? selectedItem;
    Map<String, List<String>> langList = {
      'English': ['en', 'US'],
      'Tamil': ['ta', 'US'],
      'Hindi': ['hi', 'IN']
    };
    IconGenerator();
    List<Movie> moviesList = movieListProvider.movieList;

    return Container(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 248, 245, 245),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 10, 21, 46),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                onPressed: () async {
                  final result = await showSearch(
                      context: context, delegate: SearchMovies(moviesList));
                  // Navigator.of(context).push(
                  //   PageRouteBuilder(
                  //     pageBuilder: (context, animation, secondaryAnimation) =>
                  //         ListenableProvider(
                  //       create: (context) => animation,
                  //       builder: (context, child) => Description(
                  //         id: result!.id as int,
                  //         name: result.title ?? "Loading",
                  //         description: result.overview as String,
                  //         vote: result.voteAverage.toString(),
                  //         bannerurl:
                  //             'https://image.tmdb.org/t/p/w500/${result.backdropPath}',
                  //         posterurl:
                  //             'https://image.tmdb.org/t/p/w500/${result.posterPath}',
                  //         launchon: result.releaseDate.toString(),
                  //         movieImgUrl:
                  //             'https://image.tmdb.org/t/p/w500/${result.posterPath}',
                  //       ),
                  //     ),
                  //     transitionDuration: const Duration(milliseconds: 500),
                  //   ),
                  // );
                  // ScaffoldMessenger.of(context).showSnackBar(
                  //     SnackBar(content: Text(res!.title.toString())));
                },
                icon: const Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                iconSize: 27),
            IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const NotificationPage()));
              },
              icon: const Icon(
                Icons.notifications_none_outlined,
                color: Colors.white,
              ),
              iconSize: 27,
            ),
            IconButton(
              onPressed: scanQrCode,
              icon: const Icon(
                Icons.qr_code,
                color: Colors.white,
              ),
              iconSize: 27,
            ),
          ],
          title: Container(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FittedBox(
                child: Text(
                  "title text".tr,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              const Text(
                "Coimbatore",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                ),
                textAlign: TextAlign.left,
              ),
            ],
          )),
        ),
        body: ListView(
          key: const PageStorageKey<String>('page'),
          padding: EdgeInsets.all(h! / 25),
          children: [
            SizedBox(height: 70, child: IconGenerator()),
            const CarouselBuilder(),
            const SizedBox(
              height: 20,
            ),
            Consumer<MovieList>(
              builder: (context, value, child) {
                return TrendingMovies(
                  titleText: 'recommended movies'.tr,
                  trendingMovies: value.trendingMoviesList,
                );
              },
            ),
            const GridList(),
            const SizedBox(
              height: 20,
            ),
            Consumer<MovieList>(
              builder: (context, value, child) {
                return TrendingMovies(
                  titleText: 'top rated movies'.tr,
                  trendingMovies: value.topRatedMoviesList,
                );
              },
            ),
            Consumer<MovieList>(
              builder: (context, state, child) {
                return TrendingTvShows(
                  titleText: 'tv shows'.tr,
                  trendingShows: state.tvShowsList,
                );
              },
            ),
            // Container(
            //   color: Colors.red[400],
            //   padding: EdgeInsets.all(20),
            //   child: Text(
            //     'QR TEXT : ${qrCode}',
            //     textAlign: TextAlign.center,
            //   ),
            // ),
            // TextButton(
            //   onPressed: () => throw Exception(),
            //   child: const Text("Throw Test Exception"),
            // ),
            // Container(
            //   decoration: BoxDecoration(
            //       color: const Color.fromARGB(255, 226, 217, 217),
            //       borderRadius: BorderRadius.circular(10)),
            //   child: Column(
            //     children: [
            //       Padding(
            //         padding: const EdgeInsets.only(top: 8.0),
            //         child: Text(
            //           "Choose Your Language",
            //           style: GoogleFonts.dmSans(
            //               fontSize: 18,
            //               color: const Color.fromARGB(255, 1, 8, 44),
            //               fontWeight: FontWeight.w600),
            //         ),
            //       ),
            //       const SizedBox(
            //         height: 10,
            //       ),
            //       Container(
            //         height: 75,
            //         width: 250,
            //         child: SizedBox(
            //             width: 240,
            //             child: DropdownButtonFormField<String>(
            //               focusColor: Colors.white,
            //               decoration: InputDecoration(
            //                 enabledBorder: OutlineInputBorder(
            //                     borderRadius: BorderRadius.circular(12),
            //                     borderSide: const BorderSide(
            //                         width: 3,
            //                         color: Color.fromARGB(255, 0, 17, 73))),
            //               ),
            //               value: selectedItem,
            //               items: items
            //                   .map((e) => DropdownMenuItem(
            //                       value: e,
            //                       child: Text(
            //                         e,
            //                         style: GoogleFonts.dmSans(
            //                             fontSize: 18,
            //                             color: Color.fromARGB(255, 1, 8, 44),
            //                             fontWeight: FontWeight.w600),
            //                       )))
            //                   .toList(),
            //               onChanged: ((value) => setState(() {
            //                     selectedItem = value;
            //                     var locale = Locale(langList[value]![0],
            //                         langList[value]![1].toString());
            //                     Get.updateLocale(locale);
            //                   })),
            //             )),
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  Future<void> scanQrCode() async {
    try {
      // final qrCode = await FlutterBarcodeScanner.scanBarcode(
      //     '#00FBE3', 'Cancel', true, ScanMode.QR);
      if (!mounted) return;
      setState(() {
        // this.qrCode = qrCode;
      });
    } on PlatformException {
      qrCode = 'Failed to Scan OR';
    }
  }
}

class SearchMovies extends SearchDelegate<Movie> {
  List<Movie>? movies;
  SearchMovies(this.movies);
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, Movie());
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = movies!
        .where((element) =>
            element.title != null &&
            element.title
                .toString()
                .toLowerCase()
                .contains(query.toLowerCase()))
        .toList();
    return ListView.builder(
        itemCount: results.length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              close(context, results[index]);
            },
            title: Text(
              results[index].title.toString(),
              style: TextStyle(color: Colors.blue[300]),
            ),
          );
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final results = movies!
        .where((element) =>
            element.title != null &&
            element.title
                .toString()
                .toLowerCase()
                .contains(query.toLowerCase()))
        .toList();
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () {
            query = results[index].title.toString();
            Navigator.of(context).push(
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    ListenableProvider(
                  create: (context) => animation,
                  builder: (context, child) => Description(
                    id: results[index].id as int,
                    name: results[index].title ?? "Loading",
                    description: results[index].overview as String,
                    vote: results[index].voteAverage.toString(),
                    bannerurl:
                        'https://image.tmdb.org/t/p/w500/${results[index].backdropPath}',
                    posterurl:
                        'https://image.tmdb.org/t/p/w500/${results[index].posterPath}',
                    launchon: results[index].releaseDate.toString(),
                    movieImgUrl:
                        'https://image.tmdb.org/t/p/w500/${results[index].posterPath}',
                  ),
                ),
                transitionDuration: const Duration(milliseconds: 500),
              ),
            );
            close(context, results[index]);
          },
          title: Text(
            results[index].title.toString(),
          ),
        );
      },
    );
  }
}
