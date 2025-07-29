import 'package:ditonton_revamp/feature/tv_series/presentation/pages/tv_series_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../common/utils.dart';
import '../watchlist_tv_series/watchlist_tv_series_bloc.dart';
import '../widgets/tv_series_card_list.dart';

class WatchlistTvSeriesPage extends StatefulWidget {
  static const routeName = '/watchlist-tv-series';

  const WatchlistTvSeriesPage({super.key});

  @override
  _WatchlistTvSeriesPageState createState() => _WatchlistTvSeriesPageState();
}

class _WatchlistTvSeriesPageState extends State<WatchlistTvSeriesPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<WatchlistTvSeriesBloc>().add(FetchWatchlistTvSeries());
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    context.read<WatchlistTvSeriesBloc>().add(FetchWatchlistTvSeries());
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Watchlist Tv Series')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.message.isNotEmpty) {
              return Center(
                key: const Key('error_message'),
                child: Text(state.message),
              );
            } else if (state.watchlistTvSeries.isEmpty) {
              return const Center(child: Text('Watchlist masih kosong'));
            } else {
              return ListView.builder(
                itemCount: state.watchlistTvSeries.length,
                itemBuilder: (context, index) {
                  final tvSeries = state.watchlistTvSeries[index];
                  return TvSeriesCard(
                    tvSeries: tvSeries,
                    onTap: () {
                      context.pushNamed(
                        TvSeriesDetailPage.routeName,
                        extra: tvSeries.id,
                      ).then((value)async{
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          context.read<WatchlistTvSeriesBloc>().add(FetchWatchlistTvSeries());
                        });
                      });
                    },
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
