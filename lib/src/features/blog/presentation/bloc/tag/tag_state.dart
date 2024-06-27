part of 'tag_bloc.dart';

final class TagFailure extends TagState {
  final String message;
  const TagFailure(this.message);
}

class TagInitial extends TagState {}

final class TagLoading extends TagState {}


abstract class TagState extends Equatable {
  const TagState();

  @override
  List<Object> get props => [];
}
final class TagSuccess extends TagState {
  final List<Tag> tags;
  const TagSuccess(this.tags);
}
final class TagDeleted extends TagState {
  final String message;
  const TagDeleted(this.message);
}
final class TagCreated extends TagState {}


final class TagUpdated extends TagState {}

final class TagSaving extends TagState {}

final class TagDeleteFailure extends TagFailure {
  const TagDeleteFailure(super.message);
}