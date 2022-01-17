import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sponsors/shared/widgets/messages/error_message.dart';

import '../bloc/sponsor_bloc.dart';
import '../cubit/sponsor_cubit.dart';
import './sponsor_card.dart';

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

  void _retry() {
    context.read<SponsorBloc>().add(SponsorFetched());
  }

  void _onScroll() {
    if (_isBottom && _loadMore) {
      context.read<SponsorBloc>().add(SponsorFetched());
      _loadMore = false;
      Future.delayed(const Duration(seconds: 1)).then((_) => _loadMore = true);
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
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const ErrorMessage(
                  title: 'Network error!',
                  subtitle: 'Please check your internet connection',
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: _retry,
                  child: Text(
                    'Retry',
                    style: GoogleFonts.workSans(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          );
        case SponsorStatus.success:
          if (state.sponsors.isEmpty) {
            return const Center(
                child: ErrorMessage(
                    title: 'No sponsors!',
                    subtitle: 'Sorry - we couldn\'t find any sponsors'));
          } else {
            return ListView.builder(
              controller: _scrollController,
              itemCount: state.sponsors.length,
              padding: const EdgeInsets.only(
                top: 8,
                right: 8,
                left: 8,
                bottom: 40,
              ),
              itemBuilder: (context, index) => Column(
                children: [
                  BlocProvider(
                    create: (context) => SponsorCubit(),
                    child: SponsorCard(
                      sponsor: state.sponsors[index],
                    ),
                  ),
                  if (index == (state.sponsors.length - 1) && state.isFetching)
                    const Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Center(child: CircularProgressIndicator()),
                    ),
                ],
              ),
            );
          }
        default:
          return const Center(child: CircularProgressIndicator());
      }
    });
  }
}
