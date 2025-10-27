import 'package:connectinno_task/core/constants/app_constant/api_constant.dart';
import 'package:connectinno_task/core/services/network_service/network_api_service.dart';
import 'package:connectinno_task/features/home/model/delete_response_model.dart';
import 'package:connectinno_task/features/home/model/notes_list_model.dart';

class HomeService {
  Future<List<NotesListModel?>> getListNotesService() async {
    try {
      final response = await NetworkApiService.instance
          .getApiResponse<NotesListModel>(
            ApiConstant.baseUrl,
            ApiConstant.getListNotesEndPoint,
            isList: true,
          );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<DeleteResponseModel?> deleteNotesService(String id) async {
    try {
      final response = await NetworkApiService.instance
          .deleteApiResponse<DeleteResponseModel>(
            ApiConstant.baseUrl,
            "${ApiConstant.updateNotesEndPoint}/$id",
            isList: false,
          );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<NotesListModel?> addNotesService(Map<String, dynamic> data) async {
    try {
      final response = await NetworkApiService.instance
          .postApiResponse<NotesListModel>(
            ApiConstant.baseUrl,
            ApiConstant.addNotesEndPoint,
            data,
            isList: false,
          );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<NotesListModel?> updateNotesService(
    String id,
    Map<String, dynamic> data,
  ) async {
    try {
      final response = await NetworkApiService.instance
          .putApiResponse<NotesListModel>(
            ApiConstant.baseUrl,
            "${ApiConstant.updateNotesEndPoint}/$id",
            data,
            isList: false,
          );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
