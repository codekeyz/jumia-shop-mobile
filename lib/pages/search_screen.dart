import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchTextCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: ValueListenableBuilder<TextEditingValue>(
            valueListenable: _searchTextCtrl,
            builder: (_, textVal, c) {
              final searchText = textVal.text;
              return TextField(
                autofocus: true,
                controller: _searchTextCtrl,
                decoration: InputDecoration(
                  hintText: 'Searching for a job?',
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(width: 0, style: BorderStyle.none),
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
                        _searchTextCtrl.clear();
                        return;
                      }

                      AutoRouter.of(context).pop();
                    },
                  ),
                ),
              );
            },
          )),
    );
  }

  @override
  void dispose() {
    _searchTextCtrl.dispose();
    super.dispose();
  }
}
