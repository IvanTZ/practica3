// To parse this JSON data, do
//
//     final popularResponse = popularResponseFromMap(jsonString);

import 'models.dart';

class PopularResponse {
  PopularResponse({
    required this.page,
    required this.moviePops,
    required this.totalPages,
    required this.totalMoviePops,
  });

  int? page;
  List<Movie> moviePops;
  int totalPages;
  int totalMoviePops;

  factory PopularResponse.fromJson(String str) =>
      PopularResponse.fromMap(json.decode(str));

  //String toJson() => json.encode(toMap());

  factory PopularResponse.fromMap(Map<String, dynamic> json) => PopularResponse(
        page: json["page"],
        moviePops:
            List<Movie>.from(json["results"].map((x) => Movie.fromMap(x))),
        totalPages: json["total_pages"],
        totalMoviePops: json["total_results"],
      );
/*
  Map<String, dynamic> toMap() => {
        "page": page,
        "MoviePops": List<dynamic>.from(MoviePops.map((x) => x.toMap())),
        "total_pages": totalPages,
        "total_MoviePops": totalMoviePops,
      };
}
*/

}
