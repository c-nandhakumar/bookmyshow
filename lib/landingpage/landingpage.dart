import 'package:bookmyshow/landingpage/cardgeneration/carouselbuilder.dart';
import 'package:bookmyshow/landingpage/cardgeneration/gridview.dart';
import 'package:bookmyshow/landingpage/cardgeneration/homeicon.dart';
import 'package:bookmyshow/notifications/notification_page.dart';
import 'package:bookmyshow/provider/movielist_provider.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:bookmyshow/landingpage/pagebuilder/trendingtvshows.dart';
import 'package:bookmyshow/landingpage/pagebuilder/trending.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

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
    return Container(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 248, 245, 245),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 10, 21, 46),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                onPressed: () {},
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
              icon: const Icon(Icons.notifications_none_outlined),
              iconSize: 27,
            ),
            IconButton(
              onPressed: scanQrCode,
              icon: const Icon(Icons.qr_code),
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
                  "It All Starts Here".tr,
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
          padding: EdgeInsets.all(h! / 25),
          children: [
            //Text("CodingMart"),
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
            Container(
              color: Colors.red[400],
              padding: EdgeInsets.all(20),
              child: Text(
                'QR TEXT : ${qrCode}',
                textAlign: TextAlign.center,
              ),
            ),
            TextButton(
              onPressed: () => throw Exception(),
              child: const Text("Throw Test Exception"),
            ),
            Container(
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 226, 217, 217),
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      "Choose Your Language",
                      style: GoogleFonts.dmSans(
                          fontSize: 18,
                          color: const Color.fromARGB(255, 1, 8, 44),
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 75,
                    width: 250,
                    child: SizedBox(
                        width: 240,
                        child: DropdownButtonFormField<String>(
                          focusColor: Colors.white,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                    width: 3,
                                    color: Color.fromARGB(255, 0, 17, 73))),
                          ),
                          value: selectedItem,
                          items: items
                              .map((e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(
                                    e,
                                    style: GoogleFonts.dmSans(
                                        fontSize: 18,
                                        color: Color.fromARGB(255, 1, 8, 44),
                                        fontWeight: FontWeight.w600),
                                  )))
                              .toList(),
                          onChanged: ((value) => setState(() {
                                selectedItem = value;
                                var locale = Locale(langList[value]![0],
                                    langList[value]![1].toString());
                                Get.updateLocale(locale);
                              })),
                        )),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> scanQrCode() async {
    try {
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
          '#00FBE3', 'Cancel', true, ScanMode.QR);
      if (!mounted) return;
      setState(() {
        this.qrCode = qrCode;
      });
    } on PlatformException {
      qrCode = 'Failed to Scan OR';
    }
  }
}
