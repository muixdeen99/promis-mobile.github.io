import 'package:equatable/equatable.dart';
import 'package:promis/features/tempahan/tempahandewan/tempahandewan.dart';

sealed class TempahanDewanState extends Equatable {
  const TempahanDewanState();

  @override
  List<Object?> get props => [];
}

final class TempahanDewanStateInitial extends TempahanDewanState {}

final class TempahanDewanStateLoading extends TempahanDewanState {}

final class TempahanDewanStateLoaded extends TempahanDewanState {
 final TempahanDewan? tempahanDewan;
  
  const TempahanDewanStateLoaded({
    this.tempahanDewan,
  });
  @override
  List<Object?> get props => [tempahanDewan];
}

final class TempahanDewanError extends TempahanDewanState {}
