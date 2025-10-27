import 'package:connectinno_task/data/local/note/model/note_model.dart';
import 'package:connectinno_task/features/home/model/notes_list_model.dart';
import 'package:connectinno_task/features/home/service/home_service.dart';
import 'package:connectinno_task/utils/utils.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> with _CubitProperties {
  HomeCubit() : super(HomeInitial()) {
    init();
  }

  void refreshHome() async {
    emit(HomeLoading());
    await getNotes();
    await loadInitialNotes();
  }

  bool hasInternet = true;
  Future<void> checkInternet() async {
    final result = await Utils.checkInternetConnection();
    hasInternet = result;

    if (state is HomeDisplay) {
      final s = state as HomeDisplay;
      emit(
        HomeDisplay(
          notesListModel: s.notesListModel,
          hasInternet: hasInternet,
          isSearchNotFound: s.isSearchNotFound,
        ),
      );
    } else if (state is HomeError) {
      final s = state as HomeError;
      emit(
        HomeError(
          title: s.title,
          description: s.description,
          hasInternet: hasInternet,
        ),
      );
    } else {
      emit(HomeDisplay(notesListModel: allList, hasInternet: hasInternet));
    }
  }

  Future<void> init() async {
    await initHive();
    await loadInitialNotes();
  }

  Future<void> initHive() async {
    if (!Hive.isBoxOpen('notes')) {
      _noteBox = await Hive.openBox<Note>('notes');
    } else {
      _noteBox = Hive.box<Note>('notes');
    }
  }

  Future<void> deleteNote(String id) async {
    final int index = allList.indexWhere((note) => note?.id == id);
    if (index == -1) return;

    final noteToDelete = allList[index];
    _lastDeletedNote = noteToDelete;

    emit(HomeLoading());

    if (await Utils.checkInternetConnection()) {
      await _homeService
          .deleteNotesService(id)
          .then((_) async {
            allList.removeAt(index);
            tempList = List.from(allList);
            await _noteBox.delete(id);

            if (allList.isEmpty) {
              emit(
                HomeError(
                  title: "Henüz Not Yok",
                  description: "Başlamak için sağ alttaki '+' butonuna basın.",
                ),
              );
            } else {
              emit(
                HomeDeleteSuccess(
                  notesListModel: allList,
                  message: "${noteToDelete?.title} başarıyla silindi.",
                ),
              );
            }
          })
          .onError((error, stackTrace) {
            List<String> splittedList = Utils.normalizationSystemError(error);
            emit(
              HomeError(
                title: splittedList.first,
                description: splittedList.last,
              ),
            );
          });
    } else {
      await _noteBox.delete(id);
      allList.removeAt(index);
      emit(
        HomeDeleteSuccess(
          notesListModel: allList,
          message: "${noteToDelete?.title} (offline) silindi.",
        ),
      );
    }
  }

  Future<void> undoDelete() async {
    if (_lastDeletedNote == null) return;
    emit(HomeLoading());

    final note = _lastDeletedNote!;
    final postData = {
      "title": note.title,
      "content": note.content,
      "is_pinned": note.isPinned,
    };

    if (await Utils.checkInternetConnection()) {
      await _homeService
          .addNotesService(postData)
          .then((_) async {
            _lastDeletedNote = null;
            await getNotes();
          })
          .onError((error, stackTrace) {
            List<String> splittedList = Utils.normalizationSystemError(error);
            emit(
              HomeError(
                title: "Geri Alma Başarısız: ${splittedList.first}",
                description: splittedList.last,
              ),
            );
          });
    } else {
      await _noteBox.put(
        note.id,
        Note(
          id: note.id!,
          title: note.title,
          content: note.content,
          isPinned: note.isPinned,
        ),
      );
      allList.add(note);
      emit(HomeDisplay(notesListModel: allList));
    }
  }

  Future<void> getNotes() async {
    emit(HomeLoading());

    if (await Utils.checkInternetConnection()) {
      await _homeService
          .getListNotesService()
          .then((responseVal) async {
            if (responseVal.isNotEmpty) {
              allList = responseVal;
              tempList = List.from(responseVal);

              await _noteBox.clear();
              for (var note in responseVal) {
                final offlineNote = Note(
                  id: note!.id!,
                  title: note.title,
                  content: note.content,
                  isPinned: note.isPinned,
                );
                await _noteBox.put(note.id, offlineNote);
              }

              emit(HomeDisplay(notesListModel: responseVal, hasInternet: true));
            } else {
              emit(
                HomeError(
                  hasInternet: true,
                  title: "Henüz Not Yok",
                  description: "Başlamak için sağ alttaki '+' butonuna basın.",
                ),
              );
            }
          })
          .onError((error, stackTrace) {
            List<String> splittedList = Utils.normalizationSystemError(error);
            emit(
              HomeError(
                title: splittedList.first,
                description: splittedList.last,
              ),
            );
          });
    } else {
      final offlineNotes = _noteBox.values.toList();
      if (offlineNotes.isNotEmpty) {
        allList = offlineNotes
            .map(
              (note) => NotesListModel(
                id: note.id,
                title: note.title,
                content: note.content,
                isPinned: note.isPinned,
              ),
            )
            .toList();

        tempList = List.from(allList);
        emit(HomeDisplay(notesListModel: allList));
      } else {
        emit(
          HomeError(
            title: "Henüz Not Yok",
            description: "Internet bağlantısı yok ve kaydedilmiş not yok.",
          ),
        );
      }
    }
  }

  Future<void> updateNotePin({
    required int index,
    required bool newPinStatus,
  }) async {
    emit(HomeLoading());

    final currentNote = allList[index];
    final data = {
      "title": currentNote?.title,
      "content": currentNote?.content,
      "is_pinned": newPinStatus,
    };

    if (await Utils.checkInternetConnection()) {
      await _homeService
          .updateNotesService(currentNote!.id!, data)
          .then((responseVal) async {
            if (responseVal is NotesListModel) {
              allList[index] = responseVal;
              allList.sort((a, b) {
                if (a!.isPinned == b!.isPinned) return 0;
                return a.isPinned ? -1 : 1;
              });
              await _noteBox.put(
                responseVal.id,
                Note(
                  id: responseVal.id!,
                  title: responseVal.title,
                  content: responseVal.content,
                  isPinned: responseVal.isPinned,
                ),
              );
              emit(HomeDisplay(notesListModel: allList, hasInternet: true));
            }
          })
          .onError((error, stackTrace) {
            List<String> splittedList = Utils.normalizationSystemError(error);
            emit(
              HomeError(
                hasInternet: true,
                title: splittedList.first,
                description: splittedList.last,
              ),
            );
          });
    } else {
      final offlineNote = _noteBox.get(currentNote!.id!);
      if (offlineNote != null) {
        final updated = offlineNote.copyWith(isPinned: newPinStatus);
        await _noteBox.put(updated.id, updated);

        allList[index] = NotesListModel(
          id: updated.id,
          title: updated.title,
          content: updated.content,
          isPinned: updated.isPinned,
        );
        allList.sort((a, b) {
          if (a!.isPinned == b!.isPinned) return 0;
          return a.isPinned ? -1 : 1;
        });
      }
      emit(HomeDisplay(notesListModel: allList));
    }
  }

  void searchNotes({required String query}) {
    final lowerCaseQuery = query.toLowerCase();

    if (lowerCaseQuery.isEmpty) {
      emit(HomeDisplay(notesListModel: allList));
      return;
    }
    tempList = allList
        .where(
          (note) =>
              note!.title.toLowerCase().contains(lowerCaseQuery) ||
              note.content.toLowerCase().contains(lowerCaseQuery),
        )
        .toList();
    if (tempList.isNotEmpty) {
      emit(HomeDisplay(notesListModel: tempList, isSearchNotFound: false));
    } else {
      emit(HomeDisplay(notesListModel: tempList, isSearchNotFound: true));
    }
  }

  Future<void> updateNote({
    required int index,
    required String newTitle,
    required String newContent,
  }) async {
    emit(HomeLoading());

    final currentNote = allList[index];

    if (await Utils.checkInternetConnection()) {
      final data = {
        "title": newTitle,
        "content": newContent,
        "is_pinned": currentNote?.isPinned ?? false,
      };

      try {
        final responseVal = await _homeService.updateNotesService(
          currentNote!.id!,
          data,
        );
        if (responseVal is NotesListModel) {
          allList[index] = responseVal;

          await _noteBox.put(
            responseVal.id,
            Note(
              id: responseVal.id!,
              title: responseVal.title,
              content: responseVal.content,
              isPinned: responseVal.isPinned,
              isDirty: false,
            ),
          );
        }
      } catch (e) {
        emit(HomeError(title: "Güncelleme Hatası", description: e.toString()));
      }
    } else {
      final offlineNote = _noteBox.get(currentNote!.id!);
      if (offlineNote != null) {
        final updated = offlineNote.copyWith(
          title: newTitle,
          content: newContent,
          isDirty: true,
        );
        await _noteBox.put(updated.id, updated);

        allList[index] = NotesListModel(
          id: updated.id,
          title: updated.title,
          content: updated.content,
          isPinned: updated.isPinned,
        );
      }
    }

    emit(HomeDisplay(notesListModel: allList));
  }

  Future<void> syncOfflineUpdates() async {
    final offlineNotes = _noteBox.values.where((n) => n.isDirty).toList();

    if (offlineNotes.isEmpty) return;

    for (var note in offlineNotes) {
      final data = {
        "title": note.title,
        "content": note.content,
        "is_pinned": note.isPinned,
      };

      await _homeService
          .updateNotesService(note.id!, data)
          .then((responseVal) async {
            if (responseVal is NotesListModel) {
              await _noteBox.put(
                responseVal.id,
                Note(
                  id: responseVal.id!,
                  title: responseVal.title,
                  content: responseVal.content,
                  isPinned: responseVal.isPinned,
                  isDirty: false,
                ),
              );
            }
          })
          .onError((error, stackTrace) async {
            List<String> splittedList = Utils.normalizationSystemError(error);
            emit(
              HomeError(
                title: splittedList.first,
                description: splittedList.last,
              ),
            );
          });
    }
  }

  Future<void> loadInitialNotes() async {
    emit(HomeLoading());

    try {
      hasInternet = await Utils.checkInternetConnection();

      if (hasInternet) {
        await syncOfflineUpdates();
        await getNotes();

        final noteBox = Hive.box<Note>('notes');
        await noteBox.clear();
        for (var item in allList) {
          final note = Note(
            id: item!.id!,
            title: item.title,
            content: item.content,
            isPinned: item.isPinned,
          );
          await noteBox.put(note.id, note);
        }
      } else {
        final noteBox = Hive.box<Note>('notes');
        final offlineNotes = noteBox.values.toList();
        await Future.delayed(const Duration(milliseconds: 300));

        if (offlineNotes.isNotEmpty) {
          allList = offlineNotes
              .map(
                (n) => NotesListModel(
                  id: n.id,
                  title: n.title,
                  content: n.content,
                  isPinned: n.isPinned,
                ),
              )
              .toList();
          emit(HomeDisplay(notesListModel: allList));
        } else {
          emit(
            HomeError(
              title: "Henüz Not Yok",
              description:
                  "İnternet bağlantısı yok ve yerel veriniz bulunamadı.",
            ),
          );
        }
      }
    } catch (e) {
      emit(HomeError(title: "Bir hata oluştu", description: e.toString()));
    }
  }
}

mixin _CubitProperties {
  final HomeService _homeService = HomeService();
  late Box<Note> _noteBox;

  List<NotesListModel?> tempList = [];
  List<NotesListModel?> allList = [];
  NotesListModel? _lastDeletedNote;

  TextEditingController searchTextController = TextEditingController();
}
