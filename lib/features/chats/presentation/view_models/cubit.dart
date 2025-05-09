import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nabd/core/variables/constant_variables.dart';
import 'package:nabd/features/chats/data/models/message_model.dart';
import 'package:nabd/features/chats/data/models/rate_model.dart';
import 'package:nabd/features/chats/data/repo/add_rate_method.dart';
import 'package:nabd/features/chats/data/repo/chat_get_clients.dart';
import 'package:nabd/features/chats/data/repo/chat_get_doctors.dart';
import 'package:nabd/features/chats/data/repo/chat_get_messages.dart';
import 'package:nabd/features/chats/data/repo/chat_send_message.dart';
import 'package:nabd/features/chats/presentation/view_models/states.dart';

class ChatCubit extends Cubit<ChatStates> {
  ChatCubit() : super(ChatInitialState());
  static ChatCubit of(BuildContext context) => BlocProvider.of(context);
  final ScrollController scrollController = ScrollController();

  Future<void> sendMessage(String receiverId, String message, String name , int imageUrl) async {
    emit(SendMessageLoadingState());
    try {
      await ChatSendMessageStates.sendMessage(receiverId, message, name, imageUrl);
      emit(SendMessageSuccessState());
    } catch (e) {
      print('Error sending message: $e');
      emit(SendMessageErrorState());
    }
  }

  Stream<List<MessageModel>> getMessagesStream(
    String userId,
    String receiverId,
  ) {
    try {
      return ChatGetMessagesStates.getMessages(userId, receiverId);
    } catch (e) {
      print('Error getting messages: $e');
      return Stream.empty();
    }
  }

  List<Map<String, dynamic>> clients = [];
  Future<void> getClients() async {
    emit(GetClientsIdLoadingState());
    try {
      clients = await ChatGetClients.getClientsInfo(ConstantVariables.uId);
      emit(GetClientsIdSuccessState());
    } catch (e) {
      print('Error getting clients : $e');
      emit(GetClientsIdErrorState());
    }
  }

  Future<void> searchChatClients({required String query}) async {
    emit(SearchClientsLoadingState());
    try {
      List<Map<String, dynamic>> clientsList =
          await ChatGetClients.getClientsInfo(ConstantVariables.uId);
      query = query.toLowerCase();
      clients =
          clientsList.where((client) {
            final nameClient = client['name'].toLowerCase().contains(query);
            return nameClient;
          }).toList();
      emit(SearchClientsSuccessState());
    } catch (e) {
      print('Error searching Clients: $e');
      emit(SearchClientsErrorState());
    }
  }

  List<DoctorInfo> doctors = <DoctorInfo>[];
  Future<void> getDoctors() async {
    emit(GetDoctorsIdLoadingState());
    try {
      doctors = await ChatGetDoctorsStates.getDoctorsInfo(
        ConstantVariables.guestuId,
      );
      emit(GetDoctorsIdSuccessState());
    } catch (e) {
      print('Error getting doctors : $e');
      emit(GetDoctorsIdErrorState());
    }
  }

  Future<void> searchChatDoctors({required String query}) async {
    emit(SearchDoctorsLoadingState());
    try {
      List<DoctorInfo> doctorsList = await ChatGetDoctorsStates.getDoctorsInfo(
        ConstantVariables.guestuId,
      );
      query = query.toLowerCase();
      doctors =
          doctorsList.where((doctor) {
            final nameMatch = doctor.name.toLowerCase().contains(query);
            final specialtyMatch = doctor.specialty.toLowerCase().contains(
              query,
            );
            return nameMatch || specialtyMatch;
          }).toList();
      emit(SearchDoctorsSuccessState());
    } catch (e) {
      print('Error searching doctors: $e');
      emit(SearchDoctorsErrorState());
    }
  }

  Future<void> addRateMethod(String receiverId, String rate) async {
    emit(AddRateLoadingState());
    try {
      RateModel rateModel = RateModel(
        senderId: ConstantVariables.guestuId,
        rate: rate,
      );
      await AddRateMethod.addRateMethod(
        receiverId: receiverId,
        rateModel: rateModel,
      );
      emit(AddRateSuccessState());
    } catch (e) {
      print('Error adding rate: $e');
      emit(AddRateErrorState());
    }
  }
}
