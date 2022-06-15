import 'package:aplikasi_tempat_wisata/model/tourism_place.dart';
import 'package:aplikasi_tempat_wisata/page_list/detail_page.dart';
import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 60, 60, 60),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 20, 20, 20),
        title: const Text(
          'Wisata Bandung',
          style: TextStyle(fontFamily: 'Staatliches'),
        ),
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        if (constraints.maxWidth <= 600) {
          return const TourismPlaceList();
        } else if (constraints.maxWidth <= 1200) {
          return const TourismPlaceGrid(gridCount: 2);
        } else {
          return const TourismPlaceGrid(gridCount: 4);
        }
      }),
    );
  }
}

class TourismPlaceList extends StatelessWidget {
  const TourismPlaceList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: tourismPlaceList.length,
        itemBuilder: ((context, index) {
          final TourismPlace place = tourismPlaceList[index];
          return InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return DetailPage(place);
                }));
              },
              child: Card(
                color: const Color.fromARGB(255, 40, 40, 40),
                shadowColor: Colors.white,
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Image
                      Expanded(
                        flex: 1,
                        child: Hero(
                            tag: place.heroTag,
                            child: Container(
                                padding: const EdgeInsets.all(8),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.asset(place.imageAsset)))),
                      ),

                      // Name + Location
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  place.name,
                                  style: const TextStyle(
                                      fontFamily: 'Staatliches',
                                      color: Colors.white,
                                      fontSize: 22.0),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  place.location,
                                  style: const TextStyle(
                                      fontFamily: 'Oxygen',
                                      color: Colors.white),
                                ),
                              ]),
                        ),
                      ),
                    ]),
              ));
        }));
  }
}

class TourismPlaceGrid extends StatelessWidget {
  final int gridCount;

  const TourismPlaceGrid({Key? key, required this.gridCount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
        crossAxisCount: gridCount,
        children: tourismPlaceList.map((place) {
          return InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return DetailPage(place);
              }));
            },
            child: Card(
              color: const Color.fromARGB(255, 40, 40, 40),
              shadowColor: Colors.white,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Image
                    Expanded(
                      child: Hero(
                        tag: place.heroTag,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              place.imageAsset,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Name
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        place.name,
                        style: const TextStyle(
                          fontFamily: 'Staatliches',
                          color: Colors.white,
                          fontSize: 16.0,
                        ),
                      ),
                    ),

                    // Location
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
                      child: Text(
                        place.location,
                        style: const TextStyle(
                            fontFamily: 'Oxygen', color: Colors.white),
                      ),
                    ),
                  ]),
            ),
          );
        }).toList());
  }
}
