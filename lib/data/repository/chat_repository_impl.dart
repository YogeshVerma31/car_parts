import 'package:car_parts/data/model/chat_model.dart';
import 'package:car_parts/data/repository/chat_repository.dart';
import 'package:car_parts/providers/network/apis/chat_api.dart';

class ChatRepositoryImpl implements ChatRepository {
  @override
  Future<ChatData>? getChatById(String id) async {
    final response = await ChatApi(
      id: id,
      type: chatType.GET,
    ).request();
    return ChatData.fromJson(response);
  }

  @override
  Future<ChatData>? postChatById(String id, String message) async {
    final response =
        await ChatApi(id: id, message: message, type: chatType.POST).request();
    return ChatData.fromJson(response);
  }
}
