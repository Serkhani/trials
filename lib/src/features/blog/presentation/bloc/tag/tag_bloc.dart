import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter_project/src/core/use_case/use_case.dart';
import 'package:starter_project/src/features/blog/domain/entities/tag_b.dart';
import 'package:starter_project/src/features/blog/domain/use_cases/tags/create_tag_use_case.dart';
import 'package:starter_project/src/features/blog/domain/use_cases/tags/delete_tag_use_case.dart';
import 'package:starter_project/src/features/blog/domain/use_cases/tags/update_tag_use_case.dart';
import 'package:starter_project/src/features/blog/domain/use_cases/tags/view_all_tags_use_case_b.dart';

part 'tag_event.dart';
part 'tag_state.dart';

class TagBloc extends Bloc<TagEvent, TagState> {
  final ViewTagsUseCase _viewTagsUseCase;
  final UpdateTagUseCase _updateTagUseCase;
  final DeleteTagUseCase _deleteTagUseCase;
  final CreateTagUseCase _createTagUseCase;
  

  TagBloc({
    required ViewTagsUseCase viewTagsUseCase,
    required UpdateTagUseCase updateTagUseCase,
    required CreateTagUseCase createTagUseCase,
    required DeleteTagUseCase deleteTagUseCase,
  })  : _viewTagsUseCase = viewTagsUseCase,
        _updateTagUseCase = updateTagUseCase,
        _createTagUseCase = createTagUseCase,
        _deleteTagUseCase = deleteTagUseCase,
        super(TagInitial()) {
    on<ViewTagsEvent>(_onViewTags);
    on<CreateTagEvent>(_onCreateTag);
    on<UpdateTagEvent>(_onUpdateTag);
    on<DeleteTagEvent>(_onDeleteTag);
  }


  FutureOr<void> _onViewTags(
      ViewTagsEvent event, Emitter<TagState> emit) async {
    final res = await _viewTagsUseCase(NoParams());
    res.fold(
      (failure) => emit(TagFailure(failure.errorMessage)),
      (tags) => emit(TagSuccess(tags)),
    );
    return null;
  }

  FutureOr<void> _onCreateTag(CreateTagEvent event, Emitter<TagState> emit) async{
      final res = await _createTagUseCase(
      CreateTagParams(label: event.label, description: event.description),
    );

    res.fold(
      (failure) => emit(TagFailure(failure.errorMessage)),
      (blog) => emit(TagCreated()),
    );
    return null;
  }

  FutureOr<void> _onUpdateTag(UpdateTagEvent event, Emitter<TagState> emit) async{
    emit(TagSaving());
    final res = await _updateTagUseCase(
      UpdateTagParams(
        id: event.id,
        label: event.label,
        description: event.description,
      ),
    );

    res.fold(
      (failure) => emit(TagFailure(failure.errorMessage)),
      (blog) => emit(TagUpdated()),
    );
    return null;
  }

  FutureOr<void> _onDeleteTag(DeleteTagEvent event, Emitter<TagState> emit)async {
       final res = await _deleteTagUseCase(
      DeleteTagParams(
        id: event.id,
      ),
    );

    res.fold(
      (failure) => emit(TagDeleteFailure(failure.errorMessage)),
      (message) => emit(TagDeleted(message)),
    );
    return null;
  }

}
