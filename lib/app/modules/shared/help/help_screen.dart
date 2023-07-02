import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../resources/resources.dart';
import '../../../app.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HelpCubit(context),
      child: BlocBuilder<HelpCubit, HelpState>(
        builder: (context, state) {
          var cubit = context.read<HelpCubit>();

          return Scaffold(
            appBar: AppBar(
              leading: InkWell(
                onTap: cubit.back,
                child: SvgPicture.asset(
                  Res.drawable.back,
                  width: 24,
                  height: 24,
                  fit: BoxFit.scaleDown,
                ),
              ),
              title: Text(Res.string.settings),
            ),
            body: ListView(
              children: [
                _buildListTile(
                  title: Res.string.changePassword,
                  onTap: cubit.changePassowrd,
                ),
                const Divider(
                  thickness: 2,
                  height: 0,
                ),
                _buildListTile(
                  title: Res.string.faq,
                ),
                const Divider(
                  thickness: 2,
                  height: 0,
                ),
                _buildListTile(
                  title: Res.string.privacyPolicy,
                ),
                const Divider(
                  thickness: 2,
                  height: 0,
                ),
                _buildListTile(
                  title: Res.string.termsConditions,
                ),
                const Divider(
                  thickness: 2,
                  height: 0,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildListTile({
    required String title,
    Function()? onTap,
  }) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 16.0,
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 8.0,
      ),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: onTap,
    );
  }
}
