import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:starter_project/src/core/constants/constants.dart';
import 'package:starter_project/src/core/error/error.dart';
import 'package:starter_project/src/features/auth/authentication.dart';
import 'package:starter_project/src/features/blog/data/models/tag_model_b.dart';

abstract class TagRemoteDataSource {
  Future<List<TagModel>> viewAllTags();

   Future<TagModel> create({
    required String label,
    required String description,
  });
  Future<String> delete({
    required int id,
  });
  Future<TagModel> update({
    required int id,
    required String? label,
    required String? description,
  });

}

class TagRemoteDataSourceImpl implements TagRemoteDataSource {
  final http.Client client;
  final Box<LoginReturnModel> box;

  const TagRemoteDataSourceImpl({
    required this.client,
    required this.box,
  });

  @override
  Future<List<TagModel>> viewAllTags() async {
    final token = box.get(Constants.loginReturn)!.token;
    final response = await client.get(
      Uri.parse(Constants.viewTagsAPIEndpoint),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      List<TagModel> tags = data.map<TagModel>((tag) => TagModel.fromJson(tag)).toList();
      return tags;
    } else {
      throw ServerException(errorMessage: 'Tag not found');
    }
  }
  
  @override
  Future<TagModel> create({required String label, required String description}) async{
    final token = box.get(Constants.loginReturn)!.token;
    final response = await client.post(
      Uri.parse(Constants.createTagAPIEndpoint),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
      body: json.encode({
        "label": label,
        "description": description,
      }),
    );
    if (response.statusCode == 200) {
      return TagModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException(errorMessage: response.body);
    }
  }
  
  @override
  Future<String> delete({required int id}) async{
    final token = box.get(Constants.loginReturn)!.token;
    final response = await client.delete(
      Uri.parse('${Constants.deleteBlogAPIEndpoint}$id'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
    if (response.statusCode == 200) {
      return 'Tag deleted successfully';
    } else {
      throw ServerException(errorMessage: response.body);
    }
  }
  
  @override
  Future<TagModel> update({required int id, required String? label, required String? description}) async {
   final token = box.get(Constants.loginReturn)!.token;
    final response = await client.put(
      Uri.parse(Constants.updateBlogAPIEndpoint),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
      body: json.encode({"id": id, "label": label, "description": description}),
    );
    if (response.statusCode == 200) {
      return TagModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException(errorMessage: response.body);
    }
  }
}
