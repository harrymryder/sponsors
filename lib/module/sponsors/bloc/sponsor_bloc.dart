import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sponsors/module/sponsors/api/sponsors_api.dart';
import '../models/sponsor.dart';

part 'sponsor_event.dart';
part 'sponsor_state.dart';

class SponsorBloc extends Bloc<SponsorEvent, SponsorState> {
  SponsorBloc() : super(SponsorState()) {
    on<SponsorFetched>(
      _onSponsorFetched,
    );
  }

  Future<void> _onSponsorFetched(
      SponsorFetched event, Emitter<SponsorState> emit) async {
    log('=================');
    log('FETCHING SPONSORS');
    final currentPage = state.currentPage + 1;
    log('Current page: $currentPage');
    if (currentPage > 2) {
      log('Not going any further...');
      return;
    } else {
      try {
        final List<Sponsor> sponsors =
            await SponsorsApi.fetchSponsors(currentPage);
        emit(state.copyWith(
          status: SponsorStatus.success,
          currentPage: currentPage,
          sponsors: List.of(state.sponsors)..addAll(sponsors),
        ));
      } catch (_) {
        emit(state.copyWith(status: SponsorStatus.failure));
      }
    }
    log('State current page: ${state.currentPage}');
    log('=================');
  }
}
