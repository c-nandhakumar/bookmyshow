import 'package:bookmyshow/landingpage/pagebuilder/descriptionpage/expandedtext.dart';
import 'package:bookmyshow/landingpage/pagebuilder/descriptionpage/ratingpage/ratingpage.dart';
import 'package:bookmyshow/landingpage/pagebuilder/descriptionpage/ticketbookingpage/screens/theatrelist_screen.dart';
import 'package:bookmyshow/unused/theatresPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class Description extends StatefulWidget {
  final String name,
      description,
      bannerurl,
      posterurl,
      vote,
      launchon,
      movieImgUrl;
  final int id;

  const Description(
      {super.key,
      required this.id,
      this.name = "Loading",
      required this.description,
      required this.bannerurl,
      required this.posterurl,
      required this.vote,
      required this.launchon,
      required this.movieImgUrl});

  @override
  State<Description> createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {
  @override
  Widget build(BuildContext context) {
    final animation = Provider.of<Animation<double>>(context, listen: false);
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1, 0),
            end: const Offset(0, 0),
          ).animate(
            CurvedAnimation(
              curve: const Interval(
                0,
                1,
                curve: Curves.easeOutCubic,
              ),
              parent: animation,
            ),
          ),
          child: child,
        );
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
              icon: const Icon(Icons.chevron_left, color: Colors.black87),
              onPressed: () => Navigator.of(context).pop()),
          title: Text(
            widget.name,
            style: TextStyle(color: Colors.black, fontSize: w * 0.04),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: w * 0.04),
              child: InkWell(
                onTap: () async {
                  await Share.share(
                      'https://www.youtube.com/watch?v=CNUBhb_cM6E');
                },
                child: const Icon(
                  Icons.share_outlined,
                  color: Colors.black,
                ),
              ),
            )
          ],
        ),
        body: Container(
          padding: EdgeInsets.all(w * 0.04),
          child: ListView(children: [
            Container(
              height: h * 0.26,
              child: Stack(children: [
                Positioned(
                  child: Container(
                    padding: EdgeInsets.only(bottom: w * 0.03),
                    // height: MediaQuery.of(context).size.height * 0.3,
                    width: MediaQuery.of(context).size.width,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(w * 0.02),
                        child: Image.network(
                          widget.bannerurl,
                          fit: BoxFit.cover,
                        )),
                  ),
                ),
              ]),
            ),
            Row(
              children: [
                const Icon(
                  Icons.favorite_rounded,
                  color: Colors.redAccent,
                ),
                SizedBox(
                  width: w * 0.02,
                ),
                Text(
                  "IMDb ${widget.vote}",
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ],
            ),
            SizedBox(
              height: h * 0.01,
            ),
            Container(
                padding: EdgeInsets.all(w * 0.03),
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(w * 0.02)),
                height: h * 0.075,
                child: Row(
                  children: [
                    Container(
                      // padding: EdgeInsets.all(w * 0.03),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Add your rating & review",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: w * 0.038),
                          ),
                          const Spacer(),
                          Text(
                            'Your ratings matter',
                            style: TextStyle(
                                color: Colors.grey, fontSize: w * 0.03),
                          )
                        ],
                      ),
                    ),
                    const Spacer(),
                    Container(
                      height: 36,
                      child: OutlinedButton(
                        onPressed: () {
                          (widget.name == "Loading")
                              ? ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text("Please try again later")))
                              : Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => RatingPage(
                                      widget.movieImgUrl, widget.name),
                                ));
                        },
                        style: OutlinedButton.styleFrom(
                            // primary: Colors.red[800],
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            side: const BorderSide(
                              color: Colors.red,
                              width: 2,
                            )),
                        child: Text(
                          "Rate now",
                          style:
                              TextStyle(color: Colors.red, fontSize: w * 0.03),
                        ),
                      ),
                    ),
                  ],
                )),
            ExpandedText(widget.description),
          ]),
        ),
        bottomNavigationBar: BottomAppBar(
          elevation: 2,
          child: Container(
            height: h * 0.06,
            padding: EdgeInsets.only(
                left: w * 0.03,
                right: w * 0.03,
                bottom: w * 0.02,
                top: w * 0.01),
            child: ElevatedButton(
              onPressed: () {
                (widget.name == "Loading")
                    ? ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Please try again later")))
                    : Navigator.of(context).push(PageRouteBuilder(
                        pageBuilder: (context, animation2, secondaryAnimation) {
                          return TheatreListScreen(
                              transitionAnimation: animation2,
                              imgUrl: widget.movieImgUrl,
                              movieName: widget.name);
                        },
                        transitionDuration: const Duration(milliseconds: 500)));
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 231, 48, 72)),
              child: Text(
                "Book tickets",
                style:
                    TextStyle(fontSize: w * 0.04, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
