import 'package:dartz/dartz.dart';
import 'package:starter_project/src/core/error/failure.dart';
import 'package:starter_project/src/features/blog/data/models/models.dart';
import 'package:starter_project/src/features/blog/domain/entities/entities.dart';

abstract class BlogRepository {
  Future<Either<Failure, Blog>> create({
    required String title,
    required String body,
    required List<TagModel> tags,
  });
  Future<Either<Failure, String>> delete({
    required int id,
  });
  Future<Either<Failure, Blog>> update({
    required int id,
    required String? title,
    required String? body,
    required List<TagModel>? tags,
  });

  Future<Either<Failure, List<Blog>>> viewMyBlogs();
  Future<Either<Failure, List<Blog>>> viewAllBlogs();
  Future<Either<Failure, Blog>> viewBlog(int id);
}
