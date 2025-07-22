import 'package:ditonton_revamp/feature/tv_series/presentation/on_the_air_tv_series_bloc/on_the_air_tv_series_bloc.dart';
import 'package:ditonton_revamp/feature/tv_series/presentation/pages/popular_tv_series_page.dart';
import 'package:ditonton_revamp/feature/tv_series/presentation/pages/search_tv_series_page.dart';
import 'package:ditonton_revamp/feature/tv_series/presentation/pages/top_rated_tv_series_page.dart';
import 'package:ditonton_revamp/feature/tv_series/presentation/pages/tv_series_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../common/constants.dart';
import '../../domain/entities/tv_series.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../popular_tv_series_bloc/popular_tv_series_bloc.dart';
import '../top_rated_tv_series_bloc/top_rated_tv_series_bloc.dart';

class HomeTvSeriesPage extends StatefulWidget {
  static const routeName = '/tv-series-page';

  const HomeTvSeriesPage({super.key});

  @override
  State<HomeTvSeriesPage> createState() => _HomeTvSeriesPageState();
}

class _HomeTvSeriesPageState extends State<HomeTvSeriesPage> {
  @override
  void initState() {
    super.initState();
    context.read<OnTheAirTvSeriesBloc>().add(FetchOnTheAirTvSeries());
    context.read<PopularTvSeriesBloc>().add(FetchPopularTvSeries());
    context.read<TopRatedTvSeriesBloc>().add(FetchTopRatedTvSeries());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ditonton Tv Series'),
        actions: [
          IconButton(
            onPressed: () {
              context.pushNamed(SearchTvSeriesPage.routeName);
            },
            icon: Icon(Icons.search),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('On The Air', style: kHeading6),
              BlocBuilder<OnTheAirTvSeriesBloc, OnTheAirTvSeriesState>(
                builder: (context, state) {
                  if (state is OnTheAirTvSeriesLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is OnTheAirTvSeriesLoaded) {
                    return TvSeriesList(state.series);
                  } else if (state is OnTheAirTvSeriesError) {
                    return Text('Failed: ${state.message}');
                  }
                  return SizedBox();
                },
              ),
              _buildSubHeading(
                title: 'Popular',
                onTap: () => context.pushNamed(PopularTvSeriesPage.routeName),
              ),
              BlocBuilder<PopularTvSeriesBloc, PopularTvSeriesState>(
                builder: (context, state) {
                  if (state is PopularTvSeriesLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is PopularTvSeriesLoaded) {
                    return TvSeriesList(state.series);
                  } else if (state is PopularTvSeriesError) {
                    return Text('Failed: ${state.message}');
                  }
                  return SizedBox();
                },
              ),
              _buildSubHeading(
                title: 'Top Rated',
                onTap: () => context.pushNamed(TopRatedTvSeriesPage.routeName),
              ),
              BlocBuilder<TopRatedTvSeriesBloc, TopRatedTvSeriesState>(
                builder: (context, state) {
                  if (state is TopRatedTvSeriesLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is TopRatedTvSeriesLoaded) {
                    return TvSeriesList(state.series);
                  } else if (state is TopRatedTvSeriesError) {
                    return Text('Failed: ${state.message}');
                  }
                  return SizedBox();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: kHeading6),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class TvSeriesList extends StatelessWidget {
  final List<TvSeries> tvSeries;

  const TvSeriesList(this.tvSeries, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: tvSeries.length,
        itemBuilder: (context, index) {
          final tv = tvSeries[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                context.pushNamed(
                  TvSeriesDetailPage.routeName,
                  extra: tv.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$baseImageUrl${tv.posterPath}',
                  placeholder: (context, url) =>
                      Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
