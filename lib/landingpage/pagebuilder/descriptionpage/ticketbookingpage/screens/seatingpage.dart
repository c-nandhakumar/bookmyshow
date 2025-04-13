import 'package:bookmyshow/landingpage/landingpage.dart';
import 'package:bookmyshow/landingpage/pagebuilder/descriptionpage/ticketbookingpage/payment_screens/paymentbilling_screen.dart';
import 'package:bookmyshow/landingpage/pagebuilder/descriptionpage/ticketbookingpage/screens/seatcount.dart';
import 'package:bookmyshow/provider/orders_provider.dart';
import 'package:bookmyshow/provider/tickets_provider.dart';
import 'package:flutter/material.dart';

import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:provider/provider.dart';

import '../../../../../bottomnavigation/bottomnavigator.dart';

class SeatingPage extends StatefulWidget {
  String? theatreName;
  String? imgUrl;
  String? movieName;
  int id;
  String? date;
  String time;
  SeatingPage(
      {Key? key,
      this.imgUrl,
      this.theatreName,
      this.date,
      this.movieName,
      required this.time,
      required this.id})
      : super(key: key);

  @override
  State<SeatingPage> createState() => _SeatingPageState();
}

class _SeatingPageState extends State<SeatingPage>
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
    const xTranslate = 450.0;
    const yTranslate = 0.0;

    transformationController.value.setEntry(0, 0, zoomFactor);
    transformationController.value.setEntry(1, 1, zoomFactor);
    transformationController.value.setEntry(2, 2, zoomFactor);
    transformationController.value.setEntry(0, 3, -xTranslate);
    transformationController.value.setEntry(1, 3, -yTranslate);

    // _animationReset = Matrix4Tween(
    //         begin: val,
    //         end: Matrix4(1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1)
    //           ..scale(2, 2))
    //     .animate(_controllerReset);

    // _animationReset = Matrix4Tween(begin: val, end: Matrix4.identity())
    //     .animate(_controllerReset);
    //_animationReset!.addListener(_onAnimateReset);
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
    const xTranslate = 450.0;
    const yTranslate = 0.0;

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
  void dispose() {
    _controllerReset.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ticket = Provider.of<TicketList>(context);
    final orders = Provider.of<OrdersList>(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
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
              style: const TextStyle(fontSize: 15),
            ),
            Text(
              widget.theatreName.toString(),
              style: const TextStyle(fontSize: 10),
            ),
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 6, 20, 32),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              height: 30,
              padding: const EdgeInsets.only(right: 20),
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) => SafeArea(
                      child: Container(
                        height: 350,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                              child: Container(
                                height: 50,
                                padding: const EdgeInsets.all(10),
                                child: const Text(
                                  "How many seats? ",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            ),
                            Consumer<TicketList>(
                              builder: (context, value, child) {
                                return Container(
                                    alignment: Alignment.center,
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
                                child: SeatCount(),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(20),
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        const Color.fromARGB(255, 231, 48, 72),
                                    minimumSize: const Size.fromHeight(40),
                                  ),
                                  onPressed: () {
                                    ticket.selectSeats();
                                    ticket.emptySeat();
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text("Select Seats")),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
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
                          fontWeight: FontWeight.w600, color: Colors.red),
                    ),
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
                    // mainAxisAlignment: MainAxisAlignment.start,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(child: seatsBuilder(22, 22, ticket)),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        // width: double.infinity,
                        width: 70,
                        child: const Image(
                          image: AssetImage("assets/seats/theatrescreen.png"),
                          height: 5,
                          // alignment: Alignment.centerLeft,
                          //alignment: Alignment.center,
                        ),
                      )
                    ]),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: ticket.numberOfSeats == ticket.seatsFilled
                    ? Colors.green
                    : Colors.grey[400]),
            onPressed: () {
              orders.addOrder(widget.imgUrl, widget.theatreName, widget.date,
                  widget.movieName, widget.time, ticket.seats);
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => BillingScreen(),
              ));
            },
            child: const Text("Confirm seats"),
          ),
        ),
      ),
    );
  }

  Widget seatsBuilder(int column, int row, TicketList ticket) {
    return Column(
      //  mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,

      children: [
        ...List.generate(column, (index) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
                row,
                (i) => (index == 5 || index == 8)
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 5,
                          ),
                          seatsGenerator(ticket, index, i),
                        ],
                      )
                    : Row(
                        children: [
                          SizedBox(
                            width: (i == 7 || i == 14) ? 12 : 0,
                          ),
                          seatsGenerator(ticket, index, i),
                        ],
                      )),
          );
        }),
      ].toList(),
    );
  }

  Widget seatsGenerator(TicketList ticket, int index, int i) {
    return i == 0
        ? Padding(
            padding: const EdgeInsets.all(0.5),
            child: Container(
              height: 5,
              width: 5,
              child: Center(
                child: Text(
                  String.fromCharCode(65 + index),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 3),
                ),
              ),
            ),
          )
        : GestureDetector(
            onTap: () {
              String seatID = "${String.fromCharCode(65 + index)}$i";
              if (ticket.selectedSeats[index][i][seatID] == false &&
                  ticket.numberOfSeats > ticket.seatsFilled) {
                //adding seat id
                ticket.addSeats(seatID);
                //for changing color
                ticket.selectedSeats[index][i][seatID] = true;
                //adding seat count
                ticket.fillSeat();
              } else if (ticket.numberOfSeats > ticket.seatsFilled) {
                print(ticket.selectedSeats[index][i][seatID]);
                //for removing the color
                ticket.selectedSeats[index][i][seatID] = false;
                //for removing the seats in the list
                ticket.removeSeats(seatID);
                //subtracting the seat count
                ticket.removeSeat();
              } else if (ticket.numberOfSeats == ticket.seatsFilled) {
                //changing the  seats once it is filled
                ticket.refreshSeats();
                ticket.addSeats(seatID);
                ticket.fillSeat();
                ticket.selectedSeats[index][i][seatID] = true;
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Seats filled !"),
                ));
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(0.5),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(0.5),
                  border: Border.all(
                      width: 0.25,
                      color: ticket.selectedSeats[index][i]
                                  ["${String.fromCharCode(65 + index)}$i"] ==
                              true
                          ? Colors.green
                          : Colors.green),
                  color: ticket.selectedSeats[index][i]
                              ["${String.fromCharCode(65 + index)}$i"] ==
                          true
                      ? Colors.green
                      : Colors.white,
                ),
                height: 5,
                width: 5,
                child: Center(
                  child: Text(
                    i.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 2.5,
                      fontWeight: FontWeight.w600,
                      color: ticket.selectedSeats[index][i]
                                  ["${String.fromCharCode(65 + index)}$i"] ==
                              true
                          ? Colors.white
                          : Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
          );
  }

  void _transformController() {
    setState(() {});
  }
}
