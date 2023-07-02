import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../resources/resources.dart';
import '../../../app.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    InputBorder inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
    );

    return BlocProvider(
      create: (context) => SupportCubit(context),
      child: BlocBuilder<SupportCubit, SupportState>(
        builder: (context, state) {
          var cubit = context.read<SupportCubit>();

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
              title: Text(Res.string.support),
            ),
            body: ListView(
              padding: const EdgeInsets.all(24.0),
              children: [
                Text(
                  Res.string.letUsKnowWhatYouiThink,
                  style: const TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                const SizedBox(height: 24.0),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: Res.string.enterYourMessage,
                    border: inputBorder,
                    enabledBorder: inputBorder,
                  ),
                  maxLines: 6,
                ),
                const SizedBox(height: 24.0),
                ElevatedButton(
                  onPressed: cubit.submit,
                  child: state.loading
                      ? Center(
                          child: CircularProgressIndicator(
                            color: Res.colors.whiteColor,
                          ),
                        ).marginAll(6.0)
                      : Text(
                          Res.string.submit,
                        ).marginAll(16.0),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
