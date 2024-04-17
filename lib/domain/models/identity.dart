import 'package:equatable/equatable.dart';

/// I did not build an authentication system for this demonstration
/// so this constant variable is used as the "pretend" authenticated
/// device user. Normally, this variable would be part of some BloC
/// state that can be access globally by application components.
const Identity defaultUser = Identity(id: "0123456789", username: "dev", name: "Flutter User");

/// Represents the identity of the device user.
final class Identity extends Equatable {
  final String id;
  final String username;
  final String name;

  const Identity({
    required this.id,
    required this.username,
    required this.name,
  });

  @override
  List<Object> get props => [
    id,
    username,
    name,
  ];
}
