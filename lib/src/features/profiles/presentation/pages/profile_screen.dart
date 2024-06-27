import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:starter_project/src/core/utils/custom_extensions.dart';
import 'package:starter_project/src/features/auth/authentication.dart';
import 'package:starter_project/src/features/blog/presentation/bloc/bloc.dart';

import '../../../../../generated/assets.gen.dart';
import '../../../../../generated/fonts.gen.dart';
import '../../../../core/theme/app_light_theme_colors.dart';
import '../widgets/profile_info_circle.dart';

class ProfileScreen extends StatefulWidget {
  static const String routeName = 'profile-screen';
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return Stack(
            alignment: Alignment.center,
            children: [
              Container(
                color: AppLightThemeColors.kContainerBackgroundColor,
                child: Column(
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    Expanded(
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 500.0,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30.0),
                              topRight: Radius.circular(30.0),
                            ),
                          ),
                          child: Container(
                            margin: const EdgeInsets.all(20),
                            child: Column(
                              children: <Widget>[
                                SizedBox(
                                  height: 7.h,
                                ),
                                Text(
                                  ((context.read<AuthBloc>().state
                                              as AuthSuccess)
                                          .user as UserAccountModel)
                                      .fullName(),
                                  key: const Key('user-name'),
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: FontFamily.nunito,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(
                                    child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      (context.read<AuthBloc>().state
                                              as AuthSuccess)
                                          .user
                                          .email,
                                      key: const Key('user-email'),
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: FontFamily.poppins,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    const Icon(
                                      Icons.verified_outlined,
                                      color: Colors.green,
                                      size: 17,
                                    )
                                  ],
                                )),
                                Divider(
                                  color: AppLightThemeColors.kDarkTextColor,
                                  thickness: 0.2,
                                  indent: 10.w, // Left indent
                                  endIndent: 10.w, // Right indent
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(
                                      0,
                                      MediaQuery.of(context).size.width * 0.06,
                                      0,
                                      MediaQuery.of(context).size.width * 0.06),
                                  child: (context.read<BlogBloc>().state
                                          is BlogSuccess)
                                      ? ProfileInfoCircle(
                                          value: (context.read<BlogBloc>().state
                                                  as BlogSuccess)
                                              .blogs
                                              .length
                                              .toString(),
                                          text: "Blogs",
                                        )
                                      : const ProfileInfoCircle(
                                          value: "0",
                                          text: "Blogs",
                                        ),
                                ),
                              ],
                            ),
                          )),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 12.5.h,
                child: CircleAvatar(
                  backgroundColor: AppLightThemeColors.kProfileBackgroundColor,
                  radius: 7.h,
                  child: Assets.images.superman.path
                      .asAssetImage(width: 23.h)
                      .circularClip(7.5.h),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
