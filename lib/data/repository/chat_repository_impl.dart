import 'dart:io';

import 'package:car_parts/data/model/chat_model.dart';
import 'package:car_parts/data/repository/chat_repository.dart';
import 'package:car_parts/providers/network/apis/chat_api.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:http/http.dart';

import '../../constants/firestore_constants.dart';
import '../../utils/failure.dart';
import '../../utils/typedef.dart';

class ChatRepositoryImpl implements ChatRepository {
  @override
  EitherRequest2<Stream<QuerySnapshot<Object?>>>? fetchAllChats(
      int limit, FirebaseFirestore firebaseFirestore, String documentId) {
    try {
      var result = firebaseFirestore
          .collection(FirestoreConstants.pathOrdersCollection)
          .doc(documentId)
          .collection(FirestoreConstants.pathChatCollection)
          .orderBy(FirestoreConstants.timestamp, descending: true)
          .limit(limit)
          .snapshots();
      return right(result);
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }

  @override
  EitherRequest2<Stream<QuerySnapshot<Object?>>>? fetchPaymentStatus(
      int limit, FirebaseFirestore firebaseFirestore, String documentId) {
    try {
      var result = firebaseFirestore
          .collection(FirestoreConstants.pathOrdersCollection)
          .doc(documentId)
          .collection(FirestoreConstants.pathOrderPaymentCollection)
          .limit(limit)
          .snapshots();
      return right(result);
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }

  @override
  EitherRequest<String>? uploadImage(
      dynamic imageFile,
      int limit,
      FirebaseFirestore firebaseFirestore,
      FirebaseStorage firebaseStorage) async {
    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();

      Reference reference = firebaseStorage.ref().child(fileName);
      UploadTask uploadTask = reference.putFile(File(imageFile.path));
      TaskSnapshot snapshot = await uploadTask;
      String imageUrl = await snapshot.ref.getDownloadURL();

      return right(imageUrl);
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }


}
