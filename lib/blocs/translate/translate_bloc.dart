import 'package:buai/blocs/translate/translate_event.dart';
import 'package:buai/blocs/translate/translate_state.dart';
import 'package:buai/services/ai_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TranslateBloc extends Bloc<TranslateEvent, TranslateState> {
  TranslateBloc() : super(TranslateInitial()) {
    on<TranslateRequestedEvent>(_translate);
    on<TranslateResetEvent>(_reset);
  }

  Future<void> _translate(
    TranslateRequestedEvent event,
    Emitter<TranslateState> emit,
  ) async {
    try {
      emit(TranslateLoading());

      final translate = await AiServices.translateText(
        from: event.fromLanguage,
        to: event.toLanguage,
        text: event.text,
      );

      emit(TranslateLoaded(translatedText: translate.translatedText ?? ''));
    } catch (e) {
      emit(TranslateError(e.toString()));
    }
  }

  Future<void> _reset(
    TranslateResetEvent event,
    Emitter<TranslateState> emit,
  ) async {
    emit(TranslateInitial());
  }
}
