
import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 50,
      decoration: BoxDecoration(
      color: Colors.amberAccent.withOpacity(0.1),
      borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        onChanged: (value) {
          // serach value
        },
        decoration: InputDecoration
        (
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          hintText: "ابحث هنا ...",
          prefixIcon: Icon(Icons.search),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 9
          )
        )
        ),
    );
  }
}
