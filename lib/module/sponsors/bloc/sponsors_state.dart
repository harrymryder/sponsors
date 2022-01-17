part of 'sponsors_bloc.dart';

enum SponsorsStatus { initial, success, failure }

class SponsorsState extends Equatable {
  const SponsorsState({
    this.status = SponsorsStatus.initial,
    this.sponsors = const <Sponsor>[],
    this.currentPage = 0,
    this.hasReachedMax = false,
    this.isFetching = false,
  });

  final SponsorsStatus status;
  final List<Sponsor> sponsors;
  final int currentPage;
  final bool isFetching;
  final bool hasReachedMax;

  SponsorsState copyWith({
    SponsorsStatus? status,
    List<Sponsor>? sponsors,
    int? currentPage,
    bool? isFetching,
    bool? hasReachedMax,
  }) {
    return SponsorsState(
      status: status ?? this.status,
      sponsors: sponsors ?? this.sponsors,
      currentPage: currentPage ?? this.currentPage,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      isFetching: isFetching ?? this.isFetching,
    );
  }

  @override
  String toString() {
    return '''SponsorState { status: $status, currentPage: $currentPage, hasReachedMax: $hasReachedMax, sponsors: ${sponsors.length}, isFetching: $isFetching }''';
  }

  @override
  List<Object> get props =>
      [status, currentPage, sponsors, isFetching, hasReachedMax];
}
