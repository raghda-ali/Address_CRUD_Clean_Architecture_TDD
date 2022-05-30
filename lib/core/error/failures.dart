import 'package:equatable/equatable.dart';

class Failure extends Equatable{
  @override
  List<Object?> get props => [];
}
class ServerFailure extends Failure{}
class EmptyFailure extends Failure{}
class NoInternetFailure extends Failure{}
