part of 'vaccine_bloc.dart';

@immutable
abstract class VaccineState extends Equatable{}

class VaccineInitial extends VaccineState {
  @override
  // TODO: implement props
  List<Object> get props =>[];

}

class VaccineLoadingState extends VaccineState{
  @override
  // TODO: implement props
  List<Object> get props => [];

}

class VaccineLoadedState extends VaccineState{

  List<vCenters> vacineSessions;


  VaccineLoadedState({@required this.vacineSessions});

  @override
  // TODO: implement props
  List<Object> get props => [];

}

class VaccineErrorState extends VaccineState{

  String message;


  VaccineErrorState({@required this.message});

  @override
  // TODO: implement props
  List<Object> get props => [];

}