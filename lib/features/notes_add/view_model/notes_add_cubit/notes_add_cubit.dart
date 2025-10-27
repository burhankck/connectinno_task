import 'package:connectinno_task/data/local/note/model/note_model.dart';
import 'package:connectinno_task/features/home/service/home_service.dart';
import 'package:connectinno_task/features/notes_add/model/notes_add_request_model.dart';
import 'package:connectinno_task/features/notes_add/service/notes_add_service.dart';
import 'package:connectinno_task/utils/utils.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';

part 'notes_add_state.dart';

class NotesAddCubit extends Cubit<NotesAddState> with _CubitProperties {
  NotesAddCubit() : super(NotesAddInitial()) {
    initHive();
  }

  Future<void> initHive() async {
    if (!Hive.isBoxOpen('notes')) {
      _noteBox = await Hive.openBox<Note>('notes');
    } else {
      _noteBox = Hive.box<Note>('notes');
    }
  }

  bool hasInternet = true;

  Future<void> checkInternet() async {
    hasInternet = await Utils.checkInternetConnection();
    emit(NotesAddInternetState(hasInternet: hasInternet));
  }

  Future<void> saveNotesAdd() async {
    emit(NotesAddLoading());

    try {
      bool hasInternet = await Utils.checkInternetConnection();

      final request = createRequestModel();

      if (hasInternet) {
        final response = await _notesAddService.postValidateService(
          requestModel: request,
        );

        if (response != null) {
          final noteId = UniqueKey().toString();

          await _noteBox.put(
            UniqueKey().toString(),
            Note(
              id: noteId,
              title: request.title,
              content: request.content,
              isPinned: request.isPinned,
            ),
          );

          emit(
            NotesAddDisplay(isSuccess: true, message: "Başarıyla kaydedildi."),
          );
        } else {
          emit(
            NotesAddDisplay(
              isSuccess: false,
              message: "Kaydetme sırasında sorun oluştu.",
            ),
          );
        }
      } else {
        final offlineNote = Note(
          id: UniqueKey().toString(),
          title: request.title,
          content: request.content,
          isPinned: request.isPinned,
        );
        await _noteBox.put(offlineNote.id, offlineNote);

        emit(NotesAddDisplay(isSuccess: true, message: "Offline kaydedildi."));
      }
    } catch (e) {
      emit(NotesAddError(title: "Hata", description: e.toString()));
    }
  }

  void clear() {
    noteAddController.clear();
    headAddController.clear();
  }

  NotesAddRequestModel createRequestModel() {
    return NotesAddRequestModel(
      title: headAddController.text,
      content: noteAddController.text,
    );
  }
}

mixin _CubitProperties {
  final NotesAddService _notesAddService = NotesAddService();

  late Box<Note> _noteBox;
  TextEditingController noteAddController = TextEditingController();
  TextEditingController headAddController = TextEditingController();
}
