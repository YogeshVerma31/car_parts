import 'package:car_parts/data/model/chat_model.dart';

abstract class ChatRepository{
  Future<ChatData>? getChatById(String id);
  Future<ChatData>? postChatById(String id,String message);
}