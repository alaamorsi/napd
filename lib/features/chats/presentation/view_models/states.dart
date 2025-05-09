abstract class ChatStates {}

class ChatInitialState extends ChatStates {}

class SendMessageLoadingState extends ChatStates {}

class SendMessageSuccessState extends ChatStates {}

class SendMessageErrorState extends ChatStates {}

class GetClientsIdLoadingState extends ChatStates {}

class GetClientsIdSuccessState extends ChatStates {}

class GetClientsIdErrorState extends ChatStates {}

class GetDoctorsIdLoadingState extends ChatStates {}

class GetDoctorsIdSuccessState extends ChatStates {}

class GetDoctorsIdErrorState extends ChatStates {}

class SearchDoctorsLoadingState extends ChatStates {}

class SearchDoctorsSuccessState extends ChatStates {}

class SearchDoctorsErrorState extends ChatStates {}

class SearchClientsLoadingState extends ChatStates {}

class SearchClientsSuccessState extends ChatStates {}

class SearchClientsErrorState extends ChatStates {}

class AddRateLoadingState extends ChatStates {}

class AddRateSuccessState extends ChatStates {}

class AddRateErrorState extends ChatStates {}
