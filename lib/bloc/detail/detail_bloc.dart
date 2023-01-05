import 'package:bestyamete/models/api_interfaces.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../external/api.dart';

part 'detail_event.dart';
part 'detail_state.dart';
part 'detail_bloc.freezed.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  DetailBloc() : super(const DetailState.initial()) {
    on<_Load>((event, emit) async {
      emit(const DetailState.loading());
      var detalhes = await Api().obterDetalhes(event.id);
      var episodios = await Api().obterListaDeEpisodios(event.id);
      emit(DetailState.loaded(detalhes.first,episodios.reversed.toList()));
    });
  }
}
