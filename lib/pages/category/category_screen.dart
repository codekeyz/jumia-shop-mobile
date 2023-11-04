import 'package:flutter/material.dart';
import 'package:jumia_shop/features/category_provider.dart';
import 'package:jumia_shop/pages/category/category_item.dart';
import 'package:jumia_shop/server/models/category.dart';
import 'package:jumia_shop/utils/base_provider.dart';
import 'package:jumia_shop/widgets/empty_state_screen.dart';
import 'package:jumia_shop/widgets/loader/loader_screen.dart';
import 'package:jumia_shop/widgets/refresh_wrapper.dart';
import 'package:provider/provider.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  late CategoryProvider _categoryProvider;

  Category? _selectedCategory;

  Future<void> fetchCategories({bool refresh = false}) async {
    await _categoryProvider.fetchCategories(refresh: refresh);

    if (_categoryProvider.categories.isNotEmpty) {
      _selectedCategory ??= _categoryProvider.categories.first;
      setState(() {});
    }
  }

  @override
  void initState() {
    _categoryProvider = context.read<CategoryProvider>();
    super.initState();

    fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    _categoryProvider = context.read<CategoryProvider>();
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text('Categories'),
      ),
      body: StreamBuilder<ProviderEvent>(
        stream: _categoryProvider.stream,
        initialData: _categoryProvider.lastEvent,
        builder: (_, snap) {
          final categories = _categoryProvider.categories
              .where((e) => e.children.isNotEmpty)
              .toList();
          final data = snap.data;

          if (categories.isEmpty) {
            if (data?.state == ProviderState.loading) {
              return LoadingScreen(backgroundColor: Colors.grey.shade400);
            } else if (data?.state == ProviderState.error) {
              return EmptyStateScreen(
                onRefresh: fetchCategories,
                message:
                    data?.message ?? 'An error occurred while fetching data',
              );
            }
          }

          return Row(
            children: [
              SizedBox(
                width: 120,
                child: Container(
                  color: Colors.white,
                  child: ListView.separated(
                    separatorBuilder: (_, i) =>
                        const Divider(thickness: 0.3, height: 0),
                    itemBuilder: (_, index) {
                      final cat = categories[index];
                      return CategoryItemParent(
                        category: categories[index],
                        selected: cat.id == _selectedCategory?.id,
                        onTap: () {
                          setState(() => _selectedCategory = cat);
                        },
                      );
                    },
                    itemCount: categories.length,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () => {},
                      child: Container(
                        color: Colors.white,
                        width: double.maxFinite,
                        padding: const EdgeInsets.symmetric(
                            vertical: 2, horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('SEE ALL PRODUCTS',
                                style: TextStyle(
                                  fontSize: 12,
                                )),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.chevron_right),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Expanded(
                      child: RefreshWrapper(
                        onRefresh: fetchCategories,
                        buildScrollParent: (_) {
                          if (_selectedCategory == null) {
                            return const SingleChildScrollView();
                          }

                          final children = _selectedCategory!.children;

                          return GridView.builder(
                            itemCount: children.length,
                            padding: const EdgeInsets.all(5),
                            primary: false,
                            shrinkWrap: true,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 8,
                              crossAxisSpacing: 8,
                              childAspectRatio: 0.8,
                            ),
                            itemBuilder: (context, index) {
                              final item = children[index];
                              return CategoryItemChild(
                                category: item,
                                onTap: () {},
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
