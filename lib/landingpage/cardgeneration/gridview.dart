import 'dart:math';

import 'package:flutter/material.dart';

class Grids {
  String? imgURL;
  Grids({this.imgURL});
}

List<Grids> gridList = [
  Grids(
      imgURL:
          'https://assets-in.bmscdn.com/discovery-catalog/collections/tr:l-text,ie-MTYwKyBFdmVudHM%3D,co-FFFFFF,ff-Roboto,fs-40,lx-50,ly-300,tg-b,pa-8_0_0_0,l-end/comedy-shows-collection-202305100822.png'),
  Grids(
      imgURL:
          'https://assets-in.bmscdn.com/discovery-catalog/collections/tr:l-text,ie-MTUrIEV2ZW50cw%3D%3D,co-FFFFFF,ff-Roboto,fs-40,lx-50,ly-300,tg-b,pa-8_0_0_0,l-end/amusement-parks-collection-collection-202503240122.png'),
  Grids(
      imgURL:
          'https://assets-in.bmscdn.com/discovery-catalog/collections/tr:l-text,ie-NTArIEV2ZW50cw%3D%3D,co-FFFFFF,ff-Roboto,fs-40,lx-50,ly-300,tg-b,pa-8_0_0_0,l-end/theatre-shows-collection-202305100822.png'),
  Grids(
      imgURL:
          'https://assets-in.bmscdn.com/discovery-catalog/collections/tr:l-text,ie-MzUrIEV2ZW50cw%3D%3D,co-FFFFFF,ff-Roboto,fs-40,lx-50,ly-300,tg-b,pa-8_0_0_0,l-end/kids-collection-collection-202503240122.png'),
  Grids(
      imgURL:
          'https://assets-in.bmscdn.com/discovery-catalog/collections/tr:l-text,ie-MjE1KyBFdmVudHM%3D,co-FFFFFF,ff-Roboto,fs-40,lx-50,ly-300,tg-b,pa-8_0_0_0,l-end/adventure-and-fun-collection-202305100822.png'),
  Grids(
      imgURL:
          'https://assets-in.bmscdn.com/discovery-catalog/collections/tr:l-text,ie-ODUrIEV2ZW50cw%3D%3D,co-FFFFFF,ff-Roboto,fs-40,lx-50,ly-300,tg-b,pa-8_0_0_0,l-end/music-shows-collection-202305100822.png'),
  Grids(
      imgURL:
          'https://assets-in.bmscdn.com/discovery-catalog/collections/tr:w-800,h-800:ote-MyBFdmVudHM%3D,otc-FFFFFF,otf-Roboto,ots-64,ox-48,oy-320,ott-b:w-300:q-80/self-improvement-collection-202007220710.png'),
  Grids(
      imgURL:
          'https://assets-in.bmscdn.com/discovery-catalog/collections/tr:w-800,h-800:ote-MSBFdmVudA%3D%3D,otc-FFFFFF,otf-Roboto,ots-64,ox-48,oy-320,ott-b:w-300:q-80/cooking-collection-202007222211.png'),
  Grids(
      imgURL:
          'https://assets-in.bmscdn.com/discovery-catalog/collections/tr:w-800,h-800:ote-NiBFdmVudHM%3D,otc-FFFFFF,otf-Roboto,ots-64,ox-48,oy-320,ott-b:w-300:q-80/interactive-games-collection-202012041129.png'),
  Grids(
      imgURL:
          'https://assets-in.bmscdn.com/discovery-catalog/collections/tr:w-800,h-800:ote-MyBFdmVudHM%3D,otc-FFFFFF,otf-Roboto,ots-64,ox-48,oy-320,ott-b:w-300:q-80/art-and-crafts-collection-202007220710.png'),
  Grids(
      imgURL:
          'https://assets-in.bmscdn.com/discovery-catalog/collections/tr:w-800,h-800:ote-NyBFdmVudHM%3D,otc-FFFFFF,otf-Roboto,ots-64,ox-48,oy-320,ott-b:w-300:q-80/theatre-shows-collection-202012041128.png'),
  Grids(
      imgURL:
          'https://assets-in.bmscdn.com/discovery-catalog/collections/tr:w-800,h-800:ote-MSBFdmVudA%3D%3D,otc-FFFFFF,otf-Roboto,ots-64,ox-48,oy-320,ott-b:w-300:q-80/dance-collection-01102020340.png'),
];

class GridList extends StatelessWidget {
  const GridList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      // height: MediaQuery.of(context).size.height * 0.42,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              'The Best Of Entertainment',
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.height / 45,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              'Step out or stay in, interesting experiences for everyone.',
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.height / 70,
                color: Colors.grey,
              ),
            ),
          ),
          // Spacer(),
          Container(
            height: MediaQuery.of(context).size.height * 0.35,
            child: GridView.count(
                key: const PageStorageKey<String>('page4'),
                scrollDirection: Axis.horizontal,
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 3 / 3.95,
                children: [
                  ...gridList.map((e) {
                    var emoji = getRandomMovieEmoji();
                    return Card(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image(
                          image: NetworkImage(
                            e.imgURL.toString(),
                          ),
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              alignment: Alignment.center,
                              child: Center(
                                  child: Text(
                                emoji,
                                style: TextStyle(fontSize: 56),
                              )),
                            );
                          },
                        ),
                      ),
                    );
                  })
                ]),
          ),
        ],
      ),
    );
  }

  String getRandomMovieEmoji() {
    const emojis = [
      '🎬', // Clapper board
      '🎥', // Movie camera
      '🍿', // Popcorn
      '📽️', // Film projector
      '🎞️', // Film frames
      '⭐', // Star (for ratings or actors)
      '🎭', // Performing arts
      '🏆', // Award
      '🔊', // Sound
      '🎶', // Music
      '📺', // TV (for shows)
      '🎟️', // Ticket
    ];

    final random = Random();
    var emoji = emojis[random.nextInt(emojis.length)];
    print("Emoji : $emoji");
    return emoji;
  }
}
