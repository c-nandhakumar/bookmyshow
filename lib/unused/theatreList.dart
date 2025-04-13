// import 'package:bookmyshow/bottomnavigation/bottomnavigator.dart';
import 'package:bookmyshow/landingpage/pagebuilder/descriptionpage/ticketbookingpage/screens/seatingpage.dart';
import 'package:flutter/material.dart';

// import '../theatresPage.dart';

class TheatreList {
  final String? theatreName;
  final String? date;
  final String? offers;
  final bool? cancellationAvailable;
  List<String> timeList;
  TheatreList(
      {this.theatreName,
      this.date,
      this.offers,
      this.cancellationAvailable,
      required this.timeList});
}

List timeList = [];

List<TheatreList> theatreLists = [
  TheatreList(
      theatreName: "Murugan Cinemas A/C 4K Atmos: Thudiyalur",
      offers: "5% off for Superstars | Use code: STAR5",
      cancellationAvailable: false,
      timeList: ["10:30 AM", "02:30 PM", "06:30 PM", "10:00 PM"]),
  TheatreList(
    theatreName: "SPI: The Cinema, Brookefields Mall",
    cancellationAvailable: true,
    timeList: [
      "11:10 AM",
      "11:30 AM",
      "02:50 PM",
      '03:10 PM',
      '06:25 PM',
      '06:45 PM'
    ],
  ),
  TheatreList(
    theatreName: "Karpagam Theatres 4K Dolby Atmos: Coimbatore",
    timeList: ["10:30 AM", "02:30 PM", "06:30 PM", "10:00 PM", '10:20 PM'],
  ),
  TheatreList(
    theatreName: "SPI: The Cinema, Brookefields Mall",
    cancellationAvailable: true,
    timeList: [
      "10:30 AM",
      "02:30 PM",
      "06:30 PM",
    ],
  ),
];

class TheatreLists extends StatefulWidget {
  final String? movieName;
  final String? imgUrl;
  final String? date;
  // ignore: use_key_in_widget_constructors
  const TheatreLists({this.imgUrl, this.date, this.movieName});

  @override
  State<TheatreLists> createState() => _TheatreListState();
}

class _TheatreListState extends State<TheatreLists> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Container(
      //color: Colors.blue,
      padding: EdgeInsets.all(w * 0.03),
      child: ListView.builder(
        itemCount: theatreLists.length,
        itemBuilder: (context, index) {
          return theatreCardGenerator(
              theatreLists[index], h, w, index, context);
        },
      ),
    );
  }

  Widget theatreCardGenerator(TheatreList theatreList, double h, double w,
      int index, BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(w * 0.03),
      height: h * 0.3,
      width: double.infinity,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        theatreList.theatreName.toString().length <= 70
            ? Container(
                height: h * 0.05,
                width: w * 0.9,
                child: Row(
                  children: [
                    Icon(
                      Icons.favorite_border_outlined,
                      size: w * 0.04,
                    ),
                    SizedBox(
                      width: w * 0.02,
                    ),
                    Container(
                      height: h * 0.02,
                      width: w * 0.75,
                      child: Text(
                        theatreList.theatreName.toString(),
                        maxLines: 2,
                        softWrap: true,
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, color: Colors.black87),
                      ),
                    )
                  ],
                ),
              )
            : Container(
                height: h * 0.225,
                child: Row(
                  children: [
                    Icon(
                      Icons.favorite_border_outlined,
                      size: w * 0.04,
                    ),
                    SizedBox(
                      width: w * 0.02,
                    ),
                    Container(
                      height: h * 0.1,
                      width: w * 0.75,
                      child: Text(
                        theatreList.theatreName.toString(),
                        maxLines: 2,
                        softWrap: true,
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, color: Colors.black87),
                      ),
                    )
                  ],
                ),
              ),
        SizedBox(
          height: h * 0.01,
        ),
        theatreList.cancellationAvailable == true
            ? Text(
                "Cancellation Available",
                style: TextStyle(fontSize: w * 0.03),
              )
            : const Text(""),
        const SizedBox(
          height: 10,
        ),
        Container(
          height: 120,
          child: GridView.count(
            physics: const ScrollPhysics(),
            crossAxisCount: 3,
            crossAxisSpacing: 10,
            childAspectRatio: 2,
            mainAxisSpacing: 10,

            //shrinkWrap: true,
            children: [
              ...theatreList.timeList
                  .map(
                    (e) => OutlinedButton(
                      onPressed: () {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          isDismissible: true,
                          backgroundColor: Colors.transparent,
                          context: context,
                          builder: (context) {
                            return DraggableScrollableSheet(
                              initialChildSize: 0.68,
                              minChildSize: 0.4,
                              maxChildSize: 0.68,
                              builder: (context, scrollController) => Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(w * 0.035)),
                                ),
                                child: ListView(
                                  controller: scrollController,
                                  children: [
                                    Container(
                                        height: 10,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.vertical(
                                                top: Radius.circular(
                                                    w * 0.035))),
                                        child: Container(
                                          height: 6,
                                          width: 30,
                                          child: const Image(
                                            image: AssetImage(
                                                'assets/icons/grey-rounded-button.jpg'),
                                            fit: BoxFit.fitHeight,
                                            height: 4,
                                            width: 30,
                                          ),
                                        )),
                                    Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.all(w * 0.035),
                                      child: Text(
                                        "Terms & Conditions",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: w * 0.05),
                                      ),
                                    ),
                                    SizedBox(
                                      height: h * 0.01,
                                    ),
                                    Container(
                                      height: h * 0.50,
                                      padding: EdgeInsets.all(w * 0.025),
                                      width: double.infinity,
                                      child: ListView(
                                          controller: scrollController,
                                          children: const [
                                            Text(
                                                "Kindly check your showtimes while booking as there are mid-night shows available as well.\nTicket price inclusive of 3D glass charges.\n1.As per the State Government Guidelines, In order to enter the cinema, It is mandatory to have Covid 19 Vaccine (One dose at least), for patrons above 18 years old. Vaccination certificate will be verified at the cinema entry, no entry will be permitted for non-vaccinated patrons and tickets will not be refunded\n2.Tickets once purchased cannot be cancelled, exchanged or refunded.\n3.Tickets purchased online are not eligible for discounts, schemes or promotions of any kind.\n4.To collect tickets from the Box Office, it is mandatory for the cardholder to be present in person with the card used for the transaction, along with the booking confirmation (SMS/computer printout) to help minimize the risk of fraud.\n5.Online bookings on our site are carried out over a secure payment gateway.\n6.Tickets purchased online for a particular multiplex are valid for that multiplex only.\n7.Children below the age of 18 cannot be admitted for movies certified `A`.\n8.Please carry proof of age for movies certified 'A'\n9.Please purchase tickets for children 3 years and above.\n10.To counter unforeseen delays, please collect your tickets half an hour before show time.\n11.Outside food and beverages are not allowed inside the cinema premises.\n12.A convenience fee per ticket is levied on all tickets booked online.\n13.Ticket holders are required to abide by the policies laid down by the AGS Cinemas management.\n14.Smoking is strictly prohibited inside the theatre premises.\n15.People under the influence of Alcohol/Drugs will not be allowed inside the cinema premises."),
                                          ]),
                                    ),
                                    Container(
                                      height: h * 0.0725,
                                      padding: EdgeInsets.all(w * 0.02),
                                      child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) => SeatingPage(
                                                imgUrl: widget.imgUrl,
                                                date: widget.date,
                                                movieName: widget.movieName,
                                                theatreName: theatreList
                                                    .theatreName
                                                    .toString(),
                                                time: e,
                                                id: index,
                                              ),
                                            ),
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                              
                                          backgroundColor: const Color.fromARGB(
                                              255, 231, 48, 72),
                                          minimumSize:
                                              const Size.fromHeight(50),
                                        ),
                                        child: Text(
                                          "Okay",
                                          style: TextStyle(
                                              fontSize: w * 0.04,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(w * 0.02)),
                        side: const BorderSide(
                          color: Colors.black54,
                          width: 1,
                        ),
                      ),
                      child: Text(
                        e,
                        style: TextStyle(
                            fontSize: w * 0.035, fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                  .toList()
            ],
          ),
        )
      ]),
    );
  }
}
