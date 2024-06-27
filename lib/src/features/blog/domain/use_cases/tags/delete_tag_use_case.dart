import 'package:dartz/dartz.dart';
import 'package:starter_project/src/core/error/failure.dart';
import 'package:starter_project/src/core/use_case/use_cases.dart';
import 'package:starter_project/src/features/blog/domain/repositories/tag_repository.dart';

class DeleteTagParams {
  final int id;

  DeleteTagParams({
    required this.id,
  });
}

class DeleteTagUseCase extends UseCase<String, DeleteTagParams> {
  final TagRepository tagRepository;

  DeleteTagUseCase({
    required this.tagRepository,
  });

  @override
  Future<Either<Failure, String>> call(
      DeleteTagParams params) async {
    return await tagRepository.delete(
      id: params.id,
    );
  }
}