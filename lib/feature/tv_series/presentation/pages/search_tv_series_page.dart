import 'package:ditonton_revamp/feature/tv_series/presentation/pages/tv_series_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../common/constants.dart';
import '../tv_series_search_bloc/tv_series_search_bloc.dart';
import '../widgets/tv_series_card_list.dart';

class SearchTvSeriesPage extends StatelessWidget {
  static const routeName = '/search-tv-series';

  const SearchTvSeriesPage({super.key});

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
                context.read<TvSeriesSearchBloc>().add(OnQueryChanged(query));
              },
              decoration: InputDecoration(
                hintText: 'Search title',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
            ),
            const SizedBox(height: 16),
            Text('Search Result', style: kHeading6),
            const SizedBox(height: 8),
            Expanded(
              child: BlocBuilder<TvSeriesSearchBloc, TvSeriesSearchState>(
                builder: (context, state) {
                  if (state is TvSeriesSearchLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is TvSeriesSearchHasData) {
                    final result = state.result;
                    return ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: result.length,
                      itemBuilder: (context, index) {
                        return TvSeriesCard(
                          tvSeries: result[index],
                          onTap: () {
                            context.pushNamed(
                              TvSeriesDetailPage.routeName,
                              extra: result[index].id,
                            );
                          },
                        );
                      },
                    );
                  } else if (state is TvSeriesSearchError) {
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
