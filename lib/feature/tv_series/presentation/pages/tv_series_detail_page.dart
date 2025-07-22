import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../add_remove_tv_watchlist_bloc/add_remove_tv_watchlist_bloc.dart';
import '../tv_detail_bloc/tv_detail_bloc.dart';
import '../widgets/detail_content.dart';

class TvSeriesDetailPage extends StatefulWidget {
  static const routeName = '/tv-series-detail';

  final int id;

  const TvSeriesDetailPage({super.key, required this.id});

  @override
  _TvSeriesDetailPageState createState() => _TvSeriesDetailPageState();
}

class _TvSeriesDetailPageState extends State<TvSeriesDetailPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TvDetailBloc>().add(OnFetchTvDetail(widget.id));
      context.read<AddRemoveTvWatchlistBloc>().add(
        OnFetchTvSeriesWatchlistStatus(widget.id),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TvDetailBloc, TvDetailState>(
        builder: (_, tvState) {
          if (tvState is TvDetailLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (tvState is TvDetailHasData) {
            return SafeArea(
              child: Center(
                child: DetailContent(
                  tvState.tvSeriesDetail,
                  tvState.tvSeriesRecommendation,
                  // watchlistState.isInWatchlist,
                ),
              ),
            );
          } else if (tvState is TvDetailError) {
            return Center(child: Text(tvState.message));
          } else {
            return Center(
              child: Icon(
                Icons.credit_card_off_sharp,
                size: 150,
                color: Color(0x34CECECE),
              ),
            );
          }
        },
      ),
    );
  }
}
