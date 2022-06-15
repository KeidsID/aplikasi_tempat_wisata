import 'package:aplikasi_tempat_wisata/model/tourism_place.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  final TourismPlace place;

  const DetailPage(this.place, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints boxConstraints) {
        if (boxConstraints.maxWidth > 800) {
          return DetailWebPage(place);
        } else {
          return DetailMobilePage(place);
        }
      },
    );
  }
}

//class layout style (Web/Mobile)
class DetailMobilePage extends StatefulWidget {
  final TourismPlace place;

  const DetailMobilePage(this.place, {Key? key}) : super(key: key);

  @override
  State<DetailMobilePage> createState() => _DetailMobilePageState();
}

class _DetailMobilePageState extends State<DetailMobilePage> {
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    TextStyle oxygenFontFamily =
        const TextStyle(color: Colors.white, fontFamily: 'Oxygen');

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 60, 60, 60),
      body: SafeArea(
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            // Custom appbar lmao
            Stack(
              children: [
                Hero(
                    tag: widget.place.heroTag,
                    child: SizedBox(
                      width: screenWidth,
                      child: Image.asset(
                        widget.place.imageAsset,
                        fit: BoxFit.cover,
                      ),
                    )),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Back Button
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                            backgroundColor: const Color.fromARGB(155, 0, 0, 0),
                            child: IconButton(
                                color: Colors.white,
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(Icons.arrow_back))),
                      ),
                      const FavoriteButton(),
                    ]),
              ],
            ),

            // Headings
            Container(
              padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
              child: Text(widget.place.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'Staatliches',
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  )),
            ),

            // Row
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      const Icon(Icons.calendar_today, color: Colors.white),
                      Text(
                        widget.place.openDays,
                        style: oxygenFontFamily,
                      )
                    ],
                  ),
                  Column(children: [
                    const Icon(Icons.access_time, color: Colors.white),
                    Text(
                      widget.place.openTime,
                      style: oxygenFontFamily,
                    )
                  ]),
                  Column(children: [
                    const Icon(Icons.monetization_on, color: Colors.white),
                    Text(
                      widget.place.ticketPrice,
                      style: oxygenFontFamily,
                    )
                  ])
                ],
              ),
            ),

            // Description text
            Container(
              padding: const EdgeInsets.all(8),
              child: Text(
                widget.place.description,
                style: oxygenFontFamily,
                textAlign: TextAlign.center,
              ),
            ),

            // ListView Image
            Scrollbar(
              thumbVisibility: true,
              controller: _scrollController,
              child: Container(
                decoration: BoxDecoration(
                    color: const Color.fromARGB(55, 155, 155, 155),
                    borderRadius: BorderRadius.circular(8)),
                margin: const EdgeInsets.all(8),
                height: 150,
                child: ListView(
                    scrollDirection: Axis.horizontal,
                    controller: _scrollController,
                    children: widget.place.imageUrls
                        .map((e) => ImageWithBorder(url: e))
                        .toList()),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

class DetailWebPage extends StatefulWidget {
  final TourismPlace place;

  const DetailWebPage(this.place, {Key? key}) : super(key: key);

  @override
  State<DetailWebPage> createState() => _DetailWebPageState();
}

class _DetailWebPageState extends State<DetailWebPage> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final scrollController = ScrollController();

    @override
    // ignore: unused_element
    void dispose() {
      scrollController.dispose();
      super.dispose();
    }

    TextStyle oxygenFontFamily = const TextStyle(
        color: Colors.white, fontFamily: 'Oxygen', fontSize: 16);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 60, 60, 60),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 64),
          child: Center(
            child: SizedBox(
              width: screenWidth,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'WISATA BANDUNG',
                      style: TextStyle(
                          fontFamily: 'Staatliches',
                          color: Colors.white,
                          fontSize: 30),
                    ),
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Image
                          Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 300,
                                  child: Hero(
                                      tag: widget.place.heroTag,
                                      child: ImageWithBorderAssets(
                                        path: widget.place.imageAsset,
                                      )),
                                ),

                                // ListView
                                Scrollbar(
                                  thumbVisibility: true,
                                  controller: scrollController,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            55, 155, 155, 155),
                                        borderRadius: BorderRadius.circular(8)),
                                    margin: const EdgeInsets.all(8),
                                    height: 150,
                                    child: ListView(
                                        scrollDirection: Axis.horizontal,
                                        controller: scrollController,
                                        children: widget.place.imageUrls
                                            .map((e) => ImageWithBorder(url: e))
                                            .toList()),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Card (Description)
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Card(
                                    color:
                                        const Color.fromARGB(255, 40, 40, 40),
                                    shadowColor: Colors.white,
                                    child: Container(
                                      padding: const EdgeInsets.all(16),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            // Headings
                                            Center(
                                              child: Text(widget.place.name,
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: 'Staatliches',
                                                    fontSize: 30.0,
                                                    fontWeight: FontWeight.bold,
                                                  )),
                                            ),

                                            // Icons
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8, bottom: 8),
                                              child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    // Icons Detail
                                                    Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(children: [
                                                            const Icon(
                                                                Icons
                                                                    .calendar_today,
                                                                color: Colors
                                                                    .white),
                                                            const SizedBox(
                                                                width: 8),
                                                            Text(
                                                              widget.place
                                                                  .openDays,
                                                              style:
                                                                  oxygenFontFamily,
                                                            ),
                                                          ]),
                                                          const SizedBox(
                                                              height: 8),
                                                          Row(children: [
                                                            const Icon(
                                                                Icons
                                                                    .access_time,
                                                                color: Colors
                                                                    .white),
                                                            const SizedBox(
                                                                width: 8),
                                                            Text(
                                                              widget.place
                                                                  .openTime,
                                                              style:
                                                                  oxygenFontFamily,
                                                            ),
                                                          ]),
                                                          const SizedBox(
                                                              height: 8),
                                                          Row(children: [
                                                            const Icon(
                                                                Icons
                                                                    .monetization_on,
                                                                color: Colors
                                                                    .white),
                                                            const SizedBox(
                                                                width: 8),
                                                            Text(
                                                              widget.place
                                                                  .ticketPrice,
                                                              style:
                                                                  oxygenFontFamily,
                                                            ),
                                                          ])
                                                        ]),

                                                    const FavoriteButton(),
                                                  ]),
                                            ),

                                            // Description text
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 16),
                                              child: Text(
                                                widget.place.description,
                                                style: oxygenFontFamily,
                                                textAlign: TextAlign.justify,
                                              ),
                                            ),
                                          ]),
                                    )),

                                // Back Button
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 8, top: 8),
                                  child: ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                const Color.fromARGB(
                                                    255, 40, 40, 40)),
                                        shadowColor: MaterialStateProperty.all(
                                            Colors.white),
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        'Go Back',
                                        style: oxygenFontFamily,
                                      )),
                                )
                              ],
                            ),
                          )
                        ]),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}

// class custom widget
class ImageWithBorder extends StatelessWidget {
  final String url;

  const ImageWithBorder({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 40, 40, 40),
          borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.all(4.0),
      margin: const EdgeInsets.all(8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          url,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class ImageWithBorderAssets extends StatelessWidget {
  final String path;

  const ImageWithBorderAssets({Key? key, required this.path}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 40, 40, 40),
          borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.all(4.0),
      margin: const EdgeInsets.all(8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.asset(
          path,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class FavoriteButton extends StatefulWidget {
  const FavoriteButton({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CircleAvatar(
        backgroundColor: const Color.fromARGB(155, 0, 0, 0),
        child: IconButton(
          icon: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border,
            color: Colors.red,
          ),
          onPressed: () {
            setState(() {
              isFavorite = !isFavorite;
            });
          },
        ),
      ),
    );
  }
}
