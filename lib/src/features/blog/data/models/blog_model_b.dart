import 'package:starter_project/src/features/auth/authentication.dart';
import 'package:starter_project/src/features/blog/data/models/models.dart';
import 'package:starter_project/src/features/blog/domain/entities/blog_b.dart';

class BlogModel extends Blog {
  const BlogModel({
    required super.userAccount,
    required super.id,
    required super.title,
    required super.body,
    required super.createdDateTime,
    required super.lastUpdatedDateTime,
    required super.userAccountId,
    required super.tags,
  });

  factory BlogModel.fromJson(Map<String, dynamic> json) {
    return BlogModel(
      userAccountId: json['userAccountId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
      userAccount: json['userAccount'] != null
          ? UserAccountModel.fromJson(json['userAccount'])
          : null,
      createdDateTime: DateTime.parse(json['createdDateTime']),
      lastUpdatedDateTime: json['lastUpdatedDateTime'] != null
          ? DateTime.parse(json['lastUpdatedDateTime'])
          : null,
      tags:
          (json['tags'] as List).map((tag) => TagModel.fromJson(tag)).toList(),
    );
  }

  @override
  List<Object?> get props => [
        userAccount,
        id,
        title,
        body,
        createdDateTime,
        lastUpdatedDateTime,
        userAccountId,
      ];

  Map<String, dynamic> toJson() {
    return {
      'userAccount': userAccount,
      'id': id,
      'title': title,
      'body': body,
      'createdDateTime': createdDateTime!.toIso8601String(),
      'lastUpdatedDateTime': lastUpdatedDateTime!.toIso8601String(),
      'userAccountId': userAccountId,
    };
  }
}
