import 'package:ditonton_revamp/feature/tv_series/presentation/pages/tv_series_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../popular_tv_series_bloc/popular_tv_series_bloc.dart';
import '../widgets/tv_series_card_list.dart';

class PopularTvSeriesPage extends StatefulWidget {
  static const routeName = '/popular-tv-series';

  const PopularTvSeriesPage({super.key});

  @override
  _PopularTvSeriesPageState createState() => _PopularTvSeriesPageState();
}

class _PopularTvSeriesPageState extends State<PopularTvSeriesPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PopularTvSeriesBloc>().add(FetchPopularTvSeries());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Popular Tv Series')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<PopularTvSeriesBloc, PopularTvSeriesState>(
          builder: (context, state) {
            if (state is PopularTvSeriesLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is PopularTvSeriesLoaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final series = state.series[index];
                  return TvSeriesCard(
                    tvSeries: series,
                    onTap: () {
                      context.pushNamed(
                        TvSeriesDetailPage.routeName,
                        extra: series.id,
                      );
                    },
                  );
                },
                itemCount: state.series.length,
              );
            } else if (state is PopularTvSeriesError) {
              return Center(
                key: Key('error_message'),
                child: Text(state.message),
              );
            } else {
              return SizedBox();
            }
          },
        ),
      ),
    );
  }
}
