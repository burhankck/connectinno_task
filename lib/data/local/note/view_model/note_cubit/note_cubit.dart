import 'package:connectinno_task/data/local/note/model/note_model.dart';
import 'package:connectinno_task/data/local/note/service/note_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'note_state.dart';

class NoteCubit extends Cubit<NoteState> {
  NoteCubit() : super(NoteInitial());

  final NoteService service = NoteService();
    void loadNotes() {
    emit(NoteLoading());
    try {
      final notes = service.getNotes();
      emit(NoteLoaded(notes));
    } catch (e) {
      emit(NoteError(e.toString()));
    }
  }

  Future<void> addNote(Note note) async {
    await service.addNote(note);
    loadNotes();
  }

  Future<void> updateNote(Note note) async {
    await service.updateNote(note);
    loadNotes();
  }

  Future<void> deleteNote(String id) async {
    await service.deleteNote(id);
    loadNotes();
  }

  Future<void> togglePin(String id) async {
    await service.togglePin(id);
    loadNotes();
  }
}


