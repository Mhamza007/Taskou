import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../resources/resources.dart';
import '../../../../../sdk/sdk.dart';
import '../../../../app.dart';

class TrackingScreen extends StatelessWidget {
  const TrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TrackingCubit(context),
      child: BlocConsumer<TrackingCubit, TrackingState>(
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
          var cubit = context.read<TrackingCubit>();

          List<TrackingResponseData>? resultList =
              state.isSearching ? state.filterData : state.trackingData;

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
                Res.string.tracking,
              ),
              actions: [
                TextButton(
                  onPressed: cubit.goToAddChild,
                  child: Text(
                    Res.string.add,
                    style: TextStyle(
                      color: Res.colors.whiteColor,
                    ),
                  ),
                ),
              ],
            ),
            body: Column(
              children: [
                SearchBar(
                  controller: cubit.searchController,
                ),
                Expanded(
                  child: resultList == null || state.loading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : resultList.isEmpty
                          ? Center(
                              child: Text(Res.string.noDataFound),
                            )
                          : ListView.separated(
                              padding: const EdgeInsets.all(16.0),
                              itemCount: resultList.length,
                              separatorBuilder: (context, index) {
                                return const SizedBox(height: 16.0);
                              },
                              itemBuilder: (context, index) {
                                var item = resultList[index];

                                return TrackingItem(
                                  title: item.name ?? '',
                                  relation: item.relation ?? '',
                                  subtitle: item.code ?? '',
                                  shareCode: () {
                                    cubit.shareItem(item);
                                  },
                                  delete: () {
                                    cubit.deleteItem(item);
                                  },
                                  onTap: () {
                                    cubit.openItem(item);
                                  },
                                );
                              },
                            ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
