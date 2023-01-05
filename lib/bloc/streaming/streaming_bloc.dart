import 'package:bestyamete/external/api.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:bestyamete/models/api_interfaces.dart';
import 'dart:developer' as developer;
part 'streaming_event.dart';
part 'streaming_state.dart';
part 'streaming_bloc.freezed.dart';

class StreamingBloc extends Bloc<StreamingEvent, StreamingState> {
  StreamingBloc() : super(const StreamingState.initial()) {
    on<_Load>((event, emit) async {
      emit(const StreamingState.loading());
      developer.log(event.id);
      var episode = await Api().obterDadosDeStreaming(event.id);
      var nextEpisode = await Api().obterDadosStreamingProximoEpisodio(event.id, episode[0].categoryId.toString());
      if(nextEpisode.isEmpty){
        emit(StreamingState.loaded(episode.first, Stream()));
      }else{
        emit(StreamingState.loaded(episode.first, nextEpisode.first));
      }

    });
  }
}
