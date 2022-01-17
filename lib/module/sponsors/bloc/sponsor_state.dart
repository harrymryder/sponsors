part of 'sponsor_bloc.dart';

enum SponsorStatus { initial, success, failure }

class SponsorState {
  SponsorState({
    this.status = SponsorStatus.initial,
    this.sponsors = const <Sponsor>[],
    this.currentPage = 0,
    this.hasReachedMax = false,
    this.isFetching = false,
  });

  final SponsorStatus status;
  final List<Sponsor> sponsors;
  int currentPage;
  bool isFetching;
  bool hasReachedMax;

  SponsorState copyWith({
    SponsorStatus? status,
    List<Sponsor>? sponsors,
    int? currentPage,
    bool? isFetching,
    bool? hasReachedMax,
  }) {
    return SponsorState(
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

  List<Object> get props => [status, currentPage, sponsors, isFetching];
}
