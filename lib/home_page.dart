import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:network_app/movie_item.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<MovieItem> movies = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Fancy Movies"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: movies.length,
        itemBuilder: (context, index) {
          return Text("${movies[index].title}");
        },
      ),
    );
  }

  @override
  void initState() {
    _getData();
    super.initState();
  }

  Future<void> _getData() async {
    final dio = Dio();
    String url = 'http://www.omdbapi.com/?apikey=5130d83e&s=Batman&page=2';
    final response = await dio.get(url);
    if (response.statusCode == 200) {
      var encoded = jsonEncode(response.data);
      Map<String, dynamic> result = jsonDecode(
        encoded,
      );

      var searchResult = result['Search'];

      for (var movie in searchResult) {
        // print("Data: " + movie.toString());
        MovieItem movieItem = MovieItem(
            imdbID: movie["imdbID"],
            title: movie['Title'],
            year: movie['Year'],
            poster: movie['Poster'],
            type: movie['Type']);
        movies.add(movieItem);
      }
      setState(() {});
    }
  }
}
