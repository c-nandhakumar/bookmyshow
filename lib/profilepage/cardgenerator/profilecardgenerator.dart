import 'package:bookmyshow/profilepage/cardgenerator/screens/orders_screen.dart';
import 'package:flutter/material.dart';
import './profilecarddetails.dart';

class ProfileCard extends StatefulWidget {
  const ProfileCard({Key? key}) : super(key: key);

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return ListView(
      physics: ScrollPhysics(),
      children: [
        SizedBox(
          height: 10,
        ),
        ListView.builder(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: card2.length,
            itemBuilder: (BuildContext context, int index) {
              return CardGenerator(card2[index]);
            }),
        SizedBox(
          height: 10,
        ),
        ListView.builder(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: cards.length,
            itemBuilder: (BuildContext context, int index) {
              return CardGenerator(
                cards[index],
                key: ValueKey(cards[index].text),
              );
            }),
        Container(
          height: height * 0.20,
        )
      ],
    );
  }
}

class CardGenerator extends StatelessWidget {
  CardDetails? card;
  CardGenerator(this.card, {super.key});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => OrdersPage())),
      child: Card(
        margin: EdgeInsets.all(1),
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height / 13.5,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Icon(card?.icon),
                const SizedBox(
                  width: 15,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (card?.description != null) ...[
                      Text('${card?.text}'),
                      const SizedBox(
                        height: 3,
                      ),
                      Text(
                        '${card?.description}',
                        style: TextStyle(fontSize: 10, color: Colors.grey[700]),
                      )
                    ],
                    if (card?.description == null)
                      Center(child: Text('${card?.text}')),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
