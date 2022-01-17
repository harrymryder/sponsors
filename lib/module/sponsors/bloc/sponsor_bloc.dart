import 'package:flutter_bloc/flutter_bloc.dart';

import '../../sponsors/api/sponsors_api.dart';
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
    final currentPage = state.currentPage + 1;

    if (state.hasReachedMax) return;

    try {
      /// Show loading circle
      emit(state.copyWith(isFetching: true));

      /// Fetch sponsors from API
      final List<Sponsor> sponsors =
          await SponsorsApi.fetchSponsors(currentPage);

      /// If no more pages, set max reached
      if (sponsors.isEmpty) {
        emit(state.copyWith(
          hasReachedMax: true,
          isFetching: false,
        ));

        /// Else, add fetched sponsors to state
      } else {
        emit(state.copyWith(
          status: SponsorStatus.success,
          currentPage: currentPage,
          sponsors: List.of(state.sponsors)..addAll(sponsors),
          isFetching: false,
        ));
      }
    } catch (_) {
      emit(state.copyWith(status: SponsorStatus.failure));
    }
  }
}
