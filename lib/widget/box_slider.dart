import 'package:flutter/material.dart';

import '../model/model_movie.dart';
import '../screen/detail_screen.dart';

class BoxSlider extends StatelessWidget {
  final List<Movie>? movies; //movies넘겨받는 용도
  BoxSlider({this.movies});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(7),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('지금 뜨는 콘텐츠'),
          Container(
            height: 120,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: makeBoxImages(context, movies),
            ),
          )
        ],
      ),
    );
  }
}

List<Widget> makeBoxImages(BuildContext context, List<Movie>? movies){
  List<Widget> results = [];

  for(int i = 0; i < (movies == null ? 0 : movies.length); i++){
    results.add(InkWell(
      onTap: () {

        Navigator.of(context).push(MaterialPageRoute<Null>(
            fullscreenDialog: true,
            builder: (BuildContext context) {
              print(movies?[i].toString());
              print(movies?[i].runtimeType);
              return DetailScreen(movie: movies?[i]);//    movies?[_currenetPage] as List<Movie>?);
            }));

      },
      child: Container(
        padding: EdgeInsets.only(right: 10),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Image.network(
              (movies == null ? '' : movies[i].poster)
          ),
        ),
      ),
    ));
  }

  return results;
}