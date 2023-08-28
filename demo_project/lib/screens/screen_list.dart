import 'package:demo_project/models/list_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:demo_project/models/list_data.dart';
import 'package:flutter/material.dart';
import 'package:demo_project/models/list_provider.dart';


class MyList extends StatefulWidget {
  const MyList({Key? key}) : super(key: key);

  @override
  State<MyList> createState() => _MyListState();
}

class _MyListState extends State<MyList> {

  bool _isLoading = false;

  //List<dynamic> dataList = [];





  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<listProvider>(context, listen: false).getAll();
    });

    fetchData();
  }

  Future<void> fetchData() async {
    try {

     // final data = await getListData();

      setState(() {

      // dataList = data;
        _isLoading = true;
      });

      await Future.delayed(Duration(seconds: 2));
      setState(() {
        _isLoading = false;
      });
    } catch (error) {
      print('Error: $error');

    }
  }

  void logoutUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //prefs?.clear();
    await prefs.setBool('isLoggedIn', false);
    Navigator.pushReplacementNamed(context, '/screen_login');
  }



  @override
  Widget build(BuildContext context) {
    return  Scaffold(
              appBar: AppBar(
                title: Text('List', style: Theme.of(context).textTheme.displayLarge,),
                backgroundColor: Colors.yellow,
                centerTitle: true,
                actions: [
                  IconButton(
                      onPressed: () {
                        logoutUser();
                      },
                      icon: Icon(Icons.logout))
                ],
              ),
              body: Consumer<listProvider>(
                  builder:(context,value,child){
                    return Center(
                      child: value.isLoding ? CircularProgressIndicator() :
                      Padding(
                            padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: Center(

                          child: ListView.builder(
                            itemCount: value.userList.length,
                              itemBuilder: (context, index) {
                              final user = value.userList[index];

                                return Column(
                                children: [
                                  ListTile(
                                  leading: CircleAvatar(
                                  child: Image.network(user['avatar'] ?? ''),),
                              //title: Text(user['id']??''),
                                  title: Text(user['first_name'] ?? '',
                                  style: TextStyle(fontWeight: FontWeight.w700,
                                    fontSize: 20.0,)),
                              onTap: () {
                                Navigator.pushNamed(context, '/screen_details',
                                    arguments: user);
                              },


                            ),
                            Divider(height: 30, color: Colors.yellow),


                          ],
                        );
                      },

                    ),
                  ),
                ),

        );
    }



    ),
    );

  }




  }











