import 'package:flutter/material.dart';

class MovieListWidget extends StatelessWidget {
  final List movies = [
    "Titanic",
    "Blade Runner",
    "Rambo",
    "The Avengers",
    "Godzilla",
    "Vikings"
  ];

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
                decoration: BoxDecoration(
                    // color: Colors.blue,
                    borderRadius: BorderRadius.circular(13.0)),
                child: Text(movies[index].toString().characters.first),
              )),
              title: Text(movies[index]),
              subtitle: Text("sub"),
              trailing: Text("..."),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            MovieListDetailWidget(movieName: movies[index])));
              },
            ),
          );
        },
      ),
    );
  }
}

class MovieListDetailWidget extends StatelessWidget {
  final String movieName;

  MovieListDetailWidget({Key? key, this.movieName = ""}) : super(key: key);

  // const MovieListDetailWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(this.movieName),
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
