abstract class UserLoginEvent{}

final class EmailInput extends UserLoginEvent {
  final String email;
  EmailInput(this.email);
  @override
  List<Object> get props => [this.email];
}
final class PasswordInput extends UserLoginEvent {
  final String password;
  PasswordInput(this.password);
  @override
  List<Object> get props => [];
}
final class LoginSubmit extends UserLoginEvent{
  @override
  List<Object> get props => [];
}
final class GoogleLoginEvent extends UserLoginEvent {
  @override
  List<Object> get props => [];
}

final class GoogleLogoutEvent extends UserLoginEvent {
  @override
  List<Object> get props => [];
}
final class FacebookLoginEvent extends UserLoginEvent {
  @override
  List<Object> get props => [];
}

final class FacebookLogoutEvent extends UserLoginEvent {
  @override
  List<Object> get props => [];
}
