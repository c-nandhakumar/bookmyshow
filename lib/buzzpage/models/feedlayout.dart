import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

import '../services/addbuzz_service.dart';

class FeedLayout extends StatefulWidget {
  final Buzz buzz;
  const FeedLayout({required this.buzz, super.key});

  @override
  State<FeedLayout> createState() => _FeedLayoutState();
}

class _FeedLayoutState extends State<FeedLayout> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double h = size.height;
    double w = size.width;
    return SizedBox(
      //padding: EdgeInsets.only(top: 10, bottom: 10),
      height: h * 0.15,
      child: Card(
        color: Colors.white,
        child: Row(children: [
          Container(
            padding: const EdgeInsets.all(10),
            width: w * 0.25,
            height: w * 0.25,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  widget.buzz.coverImgUrl,
                  fit: BoxFit.cover,
                )),
          ),
          SizedBox(
            width: w * 0.75 - 10,
            height: h * 0.15,
            child: Column(children: [
              SizedBox(
                height: (h * 0.15) * 0.60,
                width: w * 0.75 - 10,
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 10, top: 10),
                      height: (h * 0.15) * 0.60,
                      width: (w * 0.75 - 10) * 0.85,
                      child: Text(widget.buzz.title,
                          style: const TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 15)),
                    ),
                    Container(
                      height: (h * 0.15) * 0.60,
                      width: (w * 0.75 - 10) * 0.15,
                      padding: const EdgeInsets.only(right: 10, top: 10),
                      alignment: Alignment.topRight,
                      //color: Colors.green,
                      child: const Icon(
                        Icons.bookmark_border,
                        color: Colors.black54,
                        size: 20,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: (h * 0.15) * 0.30,
                width: w * 0.75 - 10,
                // color: Colors.green,
                child: Row(
                  children: [
                    SizedBox(
                      height: ((h * 0.15) * 0.30) * 0.60,
                      child: CircleAvatar(
                        backgroundColor: Colors.red,
                        child: Image.asset(
                          'assets/icons/BookMyShowLogo.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 2,
                    ),
                    Text(
                      Jiffy.parseFromDateTime(widget.buzz.datetime).fromNow(),
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    const Spacer(),
                    const Icon(Icons.favorite_border, size: 22),
                    const SizedBox(
                      width: 5,
                    ),
                    const Icon(Icons.share_outlined, size: 22),
                    const SizedBox(
                      width: 10,
                    )
                  ],
                ),
              )
            ]),
          ),
        ]),
      ),
    );
  }
}
