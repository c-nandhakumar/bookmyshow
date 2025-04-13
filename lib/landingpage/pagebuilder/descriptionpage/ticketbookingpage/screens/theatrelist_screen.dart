import 'package:bookmyshow/landingpage/models/theatreseat_model.dart'
    as theatreseat;
import 'package:bookmyshow/landingpage/pagebuilder/descriptionpage/ticketbookingpage/screens/seatingpage.dart';
import 'package:bookmyshow/landingpage/pagebuilder/descriptionpage/ticketbookingpage/screens/theatreseat_screen.dart';
import 'package:bookmyshow/widgets/testfile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../provider/theatrelist_provider.dart';
import '../../../../../provider/date_provider.dart';
import '../../../../../unused/seatssamp.dart';
import '../../../../services/theatreseat_service.dart';

class TheatreListScreen extends StatefulWidget {
  String? movieName;
  String? imgUrl;
  final Animation<double>? transitionAnimation;
  TheatreListScreen(
      {Key? key, this.transitionAnimation, this.imgUrl, this.movieName})
      : super(key: key);

  @override
  State<TheatreListScreen> createState() => _TheatreListScreenState();
}

class _TheatreListScreenState extends State<TheatreListScreen> {
  int? isDateSelected = 0;
  String? date;
  PageController pageController = PageController();
  int? dateindex = 0;
  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  //get index => isDateSelected;
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    final dateAndMonthList = Provider.of<DatesProvider>(context);
    final theatreList = Provider.of<TheatreList>(context);
    final theatreSeatInstance = Provider.of<TheatreSeatService>(context);
    Map<String, Object> dateAndDay = dateAndMonthList.dateList[dateindex!];
    date =
        "${dateAndDay['day']}, ${dateAndDay['date']}  ${dateAndDay['month']}";
    List dateWidgets = dateAndMonthList.dateList.map(
      (data) {
        int index = dateAndMonthList.dateList.indexOf(data);

        return dateAndTimeCardGenerator(
            data, h, w, data['isDateSelected'] as bool, index);
      },
    ).toList();
    print(date);

    void changeDateIndex(int i) {
      setState(() {
        isDateSelected = i;
        dateindex = i;

        // pageController.animateToPage(i,
        //     duration: const Duration(seconds: 1), curve: Curves.easeInOut);
        pageController.jumpToPage(i);
      });
    }

    return AnimatedBuilder(
      animation: widget.transitionAnimation!,
      builder: (context, child) {
        return SlideTransition(
            position: Tween<Offset>(begin: Offset(1, 0), end: Offset(0, 0))
                .animate(CurvedAnimation(
                    parent: widget.transitionAnimation!,
                    curve: Curves.easeInOut)),
            child: child);
      },
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          title: Text(
            widget.movieName.toString(),
            style: const TextStyle(fontSize: 15),
          ),
          actions: [],
          leading: IconButton(
              icon: Icon(Icons.chevron_left),
              onPressed: () => Navigator.of(context).pop()),
        ),
        body: Container(
          child: Column(
            children: [
              Container(
                color: Colors.white,
                height: h * 0.10,
                child: ListView.builder(
                  //shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: dateWidgets.length,
                  itemBuilder: (context, index) => (Container(
                      color: isDateSelected != null && isDateSelected == index
                          ? Colors.red[700]
                          : Colors.white,
                      height: h * 0.1,
                      width: w * 0.142,
                      child: InkWell(
                          onTap: () {
                            changeDateIndex(index);
                          },
                          child: dateWidgets[index]))),
                ),
              ),
              const Divider(height: 1),
              Container(
                height: h * 0.057,
                width: double.infinity,
                color: Colors.white,
                padding: EdgeInsets.only(left: w * 0.03),
                child: Row(
                  children: [
                    Text(
                      "English",
                      style: TextStyle(
                          fontWeight: FontWeight.w600, fontSize: w * 0.03),
                    ),
                    SizedBox(width: w * 0.02),
                    Icon(
                      Icons.circle,
                      size: w * 0.01,
                    ),
                    SizedBox(width: w * 0.02),
                    Text(
                      "2D",
                      style: TextStyle(
                          fontWeight: FontWeight.w600, fontSize: w * 0.03),
                    ),
                  ],
                ),
              ),
              Flexible(
                child: PageView.builder(
                  onPageChanged: (value) {
                    changeDateIndex(value);
                  },
                  controller: pageController,
                  itemCount: theatreList.theatreList.length,
                  scrollDirection: Axis.horizontal,
                  physics: const ScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 15,
                            ),
                            Container(
                              color: Colors.white,
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: const ScrollPhysics(),
                                  itemCount: theatreList
                                      .theatreList[isDateSelected!].length,
                                  itemBuilder: (context, i) {
                                    Theatre theatre =
                                        theatreList.theatreList[index][i];

                                    int addHeight =
                                        theatre.isCancellationAvailable == true
                                            ? 20
                                            : 0;
                                    return Container(
                                      padding: const EdgeInsets.all(20),
                                      height: 80 +
                                          addHeight +
                                          ((theatre.timeList!.length / 3)
                                                  .ceil() *
                                              57),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Padding(
                                                padding:
                                                    EdgeInsets.only(top: 2),
                                                child: Icon(
                                                  Icons
                                                      .favorite_border_outlined,
                                                  size: 15,
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Container(
                                                width: w * 0.78,
                                                child: Text(
                                                  theatre.theatreName
                                                      .toString(),
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 5),
                                          theatre.isCancellationAvailable ==
                                                  true
                                              ? const Text(
                                                  "Cancellation Available",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.grey),
                                                )
                                              : Container(),
                                          const SizedBox(height: 10),
                                          Expanded(
                                            child: GridView.count(
                                              shrinkWrap: true,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              crossAxisSpacing: 15,
                                              mainAxisSpacing: 20,
                                              childAspectRatio: 2.25,
                                              crossAxisCount: 3,
                                              children: List.generate(
                                                  theatre.timeList!.length,
                                                  (index) {
                                                TimeList timeElement =
                                                    theatre.timeList![index];
                                                Color cardColor =
                                                    timeElement.isFilled == true
                                                        ? Colors.orange
                                                        : Colors.green;
                                                return GestureDetector(
                                                  onTap: () async {
                                                    print(timeElement.time);
                                                    // ignore: unnecessary_null_comparison
                                                    // ignore: unrelated_type_equality_checks
                                                    bool y =
                                                        await theatreSeatInstance
                                                            .readTheatreInstances(
                                                                date as String,
                                                                timeElement.time
                                                                    .toString(),
                                                                theatre.theatreId
                                                                    as String);
                                                    if (y == true) {
                                                      print("true");
                                                    } else {
                                                      await theatreSeatInstance
                                                          .createTheatreInstance(
                                                              date as String,
                                                              timeElement.time
                                                                  .toString(),
                                                              theatre.theatreId
                                                                  as String);
                                                    }

                                                    Navigator.of(context)
                                                        .push(MaterialPageRoute(
                                                      builder: (context) =>
                                                          TheatreSeatScreen(
                                                              date: date,
                                                              id: index,
                                                              time: timeElement
                                                                  .time
                                                                  .toString(),
                                                              imgUrl:
                                                                  widget.imgUrl,
                                                              movieName: widget
                                                                  .movieName,
                                                              theatreName: theatre
                                                                  .theatreName,
                                                              theatreId: theatre
                                                                  .theatreId,
                                                              obj:
                                                                  theatreSeatInstance
                                                                      .obj),
                                                    ));
                                                  },
                                                  child: Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 5,
                                                        horizontal: 10),
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                          color: Colors.grey,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4)),
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                            timeElement.time
                                                                .toString(),
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color:
                                                                    cardColor)),
                                                        timeElement.audioSystem !=
                                                                null
                                                            ? Text(
                                                                timeElement
                                                                    .audioSystem
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    fontSize: 9,
                                                                    color:
                                                                        cardColor),
                                                              )
                                                            : Container(),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              }),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  dateAndTimeCardGenerator(
      Map<String, Object> e, double h, double w, bool isSelected, int index) {
    return Padding(
      padding: EdgeInsets.all(w * 0.02),
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(
          e['day'].toString().toUpperCase(),
          style: const TextStyle(color: Colors.black87),
        ),
        Text(
          e['date'].toString(),
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(
          e['month'].toString().toUpperCase(),
          style: const TextStyle(color: Colors.grey),
        )
      ]),
    );
  }
}
