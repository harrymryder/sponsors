import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sponsors/module/sponsors/api/sponsors_api.dart';

import '../repository/sponsors_repository.dart';
import '../models/sponsor.dart';

part 'sponsors_event.dart';
part 'sponsors_state.dart';

class SponsorsBloc extends Bloc<SponsorsEvent, SponsorsState> {
  SponsorsBloc() : super(const SponsorsState()) {
    on<SponsorsFetched>(
      _onSponsorsFetched,
    );
  }

  Future<void> _onSponsorsFetched(
      SponsorsFetched event, Emitter<SponsorsState> emit) async {
    final currentPage = state.currentPage + 1;

    if (state.hasReachedMax) return;

    try {
      /// Show loading circle
      emit(state.copyWith(isFetching: true));

      /// Get sponsors from repository
      final List<Sponsor> sponsors =
          await SponsorsRepository(sponsorsAPI: SponsorsAPI())
              .getSponsors(currentPage);

      /// If no more pages, set max reached to true
      if (sponsors.isEmpty) {
        emit(state.copyWith(
          hasReachedMax: true,
          isFetching: false,
        ));
      } else {
        /// Else, add fetched sponsors to state
        emit(state.copyWith(
          status: SponsorsStatus.success,
          currentPage: currentPage,
          sponsors: List.of(state.sponsors)..addAll(sponsors),
          isFetching: false,
        ));
      }
    } catch (_) {
      emit(state.copyWith(status: SponsorsStatus.failure));
    }
  }
}
