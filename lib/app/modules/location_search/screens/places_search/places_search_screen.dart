import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../resources/resources.dart';
import '../../../../app.dart';

class PlacesSearchScreen extends StatelessWidget {
  const PlacesSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PlacesSearchCubit(context),
      child: BlocConsumer<PlacesSearchCubit, PlacesSearchState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = context.read<PlacesSearchCubit>();

          return Scaffold(
            body: SafeArea(
              child: Column(
                children: [
                  /// Search bar
                  SearchBar(
                    controller: cubit.searchController,
                    onSubmitted: cubit.onSubmitted,
                    onChanged: cubit.onChanged,
                    autoFocus: true,
                  ),
                  Expanded(
                    child: state.isSearching
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : state.placesList.isEmpty
                            ? Center(
                                child: Text(Res.string.noDataFound),
                              )
                            : ListView.separated(
                                itemCount: state.placesList.length,
                                separatorBuilder: (context, index) {
                                  return const Divider();
                                },
                                itemBuilder: (context, index) {
                                  var place = state.placesList[index];

                                  return ListTile(
                                    title: Text(place.placeName ?? ''),
                                    onTap: () => cubit.onPlaceTapped(place),
                                  );
                                },
                              ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
