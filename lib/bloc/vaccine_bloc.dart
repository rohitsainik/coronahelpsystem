import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:coronahelpsystem/model/vaccine.dart';
import 'package:coronahelpsystem/repo/vaccinerepo.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'vaccine_event.dart';
part 'vaccine_state.dart';

class VaccineBloc extends Bloc<VaccineEvent, VaccineState> {

  VaccineRepository vaccineRepository;



  VaccineBloc({@required this.vaccineRepository}) : super(VaccineInitial());

  @override
  Stream<VaccineState> mapEventToState(
    VaccineEvent event,
  ) async* {
    if(event is FetchVaccineEvents){
      yield VaccineLoadingState();
      try{
        List<vCenters> vaccine = await vaccineRepository.getVaccineSlots();
        yield VaccineLoadedState(vacineSessions: vaccine);
      }
      catch(e){
        yield VaccineErrorState(message: e.toString());
      }
    }

  }
}
