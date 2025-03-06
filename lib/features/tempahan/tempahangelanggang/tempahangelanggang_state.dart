import 'package:equatable/equatable.dart';
import 'package:promis/features/tempahan/tempahandewan/tempahandewan.dart';
import 'package:promis/features/tempahan/tempahangelanggang/tempahangelanggang.dart';

sealed class TempahanGelanggangState extends Equatable {
  const TempahanGelanggangState();

  @override
  List<Object?> get props => [];
}

final class TempahanGelanggangStateInitial extends TempahanGelanggangState {}

final class TempahanGelanggangStateLoading extends TempahanGelanggangState {}

final class TempahanGelanggangStateLoaded extends TempahanGelanggangState {
 final TempahanGelanggang? tempahanGelanggang;
  
  const TempahanGelanggangStateLoaded({
    this.tempahanGelanggang,
  });
  @override
  List<Object?> get props => [tempahanGelanggang];
}

final class TempahanGelanggangError extends TempahanGelanggangState {}
