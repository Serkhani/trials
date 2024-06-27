import 'package:dartz/dartz.dart';
import 'package:starter_project/src/core/error/failure.dart';
import 'package:starter_project/src/core/use_case/use_cases.dart';
import 'package:starter_project/src/features/blog/domain/domain.dart';
import 'package:starter_project/src/features/blog/domain/repositories/tag_repository.dart';

class UpdateTagParams {
  final int id;
  final String label;
  final String description;

  UpdateTagParams({
    required this.id,
    required this.label,
    required this.description,
  });
}

class UpdateTagUseCase extends UseCase<Tag, UpdateTagParams> {
  final TagRepository tagRepository;

  UpdateTagUseCase({
    required this.tagRepository,
  });

  @override
  Future<Either<Failure, Tag>> call(
      UpdateTagParams params) async {
    return await tagRepository.update(
      id: params.id,
      label: params.label,
      description: params.description,
    );
  }
}
