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
        body: ListView.separated(
            itemBuilder: (BuildContext context, int position) {
              // return Text("Fancy Movies");
              return _movieItemView(movies[position]);
            },
            separatorBuilder: (BuildContext context, int position) {
              return const Divider(
                height: 10,
              );
            },
            itemCount: movies.length));
  }

  @override
  void initState() {
    _getData();
    super.initState();
  }

  _getData() async {
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

  Widget _movieItemView(MovieItem movieItem) {
    return ListTile(
      onTap: () {},
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: Colors.white.withAlpha(100),
      ),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(5.0),
        child: Image.network(
          movieItem.poster,
          fit: BoxFit.cover,
          height: 80,
          width: 60,
        ),
      ),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            movieItem.year,
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.red.withAlpha(50),
            ),
            child: Text(
              movieItem.type.toUpperCase(),
              style: TextStyle(color: Colors.black, fontSize: 12),
            ),
          ),
        ],
      ),
      title: Text(
        movieItem.title,
        style: TextStyle(color: Colors.black, fontSize: 16),
      ),
    );
  }
}
