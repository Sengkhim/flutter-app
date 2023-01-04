import 'package:flutter/material.dart';

class SearchBuilder extends StatelessWidget {
  const SearchBuilder({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      height: 50,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Colors.grey[300], borderRadius: BorderRadius.circular(10)),
      child: TextFormField(
        cursorColor: Colors.black,
        textAlign: TextAlign.left,
        style: const TextStyle(fontSize: 16.0),
        decoration: const InputDecoration(
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            hintText: 'Search',
            hintStyle: TextStyle(color: Colors.black, fontSize: 16.0),
            icon: Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Icon(
                Icons.search_rounded,
                color: Colors.black,
              ),
            )),
      ),
    );
  }
}
