part of 'sponsor_bloc.dart';

enum SponsorStatus { initial, success, failure }

class SponsorState {
  SponsorState({
    this.status = SponsorStatus.initial,
    this.sponsors = const <Sponsor>[],
    this.currentPage = 0,
    this.hasReachedMax = false,
  });

  final SponsorStatus status;
  final List<Sponsor> sponsors;
  int currentPage;
  final bool hasReachedMax;

  SponsorState copyWith({
    SponsorStatus? status,
    List<Sponsor>? sponsors,
    int? currentPage,
    bool? hasReachedMax,
  }) {
    return SponsorState(
      status: status ?? this.status,
      sponsors: sponsors ?? this.sponsors,
      currentPage: currentPage ?? this.currentPage,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return '''SponsorState { status: $status, 'currentPage': $currentPage, hasReachedMax: $hasReachedMax, Sponsors: ${sponsors.length} }''';
  }

  List<Object> get props => [status, sponsors, hasReachedMax];
}
