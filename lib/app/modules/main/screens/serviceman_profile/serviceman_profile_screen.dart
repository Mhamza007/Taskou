import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../resources/resources.dart';
import '../../../../app.dart';

class ServicemanProfileScreen extends StatelessWidget {
  const ServicemanProfileScreen({
    super.key,
    required this.data,
  });

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ServicemanProfileCubit(
        context,
        data: data,
      ),
      child: BlocBuilder<ServicemanProfileCubit, ServicemanProfileState>(
        builder: (context, state) {
          var cubit = context.read<ServicemanProfileCubit>();

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
              title: Text(
                state.title,
              ),
            ),
            body: ServicemanProfile(
              imageUrl: state.browseServiceData?.profileImg,
              title:
                  '${state.browseServiceData?.firstName} ${state.browseServiceData?.lastName}',
              location:
                  '${state.browseServiceData?.city}, ${state.browseServiceData?.province}',
              certified: state.browseServiceData?.certFront?.isNotEmpty == true,
              ratePerHour: state.browseServiceData?.price?.isNotEmpty == true
                  ? '${state.browseServiceData?.price}\$/hour'
                  : 'NA',
              jobs: '${state.browseServiceData?.getJobs ?? 0} Jobs',
              rating: state.browseServiceData?.ratings,
              viewProfile: () {},
              book: cubit.book,
            ),
          );
        },
      ),
    );
  }
}
