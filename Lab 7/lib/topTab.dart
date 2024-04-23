import 'package:flutter/material.dart';

class topTab extends StatelessWidget {
  const topTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.deepPurple,
            bottom: const TabBar(
              indicatorWeight: 4,
              indicatorColor: Color.fromARGB(255, 51, 8, 113),
              tabs: [
                Text('Left',
                    style: TextStyle(
                      fontSize: 18,
                    )),
                Text('Middle',
                    style: TextStyle(
                      fontSize: 18,
                    )),
                Text('Right',
                    style: TextStyle(
                      fontSize: 18,
                    )),
              ],
            ),
          ),
          body: Container(
            color: Colors.black87,
            child: const TabBarView(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'This is the Left Tab',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 235, 235, 235)),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'This is the Middle Tab',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 235, 235, 235)),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'This is the Right Tab',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 235, 235, 235)),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}