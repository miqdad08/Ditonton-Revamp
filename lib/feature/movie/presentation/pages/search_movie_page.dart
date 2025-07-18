import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/constants.dart';
import '../movie_search_bloc/movie_search_bloc.dart';
import '../widgets/movie_card_list.dart';

class SearchMoviePage extends StatelessWidget {
  static const routeName = '/search';

  const SearchMoviePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Search')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onSubmitted: (query) {
                context.read<MovieSearchBloc>().add(OnQueryChanged(query));
              },
              decoration: InputDecoration(
                hintText: 'Search title',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
            ),
            SizedBox(height: 16),
            Text('Search Result', style: kHeading6),
            SizedBox(height: 8),
            Expanded(
              child: BlocBuilder<MovieSearchBloc, MovieSearchState>(
                builder: (context, state) {
                  if (state is MovieSearchLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is MovieSearchHasData) {
                    final result = state.result;
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        final movie = result[index];
                        return MovieCard(movie);
                      },
                      itemCount: result.length,
                    );
                  } else if (state is MovieSearchError) {
                    return Center(child: Text(state.message));
                  } else {
                    return Center(child: Text('Start typing to search movies'));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
