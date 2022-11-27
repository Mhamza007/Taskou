import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../resources/resources.dart';
import '../../../../app.dart';

class BrowseServiceScreen extends StatelessWidget {
  const BrowseServiceScreen({
    super.key,
    required this.data,
  });

  final Map data;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BrowseServiceCubit(
        context,
        categoryData: data,
      ),
      child: BlocConsumer<BrowseServiceCubit, BrowseServiceState>(
        listenWhen: (prev, curr) =>
            prev.apiResponseStatus != curr.apiResponseStatus,
        listener: (context, state) {
          switch (state.apiResponseStatus) {
            case ApiResponseStatus.failure:
              Helpers.errorSnackBar(
                context: context,
                title: state.message,
              );
              break;
            default:
          }
        },
        builder: (context, state) {
          var cubit = context.read<BrowseServiceCubit>();

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
                Res.string.availableServicemen,
                style: const TextStyle(
                  fontSize: 16.0,
                ),
              ),
              centerTitle: true,
            ),
            body: state.browseServiceData == null
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : state.browseServiceData!.isEmpty
                    ? Center(
                        child: Text(
                          Res.string.noDataFound,
                          style: const TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                      )
                    : ListView.separated(
                        padding: const EdgeInsets.all(16.0),
                        itemCount: state.browseServiceData!.length,
                        separatorBuilder: (context, index) {
                          return const SizedBox(height: 16.0);
                        },
                        itemBuilder: (context, index) {
                          var serviceData = state.browseServiceData![index];
                          return AvailableServicemanItem(
                            imageUrl: serviceData.profileImg,
                            title:
                                '${serviceData.firstName} ${serviceData.lastName}',
                            location:
                                '${serviceData.city}, ${serviceData.province}',
                            certified:
                                serviceData.certFront?.isNotEmpty == true,
                            ratePerHour: serviceData.price?.isNotEmpty == true
                                ? '${serviceData.price}\$/hour'
                                : 'NA',
                            jobs: '${serviceData.getJobs ?? 0} Jobs',
                            rating: serviceData.ratings,
                            viewProfile: () {},
                            book: () {},
                          );
                        },
                      ),
          );
        },
      ),
    );
  }
}
