import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter_project/src/core/utils/custom_extensions.dart';
import 'package:starter_project/src/core/widgets/widgets.dart';
import 'package:starter_project/src/features/blog/presentation/bloc/bloc.dart';

class AllBlogs extends StatefulWidget {
  const AllBlogs({super.key});

  @override
  State<AllBlogs> createState() => _AllBlogsState();
}

class _AllBlogsState extends State<AllBlogs> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BlogBloc, BlogState>(
      listener: (context, state) {
        // if (state is ViewBlog) {
        //   context.read<BlogBloc>().add(ViewAllBlogsEvent());
        // }
      },
      builder: (context, state) {
        print(state);
        return (state is ViewBlogs)
            ? (state.blogs.isEmpty)
                ? Center(
                    child: Text(
                      'No tags found',
                      style: context.textTheme.bodySmall!.copyWith(
                        color: Colors.red,
                      ),
                    ),
                  )
                : ListView.builder(
                    primary: false,
                    shrinkWrap: true,
                    itemCount: state.blogs.length ,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return BlogCard(blog: state.blogs[index])
                          .onlyPadding(0, 10.0, 20.0, 20.0);
                    },
                  )
            : (state is BlogLoading)
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Center(
                    child: Text(
                      'Failed to load blogs',
                      style: context.textTheme.bodySmall!,
                    ),
                  );
      },
    );
  }

  @override
  void initState() {
    context.read<BlogBloc>().add(ViewAllBlogsEvent());
    super.initState();
  }
}
