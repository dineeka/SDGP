import "package:flutter/material.dart";

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  Widget appBarTitle = new Text("Main Page");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        centerTitle: true,
        title: appBarTitle,
      ),
      endDrawer: Drawer(
        child: Container(
          color: Colors.orangeAccent,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 40,
                ),
                Text(
                  'Choose your requirments',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 63, 63, 63),
                    fontSize: 30,
                  ),
                ),
                SizedBox(
                  height: 55,
                ),
                Container(
                  child: GestureDetector(
                    onTap: () {},
                    child: SizedBox(
                      width: 300,
                      height: 150,
                      child:
                          Image.asset('assets/images/damagedetectionpic.png'),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Detect Damage',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Container(
                  child: GestureDetector(
                    onTap: () {},
                    child: SizedBox(
                      width: 300,
                      height: 150,
                      child: Image.asset('assets/images/repairshop.png'),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Nearby Shops',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Container(
                  child: GestureDetector(
                    onTap: () {},
                    child: SizedBox(
                      width: 300,
                      height: 150,
                      child: Image.asset('assets/images/repairshop.png'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
