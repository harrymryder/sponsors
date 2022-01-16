import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sponsors/module/sponsors/bloc/sponsor_bloc.dart';
import 'package:sponsors/module/sponsors/cubit/sponsor_cubit.dart';
import 'package:sponsors/module/sponsors/widgets/sponsor_card.dart';

class SponsorsList extends StatefulWidget {
  const SponsorsList({Key? key}) : super(key: key);

  @override
  _SponsorsListState createState() => _SponsorsListState();
}

class _SponsorsListState extends State<SponsorsList> {
  final _scrollController = ScrollController();
  bool _loadMore = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom && _loadMore) {
      context.read<SponsorBloc>().add(SponsorFetched());
      _loadMore = false;
      Future.delayed(const Duration(seconds: 1))
          .then((value) => _loadMore = true);
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SponsorBloc, SponsorState>(builder: (context, state) {
      switch (state.status) {
        case SponsorStatus.failure:
          return const Center(child: Text('Network error'));
        case SponsorStatus.success:
          if (state.sponsors.isEmpty) {
            return const Center(child: Text('No sponsors'));
          } else {
            return ListView.builder(
              controller: _scrollController,
              itemCount: state.sponsors.length,
              padding: const EdgeInsets.only(
                top: 8,
                right: 8,
                left: 8,
                bottom: 100,
              ),
              itemBuilder: (context, index) => BlocProvider(
                create: (context) => SponsorCubit(),
                child: SponsorCard(
                  id: state.sponsors[index].id,
                  name: state.sponsors[index].name,
                  logo: state.sponsors[index].logo,
                  images: state.sponsors[index].images,
                ),
              ),
            );
          }
        default:
          return const Center(child: CircularProgressIndicator());
      }
    });
  }
}
