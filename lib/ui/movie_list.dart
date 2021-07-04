import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:flutter/services.dart';

// import 'package:hello_flutter/util/hexcolor.dart';
// import 'package:hello_flutter/model/movie.dart';

class MovieListWidget extends StatefulWidget {
  @override
  _MovieListWidgetState createState() => _MovieListWidgetState();
}

class _MovieListWidgetState extends State<MovieListWidget> {
  List movies = const [];

  @override
  void initState() {
    super.initState();
    this.readJson();
  }

  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/film.json');
    setState(() => movies = json.decode(response));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Movies"),
        backgroundColor: Colors.grey.shade900,
      ),
      backgroundColor: Colors.grey.shade900,
      body: ListView.builder(
        itemCount: movies.length,
        itemBuilder: (BuildContext context, int index) {
          return Stack(children: [
            movieCard(movies[index], context),
            Positioned(top: 10, child: movieImage(movies[index]['Images'][0])),
          ]);
          // return Card(
          //   elevation: 4.5,
          //   color: Colors.white,
          //   child: ListTile(
          //     leading: CircleAvatar(
          //         child: Container(
          //       width: 200,
          //       height: 200,
          //       decoration: BoxDecoration(
          //           image: DecorationImage(
          //               image: NetworkImage(movies[index]['Images']
          //                   [this.getRandom(movies[index]['Images'].length - 1)]),
          //               fit: BoxFit.cover),
          //           borderRadius: BorderRadius.circular(13.0)),
          //       child: null,
          //     )),
          //     title: Text(movies[index]['Title']),
          //     subtitle: Text(movies[index]['Year']),
          //     trailing: Text("..."),
          //     onTap: () {
          //       Navigator.push(
          //           context,
          //           MaterialPageRoute(
          //               builder: (context) => MovieListDetailWidget(
          //                   movieName: movies[index]['Title'],
          //                   movie: movies[index])));
          //     },
          //   ),
          // );
        },
      ),
    );
  }

  int getRandom(int max) {
    Random rand = new Random();
    return rand.nextInt(max);
  }

  Widget movieCard(dynamic movie, BuildContext context) {
    return InkWell(
      child: Container(
        margin: EdgeInsets.only(left: 70),
        width: MediaQuery.of(context).size.width,
        height: 100.0,
        child: Card(
          color: Colors.black45,
          child: Padding(
            padding: const EdgeInsets.only(top: 2.0, bottom: 2.0, left: 50.0),
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          limitString(movie['Title'], 20),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Rating: " + movie['imdbRating'] + " / 10",
                          style: TextStyle(
                            fontSize: 13.0,
                            color: Colors.grey,
                          ),
                        ),
                      ]),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "Release: " + movie['Released'] + " ",
                        style: TextStyle(
                          fontSize: 13.0,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        movie['Runtime'],
                        style: TextStyle(
                          fontSize: 13.0,
                          color: Colors.grey,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MovieListDetailWidget(
                    movieName: movie['Title'], movie: movie)));
      },
    );
  }

  String limitString(String text, int limit) {
    if (text.length > (limit - 1)) {
      text = text.substring(0, (limit - 1));
    }
    return text;
  }

  Widget movieImage(String imageUrl) {
    return Container(
      width: 150,
      height: 80,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(image: NetworkImage(imageUrl)),
      ),
    );
  }
}

class MovieListDetailWidget extends StatelessWidget {
  final String movieName;
  final dynamic movie;

  MovieListDetailWidget({Key? key, this.movieName = "", this.movie})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(this.movie['Title']),
          backgroundColor: Colors.blueGrey.shade900,
        ),
        body: ListView(
          children: [
            MovieDetailThumbnail(
              thumbnail: this.movie['Images'][1],
            ),
            MovieDetailsHeaderWithPoster(movie: this.movie),
            HorizontalLine(),
            MovieDetailsCast(movie: this.movie),
            HorizontalLine(),
            MovieDetailsExtraPosters(posters: this.movie["Images"])
          ],
        )
        // body: Center(
        //   child: Container(
        //     child: TextButton.icon(
        //       icon: Icon(Icons.arrow_back),
        //       label: Text("Back"),
        //       onPressed: () {
        //         Navigator.pop(context);
        //       },
        //     ),
        //   ),
        // )
        );
  }
}

class MovieDetailThumbnail extends StatelessWidget {
  const MovieDetailThumbnail({Key? key, this.thumbnail = ""}) : super(key: key);

  final String thumbnail;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 170,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(thumbnail), fit: BoxFit.cover)),
            ),
            Icon(
              Icons.play_circle_outline,
              color: Colors.white,
              size: 100,
            )
          ],
        ),
        Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Color(0x00f5f5f5),
            Color(0xfff5f5f5),
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          height: 80,
        )
      ],
    );
  }
}

class MovieDetailsHeaderWithPoster extends StatelessWidget {
  final dynamic movie;

  const MovieDetailsHeaderWithPoster({Key? key, this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          MoviePoster(poster: movie['Images'][0]),
          SizedBox(
            width: 16,
          ),
          Expanded(child: MovieDetailHeader(movie: this.movie))
        ],
      ),
    );
  }
}

class MoviePoster extends StatelessWidget {
  final String poster;

  const MoviePoster({Key? key, this.poster = ""}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var borderRadius = BorderRadius.all(Radius.circular(10));
    return Card(
      child: ClipRRect(
        borderRadius: borderRadius,
        child: Container(
          width: MediaQuery.of(context).size.width / 4,
          height: 160,
          decoration: BoxDecoration(
            image:
                DecorationImage(image: NetworkImage(poster), fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }
}

class MovieDetailHeader extends StatelessWidget {
  final dynamic movie;

  const MovieDetailHeader({Key? key, this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "" + movie["Year"] + " . " + movie["Genre"].toString().toUpperCase(),
          style: TextStyle(fontWeight: FontWeight.w400, color: Colors.cyan),
        ),
        Text(
          movie["Title"],
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 32),
        ),
        Text.rich(TextSpan(
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
            children: [
              TextSpan(text: movie["Plot"]),
              TextSpan(text: "More...", style: TextStyle(color: Colors.indigo))
            ]))
      ],
    );
  }
}

class MovieDetailsCast extends StatelessWidget {
  final dynamic movie;

  const MovieDetailsCast({Key? key, this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          MovieField(field: "Actors", value: movie["Actors"]),
          MovieField(field: "Director", value: movie["Director"]),
          MovieField(field: "Awards", value: movie["Awards"]),
        ],
      ),
    );
  }
}

class MovieField extends StatelessWidget {
  final String field;
  final String value;

  const MovieField({Key? key, this.field = "", this.value = ""})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$field: ",
          style: TextStyle(
              color: Colors.black38, fontSize: 12, fontWeight: FontWeight.w300),
        ),
        Expanded(
          child: Text(this.value,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w300)),
        )
      ],
    );
  }
}

class HorizontalLine extends StatelessWidget {
  const HorizontalLine({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Container(height: 0.5, color: Colors.grey),
    );
  }
}

class MovieDetailsExtraPosters extends StatelessWidget {
  final List<dynamic> posters;

  const MovieDetailsExtraPosters({Key? key, this.posters = const []})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "More Movie Posters".toUpperCase(),
            style: TextStyle(fontSize: 14, color: Colors.black26),
          ),
          Container(
            height: 150,
            padding: EdgeInsets.symmetric(vertical: 16),
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, index) => SizedBox(
                width: 8,
              ),
              itemCount: posters.length,
              itemBuilder: (context, index) => ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                child: Container(
                  width: MediaQuery.of(context).size.width / 4,
                  height: 160,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(this.posters[index]),
                          fit: BoxFit.cover)),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
