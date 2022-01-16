import 'package:flutter_bloc/flutter_bloc.dart';

class SponsorCubit extends Cubit<bool> {
  SponsorCubit() : super(false);

  void expand() => emit(true);
  void collapse() => emit(false);
}
