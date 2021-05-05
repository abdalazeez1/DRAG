import 'package:drag/widget/search_person.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class SearchScreen extends StatefulWidget {
  static String routeName = '/searchScreen';

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _textEditingController = TextEditingController();
  String name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('search'),
      ),
      body: Container(
          child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Container(
                    child: TextField(
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                        icon: Icon(Icons.person_search,textDirection: TextDirection.rtl,),

                        fillColor: Colors.red,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(15),
                              bottomRight: Radius.circular(15),
                              topLeft: Radius.circular(15),
                              bottomLeft: Radius.circular(15)
                            )
//                            topLeft: Radius.elliptical(30, 30),
//                            topLeft: Radius.elliptical(30, 30),
                          )),
                      onSubmitted: (val) {
                        setState(() {
                          name = val;
                        });
                      },
                      controller: _textEditingController,
                      keyboardType: TextInputType.text,
                    ),
                  ),
                ),
//                Expanded(
//                  flex: 1,
//                  child: IconButton(
//                    icon: Icon(Icons.person_search_outlined),
//                    onPressed: () async {
//                      name = await Provider.of<ProviderPost>(context,
//                              listen: false)
//                          .search(_textEditingController.text);
//                      setState(() {
//                        // ignore: unnecessary_statements
//                        name;
//                      });
//                    },
//                  ),
//                )
              ],
            ),
          ),
SearchPerson(),
        ],
      )),
    );
  }
}
