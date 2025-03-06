import 'dart:developer';
import 'package:promis/features/tempahan/tempahangelanggangberkelompok/tempahangelanggangberkelompok.dart';
import 'package:promis/features/tempahan/tempahangelanggangberkelompok/tempahangelanggangberkelompok_service.dart';
import 'package:promis/features/tempahan/tempahangelanggangberkelompok/tempahangelanggangberkelompok_state.dart';
import 'package:riverpod/riverpod.dart';

final tempahanGelanggangBerkelompokNotifierProvider =   NotifierProvider<
        TempahanGelanggangBerkelompokNotifier,
        TempahanGelanggangBerkelompokState>(
    TempahanGelanggangBerkelompokNotifier.new);

 class TempahanGelanggangBerkelompokNotifier
    extends Notifier<TempahanGelanggangBerkelompokState> {
  @override
  TempahanGelanggangBerkelompokState build() {
    getTempahanGelanggangBerkelompok();
    return const TempahanGelanggangBerkelompokStateLoaded();
  }

  TempahanGelanggangBerkelompok? tempahanGelanggangBerkelompok;

  getTempahanGelanggangBerkelompok() async {
    state = TempahanGelanggangBerkelompokStateLoading();
    Future.delayed(const Duration(milliseconds: 150));
    final tempahanGelanggangBerkelompok = await ref
        .read(tempahanGelanggangBerkelompokApiServiceProvider)
        .getTempahanGelanggangBerkelompok();
    // tempahanGelanggangBerkelompok = tempahanGelanggangBerkelompokn;
    log('Tempahan Gelanggang Berkelompok data length:${tempahanGelanggangBerkelompok.data.length}');
    state = TempahanGelanggangBerkelompokStateLoaded(
      tempahanGelanggangBerkelompok: ref
          .read(tempahanGelanggangBerkelompokApiServiceProvider)
          .tempahanGelanggangBerkelompok,
    );
  
  }
 
   Future<void> refresh() async {
    state = TempahanGelanggangBerkelompokStateLoading();
    await getTempahanGelanggangBerkelompok();
  }

}
