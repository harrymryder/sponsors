import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/sponsor_bloc.dart';
import '../widgets/sponsors_list.dart';

class SponsorsView extends StatelessWidget {
  const SponsorsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sponsors'),
      ),
      body: BlocProvider(
        create: (_) => SponsorBloc()..add(SponsorFetched()),
        child: const SponsorsList(),
      ),
    );
  }
}
