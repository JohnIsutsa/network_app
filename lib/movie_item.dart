class MovieItem {
  String title;
  String year;
  String imdbID;
  String type;
  String poster;

  MovieItem(
      {required this.imdbID,
      required this.title,
      required this.year,
      required this.poster,
      required this.type});
}
