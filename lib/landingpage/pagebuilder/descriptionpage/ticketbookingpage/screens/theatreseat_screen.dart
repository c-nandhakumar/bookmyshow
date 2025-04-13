import 'package:bookmyshow/landingpage/models/theatreseat_model.dart';
import 'package:bookmyshow/landingpage/pagebuilder/descriptionpage/ticketbookingpage/payment_screens/paymentbilling_screen.dart';
import 'package:bookmyshow/landingpage/pagebuilder/descriptionpage/ticketbookingpage/screens/seatcount.dart';
import 'package:bookmyshow/provider/theatreseat_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../bottomnavigation/bottomnavigator.dart';
import '../../../../../provider/date_provider.dart';
import '../../../../../provider/orders_provider.dart';
import '../../../../../provider/theatrelist_provider.dart';
import '../../../../../provider/tickets_provider.dart';

class TheatreSeatScreen extends StatefulWidget {
  String? theatreName;
  String? movieName;
  String? theatreId;
  String? imgUrl;
  TheatreSeats? obj;
  int id;
  String? date;
  String time;
  TheatreSeatScreen(
      {this.movieName,
      required this.id,
      required this.time,
      this.date,
      this.theatreId,
      this.theatreName,
      this.imgUrl,
      this.obj,
      Key? key})
      : super(key: key);

  @override
  State<TheatreSeatScreen> createState() => _TheatreSeatScreenState();
}

class _TheatreSeatScreenState extends State<TheatreSeatScreen>
    with TickerProviderStateMixin {
  List<Container> rows = [];
  bool isSelected = false;
  String vehicleImg = "";
  List<Map<int, bool>> selectedSeats =
      List.generate(5, (index) => {index: false});

  final TransformationController transformationController =
      TransformationController();
  Animation<Matrix4>? _animationReset;
  late final AnimationController _controllerReset;
  void _onAnimateReset() {
    transformationController.value = _animationReset!.value;
    if (!_controllerReset.isAnimating) {
      _animationReset!.removeListener(_onAnimateReset);
      _animationReset = null;
      _controllerReset.reset();
    }
  }

  void _animateResetInitialize() {
    _controllerReset.reset();
    final val = transformationController.value;
    const zoomFactor = 4.0;
    const xTranslate = 0.0;
    const yTranslate = -10.0;

    transformationController.value.setEntry(0, 0, zoomFactor);
    transformationController.value.setEntry(1, 1, zoomFactor);
    transformationController.value.setEntry(2, 2, zoomFactor);
    transformationController.value.setEntry(0, 3, -xTranslate);
    transformationController.value.setEntry(1, 3, -yTranslate);
    _controllerReset.forward();
  }

  void _animateResetStop() {
    _controllerReset.stop();
    _animationReset?.removeListener(_onAnimateReset);
    _animationReset = null;
    _controllerReset.reset();
  }

  void onInteractionStart() {
    if (_controllerReset.status == AnimationStatus.forward) {
      _animateResetStop();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    const zoomFactor = 4.0;
    const xTranslate = 0.0;
    const yTranslate = -10.0;

    transformationController.value.setEntry(0, 0, zoomFactor);
    transformationController.value.setEntry(1, 1, zoomFactor);
    transformationController.value.setEntry(2, 2, zoomFactor);
    transformationController.value.setEntry(0, 3, -xTranslate);
    transformationController.value.setEntry(1, 3, -yTranslate);
    super.initState();

    _controllerReset = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controllerReset.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String? date;
    int? dateindex = 0;
    final dateAndMonthList = Provider.of<DatesProvider>(context);
    final theatreList = Provider.of<TheatreList>(context);
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    Map<String, Object> dateAndDay = dateAndMonthList.dateList[dateindex];
    date =
        "${dateAndDay['day']}, ${dateAndDay['date']}  ${dateAndDay['month']}";
    List dateWidgets = dateAndMonthList.dateList.map(
      (data) {
        int index = dateAndMonthList.dateList.indexOf(data);

        return dateAndTimeCardGenerator(
            data, h, w, data['isDateSelected'] as bool, index);
      },
    ).toList();
    var theatre = theatreList.theatreList[0][0];
    final seatsProvider = Provider.of<TheatreSeatsList>(context);
    final ticket = Provider.of<TicketList>(context);

    final orders = Provider.of<OrdersList>(context);
    int theatreId = seatsProvider.theatreSeatsList
        .indexWhere((element) => element.theatreId == widget.theatreId);
    final seats = seatsProvider.theatreSeatsList[theatreId];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          // padding: EdgeInsets.all(10),
          color: Colors.white,
          icon: const Icon(Icons.chevron_left),
          onPressed: () {
            return Navigator.of(context).pop();
          },
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.movieName.toString(),
              style: const TextStyle(fontSize: 15, color: Colors.white),
            ),
            const SizedBox(
              height: 2.5,
            ),
            Text(
              widget.theatreName.toString(),
              style: const TextStyle(fontSize: 10, color: Colors.white),
            ),
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 6, 20, 32),
      ),
      body: Stack(
        children: [
          Positioned(
            child: Column(
              children: [
                Container(
                  height: 110,
                  width: w,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Text(widget.date.toString()),
                              ),
                              Spacer(),
                              Container(
                                //color: Colors.green,
                                height: 20,
                                // width: double.infinity,
                                // padding: const EdgeInsets.only(right: 20),
                                alignment: Alignment.centerRight,
                                child: InkWell(
                                  onTap: () {
                                    ticket.defaultImg();
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          SafeArea(
                                        child: Container(
                                          height: 350,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Flexible(
                                                child: Container(
                                                  height: 50,
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  child: const Text(
                                                    "How many seats? ",
                                                    style: TextStyle(
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                    textAlign: TextAlign.start,
                                                  ),
                                                ),
                                              ),
                                              Consumer<TicketList>(
                                                builder:
                                                    (context, value, child) {
                                                  return Container(
                                                      alignment:
                                                          Alignment.center,
                                                      height: 150,
                                                      child: SizedBox(
                                                        height: 150,
                                                        child: ticket.img,
                                                      ));
                                                },
                                              ),
                                              Flexible(
                                                child: Container(
                                                  height: 40,
                                                  width: double.infinity,
                                                  alignment: Alignment.center,
                                                  child: const SeatCount(),
                                                ),
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(20),
                                                child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        const Color.fromARGB(
                                                            255, 231, 48, 72),
                                                    minimumSize:
                                                        const Size.fromHeight(
                                                            40),
                                                  ),
                                                  onPressed: () {
                                                    ticket.selectSeats();
                                                    ticket.emptySeat();
                                                    seatsProvider
                                                        .refreshSeats();
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const Text(
                                                      "Select Seats"),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    height: 20,
                                    width: 80,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        const Icon(
                                          Icons.edit,
                                          color: Colors.red,
                                          size: 15,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          ticket.numberOfSeats == 1
                                              ? "${ticket.numberOfSeats} Ticket"
                                              : "${ticket.numberOfSeats} Tickets",
                                          textAlign: TextAlign.right,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: Colors.red),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ]),
                        const SizedBox(
                          height: 15,
                        ),
                        Flexible(
                          child: ListView.separated(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                // Theatre theatre =
                                //     theatreList.theatreList[index][0];
                                TimeList timeElement = theatre.timeList![index];
                                Color cardColor = timeElement.isFilled == true
                                    ? Colors.orange
                                    : Colors.green;
                                return Column(
                                  children: [
                                    Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 17),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Colors.grey,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(4)),
                                        child: Column(children: [
                                          Text(timeElement.time.toString(),
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w600,
                                                  color: cardColor)),
                                          timeElement.audioSystem != null
                                              ? Text(
                                                  timeElement.audioSystem
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontSize: 9,
                                                      color: cardColor),
                                                )
                                              : Container()
                                        ])),
                                    Spacer()
                                  ],
                                );
                              },
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                    width: 15,
                                  ),
                              itemCount: theatre.timeList!.length),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: InteractiveViewer(
                    minScale: 1,
                    maxScale: 10,
                    constrained: true,
                    onInteractionStart: (details) {
                      if (transformationController.value.getMaxScaleOnAxis() <=
                              3.5 ||
                          transformationController.value.getMaxScaleOnAxis() ==
                              1.0) {
                        _animateResetInitialize();
                      }
                      onInteractionStart();
                    },
                    transformationController: transformationController,
                    onInteractionEnd: (details) {
                      print(details);
                      print(transformationController.value.getMaxScaleOnAxis());
                      if (transformationController.value.getMaxScaleOnAxis() <=
                              3.5 ||
                          transformationController.value.getMaxScaleOnAxis() ==
                              1.0) {
                        _animateResetInitialize();
                      }
                    },
                    boundaryMargin:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                    child: Column(
                      // height: double.infinity,
                      children: List.generate(
                        seats.seatList.length,
                        (index) => seats.seatList[index].seat.isEmpty
                            ? const SizedBox(
                                height: 5,
                                width: double.infinity,
                              )
                            : Row(children: [
                                SizedBox(
                                  height: 5,
                                  width: 5,
                                  child: Center(
                                      child: Text(
                                    seats.seatList[index].seat[0].seatNo[0],
                                    style: const TextStyle(fontSize: 2.5),
                                  )),
                                ),
                                ...seatLayoutBuilder(index, seatsProvider,
                                    theatreId, seats.seatList[index], ticket),
                              ]),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          AnimatedPositioned(
              curve: Curves.easeInOutCirc,
              bottom: ticket.numberOfSeats == ticket.seatsFilled ? 0 : -50,
              duration: Duration(milliseconds: 700),
              child: Column(
                children: [
                  Container(
                    color: Colors.white,
                    height: 40,
                    width: w,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              Container(
                                height: 15,
                                width: 15,
                                decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(2.5)),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text(
                                "Sold",
                                style: TextStyle(fontSize: 12),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                height: 15,
                                width: 15,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        width: 1, color: Colors.green),
                                    borderRadius: BorderRadius.circular(2.5)),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text(
                                "Available",
                                style: TextStyle(fontSize: 12),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                height: 15,
                                width: 15,
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(2.5)),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text(
                                "Selected",
                                style: TextStyle(fontSize: 12),
                              )
                            ],
                          ),
                        ]),
                  ),
                  Container(
                    color: Colors.white,
                    height: 50,
                    width: w,
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              ticket.numberOfSeats == ticket.seatsFilled
                                  ? Color.fromARGB(255, 231, 48, 72)
                                  : Colors.grey[400]),
                      onPressed: () {
                        if (ticket.numberOfSeats == ticket.seatsFilled) {
                          orders.addOrder(
                              widget.imgUrl,
                              widget.theatreName,
                              widget.date,
                              widget.movieName,
                              widget.time,
                              ticket.seats);
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const BillingScreen(),
                          ));
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Please select the seats"),
                          ));
                        }
                        return;
                      },
                      child: const Text("Pay ₹ 492.90"),
                    ),
                  ),
                ],
              ))
        ],
      ),
      /* bottomNavigationBar: BottomAppBar(
        child: Container(
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: ticket.numberOfSeats == ticket.seatsFilled
                    ? Colors.green
                    : Colors.grey[400]),
            onPressed: () {
              if (ticket.numberOfSeats == ticket.seatsFilled) {
                orders.addOrder(widget.imgUrl, widget.theatreName, widget.date,
                    widget.movieName, widget.time, ticket.seats);
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const BillingScreen(),
                ));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Please select the seats"),
                ));
              }
              return;
            },
            child: const Text("Confirm seats"),
          ),
        ),
      ),*/
    );
  }

  seatLayoutBuilder(int i, TheatreSeatsList seatsProvider, int theatreId,
      SeatList e, TicketList ticket) {
    return List.generate(
      e.seat.length,
      (index) => e.seat[index].seatId.toString() != '-1'
          ? GestureDetector(
              onTap: () {
                final seatNo = e.seat[index].seatNo;
                if (ticket.seatsFilled < ticket.numberOfSeats &&
                    seatsProvider.theatreSeatsList[theatreId].seatList[i]
                            .seat[index].isSelected ==
                        false &&
                    seatsProvider.theatreSeatsList[theatreId].seatList[i]
                            .seat[index].isOccupied ==
                        false) {
                  ticket.addSeats(e.seat[index].seatNo);
                  seatsProvider.selectSeats(i, index, theatreId, seatNo);
                  seatsProvider.theatreSeatsList[theatreId].seatList[i]
                      .seat[index].isSelected = true;
                  //e[index].isSelected = true;
                  ticket.fillSeat();
                } else if (ticket.numberOfSeats > ticket.seatsFilled &&
                    seatsProvider.theatreSeatsList[theatreId].seatList[i]
                            .seat[index].isSelected ==
                        true &&
                    seatsProvider.theatreSeatsList[theatreId].seatList[i]
                            .seat[index].isOccupied ==
                        false) {
                  //for removing the seats in the list
                  ticket.removeSeats(seatNo);
                  seatsProvider.removeSeats(i, index, theatreId, seatNo);
                  //e[index].isSelected = false;
                  //subtracting the seat count
                  ticket.removeSeat();
                } else if (ticket.numberOfSeats == ticket.seatsFilled &&
                    seatsProvider.theatreSeatsList[theatreId].seatList[i]
                            .seat[index].isOccupied ==
                        false) {
                  ticket.refreshSeats();
                  ticket.addSeats(seatNo);
                  ticket.fillSeat();
                  seatsProvider.refreshSeats();
                  seatsProvider.selectSeats(i, index, theatreId, seatNo);
                  //ScaffoldMessenger.of(context).showSnackBar(
                  //  const SnackBar(content: Text("Seats filled !")));
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(0.50),
                child: Container(
                  height: 5,
                  width: 5,
                  decoration: BoxDecoration(
                      color: seatsProvider.theatreSeatsList[theatreId]
                                  .seatList[i].seat[index].isOccupied ==
                              true
                          ? Colors.grey
                          : (seatsProvider.theatreSeatsList[theatreId]
                                      .seatList[i].seat[index].isSelected ==
                                  true
                              ? Colors.green
                              : Colors.white),
                      border: Border.all(
                          color: seatsProvider.theatreSeatsList[theatreId]
                                      .seatList[i].seat[index].isOccupied ==
                                  true
                              ? Colors.grey
                              : Colors.green,
                          width: 0.25),
                      borderRadius: BorderRadius.circular(0.5)),
                  child: Center(
                    child: Text(
                      e.seat[index].seatId.toString(),
                      style: TextStyle(
                          color: seatsProvider.theatreSeatsList[theatreId]
                                      .seatList[i].seat[index].isSelected ==
                                  false
                              ? Colors.grey
                              : Colors.white,
                          fontSize: 2.5,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            )
          : const Padding(
              padding: EdgeInsets.all(0.50),
              child: SizedBox(
                height: 5,
                width: 5,
              ),
            ),
    );
  }
}

dateAndTimeCardGenerator(
    Map<String, Object> e, double h, double w, bool isSelected, int index) {
  return Padding(
    padding: EdgeInsets.all(w * 0.02),
    child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
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
