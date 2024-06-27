import 'package:dartz/dartz.dart';
import 'package:starter_project/src/core/error/failure.dart';
import 'package:starter_project/src/core/use_case/use_cases.dart';
import 'package:starter_project/src/features/blog/domain/entities/entities.dart';
import 'package:starter_project/src/features/blog/domain/repositories/tag_repository.dart';

class CreateTagParams {
  final String label;
  final String description;

  CreateTagParams({
    required this.label,
    required this.description,
  });
}

class CreateTagUseCase extends UseCase<Tag, CreateTagParams> {
  final TagRepository tagRepository;

  CreateTagUseCase({
    required this.tagRepository,
  });

  @override
  Future<Either<Failure, Tag>> call(
      CreateTagParams params) async {
    return await tagRepository.create(
      label: params.label,
      description: params.description,
    );
  }
}