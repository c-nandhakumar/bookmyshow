import 'package:bookmyshow/bottomnavigation/bottomnavigator.dart';
import 'package:bookmyshow/landingpage/landingpage.dart';
import 'package:bookmyshow/provider/orders_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({Key? key}) : super(key: key);

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final orders = Provider.of<OrdersList>(context);
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text("Your Orders"),
        leading: IconButton(
          icon: Icon(Icons.chevron_left),
          onPressed: () {
            // Navigator.of(context).pushReplacement(MaterialPageRoute(
            //   builder: (context) => BottomNavigation(),
            // ));
            Navigator.of(context).pop();
          },
        ),
      ),
      body: orders.ordersList.isEmpty
          ? const Center(
              child: Text("No New Orders"),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.separated(
                separatorBuilder: (context, index) => SizedBox(height: 15),
                itemCount: orders.ordersList.length,
                itemBuilder: (context, index) => Stack(children: [
                  Container(
                    height: 220,
                    width: size.width,
                    child: CustomPaint(
                      size: Size(size.width, 200),
                      painter: TicketPainter(),
                    ),
                  ),
                  Container(
                    height: 220,
                    child: Column(children: [
                      Container(
                        height: 145,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.all(17),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: Image(
                                      height: 120,
                                      image: NetworkImage(orders
                                          .ordersList[index].imgUrl
                                          .toString())),
                                ),
                              ),
                            ),
                            Flexible(
                              child: Container(
                                // height: 140,
                                padding: EdgeInsets.all(20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      "${orders.ordersList[index].movieName}",
                                      style: const TextStyle(
                                          color: Colors.black87,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Flexible(
                                      child: Row(children: [
                                        Text(
                                          "${orders.ordersList[index].date}",
                                          style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 85, 85, 85),
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14),
                                        ),
                                        const Spacer(),
                                        Text(
                                            "${orders.ordersList[index].timeSlot}",
                                            style: const TextStyle(
                                                color: Color.fromARGB(
                                                    255, 85, 85, 85),
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14))
                                      ]),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                        "${orders.ordersList[index].theatreName}",
                                        style: const TextStyle(
                                            color:
                                                Color.fromARGB(255, 85, 85, 85),
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14)),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        indent: 15,
                        height: 10,
                        thickness: 1,
                        endIndent: 15,
                      ),
                      Flexible(
                        child: Row(children: [
                          Flexible(
                            flex: 1,
                            child: Container(
                              width: size.width / 3,
                              // color: Colors.blue,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "${orders.ordersList[index].seats!.length}",
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  orders.ordersList[index].seats!.length == 1
                                      ? const Text(
                                          "Ticket",
                                          style:
                                              TextStyle(color: Colors.black54),
                                        )
                                      : const Text("Tickets",
                                          style:
                                              TextStyle(color: Colors.black54))
                                ],
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 2,
                            child: Container(
                              width: size.width - size.width / 3,
                              //color: Colors.green,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  orders.ordersList.length == 1
                                      ? const Text(
                                          "SEAT",
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 10),
                                        )
                                      : const Text(
                                          "SEATS",
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 10),
                                        ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: List.generate(
                                        orders.ordersList[index].seats!.length,
                                        (i) => Text(
                                              i <
                                                      orders.ordersList[index]
                                                              .seats!.length -
                                                          1
                                                  ? "${orders.ordersList[index].seats![i]},"
                                                  : orders.ordersList[index]
                                                      .seats![i],
                                              style: const TextStyle(
                                                  color: Colors.black87,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500),
                                            )),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ]),
                      )
                    ]),
                  ),
                  Positioned(
                    right: 0,
                    child: IconButton(
                      icon: const Icon(Icons.cancel_rounded),
                      color: Colors.grey[400],
                      onPressed: () {
                        TextButton cancelButton = TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text("NO",
                              style: TextStyle(color: Colors.red)),
                        );
                        TextButton continueButton = TextButton(
                          onPressed: () {
                            orders.removeFromOrdersList(index);
                            Navigator.of(context).pop();
                          },
                          child: const Text("YES",
                              style: TextStyle(color: Colors.green)),
                        );

                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                title: const Text("Cancel Tickets "),
                                content: const Text(
                                    "Do you really want to cancel your tickets ?"),
                                actions: [cancelButton, continueButton]));
                      },
                    ),
                  )
                ]),
              ),
            ),
    );
  }
}

class TicketPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    Path path = Path()..moveTo(0, 0);
    path.lineTo(0, 140);
    path.arcToPoint(Offset(0, 160), radius: Radius.circular(10));
    path.lineTo(0, 220);
    path.lineTo(size.width, 220);
    path.lineTo(size.width, 160);
    path.arcToPoint(Offset(size.width, 140), radius: Radius.circular(10));
    path.lineTo(size.width, 0);
    canvas.drawShadow(path, Color.fromARGB(139, 139, 134, 134), 5, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
