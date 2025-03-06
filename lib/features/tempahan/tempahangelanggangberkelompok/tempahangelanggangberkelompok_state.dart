import 'package:equatable/equatable.dart';
import 'package:promis/features/tempahan/tempahandewan/tempahandewan.dart';
import 'package:promis/features/tempahan/tempahangelanggang/tempahangelanggang.dart';
import 'package:promis/features/tempahan/tempahangelanggangberkelompok/tempahangelanggangberkelompok.dart';

sealed class TempahanGelanggangBerkelompokState extends Equatable {
  const TempahanGelanggangBerkelompokState();

  @override
  List<Object?> get props => [];
}

final class TempahanGelanggangBerkelompokStateInitial extends TempahanGelanggangBerkelompokState {}

final class TempahanGelanggangBerkelompokStateLoading extends TempahanGelanggangBerkelompokState {}

final class TempahanGelanggangBerkelompokStateLoaded extends TempahanGelanggangBerkelompokState {
 final TempahanGelanggangBerkelompok? tempahanGelanggangBerkelompok;
  
  const TempahanGelanggangBerkelompokStateLoaded({
    this.tempahanGelanggangBerkelompok,
  });
  @override
  List<Object?> get props => [tempahanGelanggangBerkelompok];
}

final class TempahanGelanggangBerkelompokError extends TempahanGelanggangBerkelompokState {}
