import 'package:connectinno_task/core/constants/app_constant/api_constant.dart';
import 'package:connectinno_task/core/services/network_service/network_api_service.dart';
import 'package:connectinno_task/features/notes_add/model/notes_add_request_model.dart';
import 'package:connectinno_task/features/notes_add/model/notes_add_response_model.dart';

class NotesAddService {

    Future<NotesAddResponseModel?> postValidateService({
    required NotesAddRequestModel requestModel,
  }) async {
    try {
      dynamic response = await NetworkApiService.instance
          .postApiResponse<NotesAddResponseModel>(
            ApiConstant.baseUrl,
            ApiConstant.addNotesEndPoint,
            requestModel.toJson(),
            isList: false,
          );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
