part of 'ads_cubit.dart';

sealed class AdsState extends Equatable {
  const AdsState();

  @override
  List<Object> get props => [];
}

final class AdsInitial extends AdsState {}

final class AddAdsLoading extends AdsState {}

final class AddAdsSuccess extends AdsState {}

final class AddAdsFailure extends AdsState {
  final String errorMessage;

  const AddAdsFailure({required this.errorMessage});
}

//delete Ads:
final class DeleteAdsLoading extends AdsState {}

final class DeleteAdsSuccess extends AdsState {}

final class DeleteAdsFailure extends AdsState {
  final String errorMessage;

  const DeleteAdsFailure({required this.errorMessage});
}

//edit Ads:
final class EditAdsLoading extends AdsState {}

final class EditAdsSuccess extends AdsState {}

final class EditAdsFailure extends AdsState {
  final String errorMessage;

  const EditAdsFailure({required this.errorMessage});
}

//
final class GetAdsLoading extends AdsState {}

final class GetAdsSuccess extends AdsState {}

final class GetAdsFailure extends AdsState {
  final String errorMessage;

  const GetAdsFailure({required this.errorMessage});
}

