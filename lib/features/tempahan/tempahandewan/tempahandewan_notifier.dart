import 'dart:developer';

import 'package:promis/features/tempahan/tempahandewan/tempahandewan_state.dart';
import 'package:promis/features/tempahan/tempahandewan/tempahandewan.dart';
import 'package:promis/features/tempahan/tempahandewan/tempahandewan_service.dart';
import 'package:riverpod/riverpod.dart';


final tempahanDewanNotifierProvider =
    NotifierProvider<TempahanDewanNotifier,TempahanDewanState>(TempahanDewanNotifier.new);

class TempahanDewanNotifier extends Notifier<TempahanDewanState> {
  @override
  TempahanDewanState build() {
    getTempahanDewan();
    return const TempahanDewanStateLoaded();
  }

  TempahanDewan? tempahanDewan;

  getTempahanDewan() async {
    state = TempahanDewanStateLoading();
    Future.delayed(const Duration(milliseconds: 150));
    final tempahanDewann = await ref.read(tempahanDewanApiServiceProvider).getTempahanDewan();
    tempahanDewan = tempahanDewann;
    log('Tempahan Dewan data length:${tempahanDewan?.data.length}');
    state = TempahanDewanStateLoaded(
      tempahanDewan: ref.read(tempahanDewanApiServiceProvider).tempahanDewan,
    );
  }
}
