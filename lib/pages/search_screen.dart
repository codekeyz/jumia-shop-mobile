import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:jumia_shop/features/search_provider.dart';
import 'package:jumia_shop/pages/category/category_item.dart';
import 'package:jumia_shop/pages/product/product_item.dart';
import 'package:jumia_shop/server/models/category.dart';
import 'package:jumia_shop/server/models/search.dart';
import 'package:jumia_shop/utils/base_provider.dart';
import 'package:jumia_shop/widgets/empty_state_screen.dart';
import 'package:jumia_shop/widgets/loader/loader_screen.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  final SearchInput? input;
  const SearchScreen({
    Key? key,
    this.input,
  }) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late SearchProvider _searchProvider;
  final TextEditingController _searchTextCtrl = TextEditingController();

  SearchInput? _searchInput;

  Future<void> startSearch({SearchInput? input}) async {
    if (input != null) _searchInput = input;
    if (_searchInput == null) return;

    await _searchProvider.search(_searchInput!);
  }

  void reset() {
    _searchInput = null;
    _searchTextCtrl.clear();
    _searchProvider.clear();
  }

  @override
  void initState() {
    _searchProvider = context.read<SearchProvider>();
    super.initState();

    if (widget.input != null) {
      startSearch(input: widget.input);
    }
  }

  @override
  Widget build(BuildContext context) {
    _searchProvider = context.read<SearchProvider>();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: ValueListenableBuilder<TextEditingValue>(
          valueListenable: _searchTextCtrl,
          builder: (_, textVal, c) {
            final searchText = textVal.text;
            return TextField(
              autofocus: true,
              controller: _searchTextCtrl,
              onSubmitted: (text) {
                if (text.trim().isEmpty) return;

                startSearch(input: SearchInput(term: text));
              },
              decoration: InputDecoration(
                hintText: 'Searching for products, brands',
                border: const OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
                filled: true,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                prefixIcon:
                    searchText.isEmpty ? const Icon(Icons.search) : null,
                suffixIcon: GestureDetector(
                  child: const Icon(Icons.close),
                  onTap: () {
                    if (searchText.isNotEmpty) {
                      reset();
                      return;
                    }
                  },
                ),
              ),
            );
          },
        ),
      ),
      body: StreamBuilder<ProviderEvent<SearchResponse?>>(
        stream: _searchProvider.stream,
        initialData: _searchProvider.lastEvent,
        builder: (_, snap) {
          final data = snap.data;
          final result = data?.data;

          if (result == null ||
              (result.items.isEmpty && result.categories.isEmpty)) {
            if (data?.state == ProviderState.loading) {
              return LoadingScreen(backgroundColor: Colors.grey.shade400);
            }

            if (_searchInput != null) {
              return EmptyStateScreen(
                onRefresh: () {},
                message:
                    data?.message ?? 'No search results returned from server',
              );
            }

            return const SizedBox.shrink();
          }

          final allItems = [
            ...result.items,
            if (widget.input?.collectionId == null) ...result.categories
          ]..shuffle();

          return MasonryGridView.count(
            padding: const EdgeInsets.all(16),
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            itemCount: allItems.length,
            itemBuilder: (_, index) {
              final item = allItems[index];

              if (item is SearchResult) {
                return SizedBox(
                  height: 200,
                  width: double.infinity,
                  child: ProductSearchItem(
                    result: item,
                    onTap: () {},
                  ),
                );
              }

              if (item is Category) {
                return SizedBox(
                  height: 100,
                  child: CategoryItemChild(
                    category: item,
                    onTap: () {},
                  ),
                );
              }

              return const SizedBox.shrink();
            },
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _searchTextCtrl.dispose();
    super.dispose();
  }
}
