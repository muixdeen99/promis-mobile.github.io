import 'dart:developer';
import 'package:promis/features/tempahan/tempahangelanggang/tempahangelanggang.dart';
import 'package:promis/features/tempahan/tempahangelanggang/tempahangelanggang_service.dart';
import 'package:promis/features/tempahan/tempahangelanggang/tempahangelanggang_state.dart';
import 'package:riverpod/riverpod.dart';


final tempahanGelanggangNotifierProvider =
    NotifierProvider<TempahanGelanggangNotifier,TempahanGelanggangState>(TempahanGelanggangNotifier.new);

class TempahanGelanggangNotifier extends Notifier<TempahanGelanggangState> {
  @override
  TempahanGelanggangState build() {
    getTempahanGelanggang();
    return const TempahanGelanggangStateLoaded();
  }

  TempahanGelanggang? tempahanGelanggang;

  getTempahanGelanggang() async {
    state = TempahanGelanggangStateLoading();
    Future.delayed(const Duration(milliseconds: 150));
    final tempahanGelanggangn = await ref.read(tempahanGelanggangApiServiceProvider).getTempahanGelanggang();
    tempahanGelanggang = tempahanGelanggangn;
    log('Tempahan Gelanggang data length:${tempahanGelanggang?.data.length}');
    state = TempahanGelanggangStateLoaded(
      tempahanGelanggang: ref.read(tempahanGelanggangApiServiceProvider).tempahanGelanggang,
    );
  }
}
