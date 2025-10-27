import 'package:connectinno_task/core/constants/app_widget/app_basic_info_card.dart';
import 'package:connectinno_task/core/constants/app_widget/app_delete_dialog.dart';
import 'package:connectinno_task/core/constants/app_widget/app_loading.dart';
import 'package:connectinno_task/core/constants/app_widget/app_search_bar.dart';
import 'package:connectinno_task/core/constants/app_widget/app_snack_bar.dart';
import 'package:connectinno_task/core/constants/app_constant/border_radius_constant.dart';
import 'package:connectinno_task/core/constants/app_constant/color_constant.dart';
import 'package:connectinno_task/core/constants/app_constant/icon_constant.dart';
import 'package:connectinno_task/core/constants/app_constant/image_constant.dart';
import 'package:connectinno_task/core/constants/app_constant/text_style_constant.dart';
import 'package:connectinno_task/core/router_navigation/app_router_name.dart';
import 'package:connectinno_task/features/home/view/screen/widget/update_note_dialog.dart';
import 'package:connectinno_task/features/home/view_model/home_cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connectinno_task/core/constants/app_constant/padding_constant.dart';
import 'package:go_router/go_router.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with _PageProperties {
  @override
  void initState() {
    _initCubits();
    homeCubit.checkInternet();

    super.initState();
  }

  void _initCubits() {
    homeCubit = context.read<HomeCubit>();

    homeCubit.loadInitialNotes();
  }

  void _showDeleteConfirmationDialog(String noteId, String noteTitle) {
    showDialog<bool>(
      context: context,
      builder: (context) => DeleteConfirmationDialog(
        noteTitle: noteTitle,
        onConfirm: () {
          homeCubit.deleteNote(noteId);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,

        actions: [
          BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              bool isOffline = false;

              if (state is HomeDisplay) {
                isOffline = !state.hasInternet;
              } else if (state is HomeError) {
                isOffline = !state.hasInternet;
              }

              return isOffline
                  ? Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Icon(Icons.wifi_off, color: Colors.red),
                    )
                  : const SizedBox.shrink();
            },
          ),
        ],
      ),
      backgroundColor: ColorConstant.instance.grey800,
      body: Padding(
        padding: PaddingConstant.instance.pagePadding,
        child: Column(
          children: [
            AppSearchBar(
              onChanged: (value) {
                homeCubit.searchNotes(query: value);
              },
              searchTextController: homeCubit.searchTextController,
            ),

            BlocListener<HomeCubit, HomeState>(
              listener: (context, state) {
                if (state is HomeDeleteSuccess) {
                  CustomSnackbar.show(
                    context,
                    message: state.message,
                    isSuccess: true,
                    durationSeconds: 3,
                    actionLabel: 'Geri Al',
                    onActionPressed: () {
                      homeCubit.undoDelete();
                    },
                  );
                }
              },
              child: BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  if (state is HomeLoading) {
                    return Expanded(child: const Center(child: AppLoading()));
                  }
                  if (state is HomeDisplay || state is HomeDeleteSuccess) {
                    final notesList = state is HomeDisplay
                        ? state.notesListModel
                        : (state as HomeDeleteSuccess).notesListModel;
                    return Expanded(
                      child: ListView.builder(
                        itemCount: notesList.length,
                        padding: PaddingConstant.instance.onlyTop10,

                        itemBuilder: (context, index) {
                          final notes = notesList[index];
                          return Card(
                            key: ValueKey(notes!.id),
                            color: ColorConstant.instance.blackColor,
                            margin:
                                PaddingConstant.instance.onlyBottomPadding10,

                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadiusConstant.instance.radius20,
                            ),
                            child: ListTile(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (_) => UpdateNoteDialog(
                                    note: notes,
                                    index: index,
                                  ),
                                );
                              },

                              leading: IconButton(
                                icon: IconConstant.pinIcon,
                                color: notes.isPinned
                                    ? ColorConstant.instance.yellowColor
                                    : ColorConstant.instance.whiteColor,

                                onPressed: () {
                                  homeCubit.updateNotePin(
                                    index: index,
                                    newPinStatus: !notes.isPinned,
                                  );
                                },
                              ),
                              trailing: IconButton(
                                icon: IconConstant.deleteIcon,
                                onPressed: () {
                                  _showDeleteConfirmationDialog(
                                    notes.id!,
                                    notes.title,
                                  );
                                },
                              ),
                              contentPadding:
                                  PaddingConstant.instance.allPadding8,

                              title: Text(
                                notes.content,
                                style: TextStyleConstant.bodyLarge700white70,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              subtitle: Padding(
                                padding: PaddingConstant.instance.onlyTop10,

                                child: Text(
                                  notes.title,
                                  style: TextStyleConstant.bodyMediumSize,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  } else if (state is HomeError) {
                    debugPrint("Description: ${state.description}");
                    return BasicInfoWidget(
                      title: state.title,
                      description: state.description,

                      imagePath: ImageConstant.instance.basicInfoImage,
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push(AppRouters.notesAdd).then((value) {
            if (value == true) {
              homeCubit.loadInitialNotes();
            }
          });
        },
        backgroundColor: ColorConstant.instance.blueColor,
        child: IconConstant.addIcon,
      ),
    );
  }
}

mixin _PageProperties {
  HomeCubit homeCubit = HomeCubit();
}
