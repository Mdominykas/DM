import 'package:flutter/material.dart';
import 'package:movies/api/movies_api_service.dart';
import 'package:movies/models/genre.dart';
import 'package:movies/models/movie.dart';
import 'package:movies/ui/widgets/error_indicator.dart';
import 'package:movies/ui/widgets/loading_indicator.dart';
import 'package:movies/ui/widgets/movies_list.dart';

// App state https://flutter.dev/docs/development/ui/interactive
class DiscoverMoviesTab extends StatefulWidget {
  static final _allGenresItem = Genre(null, "All genres");

  @override
  _DiscoverMoviesTabState createState() => _DiscoverMoviesTabState();
}

class _DiscoverMoviesTabState extends State<DiscoverMoviesTab> {
  Genre _selectedGenre = DiscoverMoviesTab._allGenresItem;

  final _moviesApiService = MoviesApiService();

  onGenreChanged(Genre genre) {
    setState(() {
      _selectedGenre = genre;

    });
  }

  @override
  Widget build(BuildContext context) {
    print("_DiscoverMoviesTabState build");
    print(_selectedGenre.name.toString());
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => onGenreChanged(_selectedGenre),
        label: Text("SUPRISE ME"),
        icon: Icon(Icons.explore),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButton<Genre>(
                items: [DiscoverMoviesTab._allGenresItem, ...Genre.GENRES]
                    .map(
                      (genre) => DropdownMenuItem<Genre>(
                        value: genre,
                        child: Text(genre.name),
                      ),
                    )
                    .toList(),
                value: _selectedGenre,
                isExpanded: true,
                onChanged: (genre) => onGenreChanged(genre),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: _moviesApiService.getRandomMovies(_selectedGenre.id),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Movie>> snapshot) {
                  if (snapshot.hasData &&
                      snapshot.connectionState == ConnectionState.done) {
                    return MoviesListView(movies: snapshot.data);
                  } else if (snapshot.hasError) {
                    return ErrorIndicator(error: snapshot.error);
                  }
                  return LoadingIndicator();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
