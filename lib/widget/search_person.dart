import 'package:flutter/material.dart';

class SearchPerson extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: ListTile(
        title: Text('Abd Alazeez'),
        leading: CircleAvatar(
          backgroundColor: Colors.grey,
        ),
        trailing: Icon(
          Icons.navigate_next_rounded,
          color: Theme.of(context).primaryColor,
          size: 25,
        ),
      ),
    );
  }
}
