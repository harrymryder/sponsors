import 'package:bloc_test/bloc_test.dart';
import 'package:test/test.dart';

import 'package:sponsors/module/sponsors/cubit/sponsor_cubit.dart';
import 'package:sponsors/module/sponsors/models/sponsor.dart';
import 'package:sponsors/module/sponsors/bloc/sponsors_bloc.dart';

void main() {
  group('sponsorCubit', () {
    late SponsorCubit sponsorCubit;

    setUp(() {
      sponsorCubit = SponsorCubit();
    });

    tearDown(() {
      sponsorCubit.close();
    });

    blocTest(
      'emits [] when nothing is added',
      build: () => sponsorCubit,
      expect: () => [],
    );

    blocTest<SponsorCubit, bool>(
      'emits true',
      build: () => sponsorCubit,
      act: (cubit) => cubit.expand(),
      expect: () => [true],
    );
  });

  group('sponsorsBloc', () {
    late SponsorsBloc sponsorBloc;

    setUp(() {
      sponsorBloc = SponsorsBloc();
    });

    tearDown(() {
      sponsorBloc.close();
    });

    blocTest<SponsorsBloc, SponsorsState>(
      'emits normal state',
      build: () => sponsorBloc,
      act: (cubit) => cubit.add(SponsorsFetched()),
      expect: () => [
        const SponsorsState(
          status: SponsorsStatus.initial,
          currentPage: 0,
          hasReachedMax: false,
          sponsors: [],
          isFetching: true,
        ),
      ],
    );
  });
}
