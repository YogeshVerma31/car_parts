import 'package:car_parts/data/model/chat_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../utils/typedef.dart';

abstract class ChatRepository{
  EitherRequest2<Stream<QuerySnapshot>>? fetchAllChats(
      int limit, FirebaseFirestore firebaseFirestore, String documentId);


  EitherRequest<String>? uploadImage(dynamic imageFile,
      int limit, FirebaseFirestore firebaseFirestore,FirebaseStorage firebaseStorage);
}