import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:hello_flutter/model/movie.dart';

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
      backgroundColor: Colors.grey.shade400,
      body: ListView.builder(
        itemCount: movies.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            elevation: 4.5,
            color: Colors.white,
            child: ListTile(
              leading: CircleAvatar(
                  child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(movies[index]['Images']
                            [this.getRandom(movies[index]['Images'].length - 1)]),
                        fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(13.0)),
                child: null,
              )),
              title: Text(movies[index]['Title']),
              subtitle: Text(movies[index]['Year']),
              trailing: Text("..."),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MovieListDetailWidget(
                            movieName: movies[index]['Title'],
                            movie: movies[index])));
              },
            ),
          );
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
        width: MediaQuery.of(context).size.width,
        height: 120.0,
        child: Card(
          color: Colors.black45,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(movie['Title'])
            ],
          ),
        ),
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
        body: Center(
          child: Container(
            child: TextButton.icon(
              icon: Icon(Icons.arrow_back),
              label: Text("Back"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ));
  }
}
