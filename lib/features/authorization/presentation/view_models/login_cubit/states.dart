abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginChangeSecureState extends LoginStates {}

class LoginProcessLoadingState extends LoginStates {}

class LoginProcessSuccessState extends LoginStates {}

class LoginProcessErrorState extends LoginStates {}

class ResetForgotPasswordLoadingState extends LoginStates {}

class ResetForgotPasswordSuccessState extends LoginStates {}

class ResetForgotPasswordErrorState extends LoginStates {}
