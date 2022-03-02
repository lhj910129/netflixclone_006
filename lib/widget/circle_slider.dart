import 'package:flutter/material.dart';
import 'package:netflixclone_006/model/model_movie.dart';

import '../screen/detail_screen.dart';

class CircleSlider extends StatelessWidget {
  final List<Movie>? movies; //movies넘겨받는 용도
  CircleSlider({this.movies});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(7),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('미리보기'),
          Container(
            height: 120,
            child: ListView(
              scrollDirection: Axis.horizontal, //스크롤방향 좌우 (vertical이 디폴드값)
              children: makeCircleImages(context, movies),
            ),
          )
        ],
      ),
    );
  }
}

List<Widget> makeCircleImages(BuildContext context, List<Movie>? movies) {
  List<Widget> results = [];

  for (var i = 0; i < (movies == null ? 0 : movies.length); i++) {
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
          child: CircleAvatar(
            backgroundImage: NetworkImage(
                (movies == null ? '' : movies[i].poster)
            ),
            radius: 48,
          ),
        ),
      ),
    ));
  }

  return results;
}
