part of 'address_cubit.dart';

abstract class AddressState extends Equatable {
  const AddressState();
}

class AddressInitial extends AddressState {
  @override
  List<Object> get props => [];
}

class AddressLoading extends AddressState {
  @override
  List<Object> get props => [];
}

class GetAddressSuccess extends AddressState {
  final List<AddressModel> addressModel;

  const GetAddressSuccess({required this.addressModel});

  @override
  List<Object> get props => [addressModel];
}

class AddressError extends AddressState {
  final String errorMessage;

  const AddressError({required this.errorMessage});

  @override
  List<Object> get props => [];
}

class DeleteAddressSuccess extends AddressState {
  const DeleteAddressSuccess();

  @override
  List<Object> get props => [];
}

class AddAddressSuccess extends AddressState {
  @override
  List<Object> get props => [];
}

class UpdateAddressSuccess extends AddressState {
  @override
  List<Object> get props => [];
}
