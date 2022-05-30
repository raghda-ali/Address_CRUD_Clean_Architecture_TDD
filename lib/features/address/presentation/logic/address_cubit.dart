import 'package:addresscrud_clean_architecture/core/error/failures.dart';
import 'package:addresscrud_clean_architecture/core/usecases/usecase.dart';
import 'package:addresscrud_clean_architecture/core/util/input_converter.dart';
import 'package:addresscrud_clean_architecture/features/address/data/models/address_model.dart';
import 'package:addresscrud_clean_architecture/features/address/domain/use_cases/add_address.dart';
import 'package:addresscrud_clean_architecture/features/address/domain/use_cases/delete_address.dart';
import 'package:addresscrud_clean_architecture/features/address/domain/use_cases/get_addresses.dart';
import 'package:addresscrud_clean_architecture/features/address/domain/use_cases/update_address.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'address_state.dart';

const String serveFailureMessage = 'Server Failure';
const String emptyFailureMessage = 'Empty Failure';
const String unExpectedFailureMessage = 'Un Expected Failure';

class AddressCubit extends Cubit<AddressState> {
  final GetAddress getAddressUseCase;
  final AddAddress addAddressUseCase;
  final UpdateAddress updateAddressUseCase;
  final DeleteAddress deleteAddressUseCase;
  final InputConverter inputConverter;

  AddressCubit({
    required this.getAddressUseCase,
    required this.addAddressUseCase,
    required this.updateAddressUseCase,
    required this.deleteAddressUseCase,
    required this.inputConverter,
  }) : super(AddressInitial());

  Future<void> getAddresses() async {
    emit(AddressLoading());
    final failureOrData = await getAddressUseCase.call(NoParams());
    failureOrData.fold(
        (failure) => emit(AddressError(errorMessage: message(failure))),
        (data) => emit(GetAddressSuccess(addressModel: data)));
    print(state.toString());
  }

  Future<void> addAddress(AddressModel addressModel) async {
    emit(AddressLoading());
    final failureOrSuccess = await addAddressUseCase
        .call(AddAddressUseCaseParams(addressModel: addressModel));
    failureOrSuccess.fold(
        (failure) =>
            emit(const AddressError(errorMessage: serveFailureMessage)),
        (success) => emit(AddAddressSuccess()));
    print(state.toString());
  }

  Future<void> updateAddress(AddressModel addressModel) async {
    emit(AddressLoading());
    final failureOrSuccess = await updateAddressUseCase(
        UpdateAddressUseCaseParams(addressModel: addressModel));
    failureOrSuccess.fold(
        (failure) =>
            emit(const AddressError(errorMessage: serveFailureMessage)),
        (success) => emit(UpdateAddressSuccess()));
    print(state.toString());
  }

  Future<void> deleteAddress(int addressId) async {
    emit(AddressLoading());
    final failureOrSuccess = await deleteAddressUseCase.call(addressId);
    failureOrSuccess.fold(
        (failure) =>
            emit(const AddressError(errorMessage: serveFailureMessage)),
        (success) => emit(const DeleteAddressSuccess()));
    print(state.toString());
  }
}

String message(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure:
      return serveFailureMessage;
    case EmptyFailure:
      return emptyFailureMessage;
    default:
      return unExpectedFailureMessage;
  }
}
