part of 'tag_bloc.dart';

abstract class TagEvent extends Equatable {
  const TagEvent();

  @override
  List<Object> get props => [];
}
final class CreateTagEvent extends TagEvent {
  final String label;
  final String description;
  const CreateTagEvent({
    required this.label,
    required this.description,
  });
}

final class DeleteTagEvent extends TagEvent {
  final int id;
  const DeleteTagEvent({
    required this.id,
  });
}

final class UpdateTagEvent extends TagEvent {
  final String label;
  final String description;
  final int id;
  const UpdateTagEvent({
    required this.label,
    required this.description,
    required this.id,
  });
}
final class ViewTagsEvent extends TagEvent {
  const ViewTagsEvent();
}
