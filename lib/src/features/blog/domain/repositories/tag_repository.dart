import 'package:dartz/dartz.dart';
import 'package:starter_project/src/core/error/error.dart';
import 'package:starter_project/src/features/blog/domain/entities/tag_b.dart';

abstract class TagRepository {
  Future<Either<Failure, List<Tag>>> viewAllTags();

   Future<Either<Failure, Tag>> create({
    required String label,
    required String description,
  });
  Future<Either<Failure, String>> delete({
    required int id,
  });
  Future<Either<Failure, Tag>> update({
    required int id,
    required String? label,
    required String? description,
  });
}
