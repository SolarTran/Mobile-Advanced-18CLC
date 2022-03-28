import 'package:flutter/material.dart';
Color textColor = Colors.black54;
Color textSecondry = Colors.grey;

class SingleHotel extends StatefulWidget {
  const SingleHotel({Key? key}) : super(key: key);

  @override
  _SingleHotelState createState() => _SingleHotelState();
}

class _SingleHotelState extends State<SingleHotel> {
  late String hotel;
  late String token;

  @override
  void initState() {
    super.initState();
  }
  
  Widget buildIcons(index) {
    List<Widget> widgets =
    List.generate(
        int.tryParse(index)!,
            (i) => Icon(Icons.star,color: Colors.orange[100],size: 15,));

    return Row(children: widgets);
  }
  late bool ames;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(left: 10,right: 10,bottom: 5),
        child: FlatButton(
          color: Colors.teal,
          onPressed: (){},
          textColor: Colors.white,
          child: const Text('BOOK',style: TextStyle(
              fontFamily: 'Quicksand',
              color: Colors.white,
              fontWeight: FontWeight.bold
          ),),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        ),
      ),
      body: ListView(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Image.asset('assets/images/1.jpg'),
              IconButton(icon: const Icon(Icons.arrow_back,color: Colors.white,), onPressed: (){
                Navigator.of(context).pop();
              }),
              Align(
                child: IconButton(icon: Icon(Icons.favorite,color: textColor,), onPressed: (){}),
                alignment: Alignment.topRight,
              )
            ],
          ),
          Container(
            padding: const EdgeInsets.all(3),
            child: Card(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.fromLTRB(10,10,0,0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Teacher A', style: TextStyle(
                          fontFamily: 'Quicksand',
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: textColor
                      ),),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(10,0,0,0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text('05/03/2022 11:00 AM', style: TextStyle(
                          fontFamily: 'Quicksand',
                          color: textColor,
                          fontSize: 14
                      ),),

                    ),
                  ),

                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Align(
                              child: Text(
                                'Price',
                                style: TextStyle(
                                    fontSize: 12,
                                    color: textColor,
                                    fontFamily: 'Quicksand'
                                ),
                              ),
                              alignment: Alignment.centerLeft,
                            ),
                            Text(
                              'Rs 1200',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: textColor,
                                  fontFamily: 'Quicksand'
                              ),
                            )
                          ],
                        ),

                        Column(
                          children: <Widget>[
                            Align(
                              child: Text(
                                'Rating',
                                style: TextStyle(
                                    fontSize: 12,
                                    color: textColor,
                                    fontFamily: 'Quicksand'
                                ),
                              ),
                              alignment: Alignment.centerLeft,
                            ),
                            buildIcons('5'),
                          ],
                        ),
                        IconButton(icon: Icon(Icons.share,color: textColor,), onPressed: (){})
                      ],
                    ),
                  ),
                  DefaultTabController(
                      length: 4,
                      initialIndex: 0,
                      child: Column(
                        children: <Widget>[
                          TabBar(
                            indicatorColor: Theme.of(context).primaryColor,
                            labelColor: textColor,
                            unselectedLabelColor: textColor,
                            isScrollable: true,
                            tabs: const [
                              Tab(text: 'Details',),
                              Tab(text: 'Lessons',),
                              Tab(text: 'Reviews',),
                              Tab(text: 'Near By',)
                            ],
                          ),
                          SizedBox(
                              height: 300.0,
                              child: TabBarView(
                                children: [
                                  Container(
                                      padding: const EdgeInsets.all(10),
                                      child: Text('this is a demo hotel',
                                        style: TextStyle(
                                            color: textColor
                                        ),
                                      )
                                  ),
                                  const Center(child: Text('Reviews here')),
                                  const Center(child: Text('Reviews here')),
                                  const Center(child: Text('Near by here')),
                                ],
                              ))],
                      ))],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BuildCheck extends StatefulWidget {
  BuildCheck(this.rooms,this.aminities, {Key? key}) : super(key: key);
  late String rooms;
  late String aminities;
  @override
  _BuildCheckState createState() => _BuildCheckState(rooms,aminities);
}

class _BuildCheckState extends State<BuildCheck> {
  _BuildCheckState(this.rooms,this.aminities);
  var aminities;
  var rooms;
  late bool isChecked;
  late List<int> roomsno ;
  List<Map> data = List.empty();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  late List<bookingdata> bdata ;

  void _showDialog(aminities) {
    aminities = aminities.split(",");
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Choose Your Aminities'),
          content:  SizedBox(
            height: 150,
            child: ListView.builder(
                itemCount: aminities.length,
                itemBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    width: 50,
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(aminities[index]),
                            Check(false),
                          ],
                        ),
                      ],
                    ),
                  );
                }
            ),
          ),
          actions: <Widget>[
            FlatButton(
              color: Colors.orange[100],
              onPressed: (){
                _showDialog(aminities);
              },
              textColor: Colors.white,
              child: Text('BOOK NOW',style: TextStyle(
                  fontFamily: 'Quicksand',
                  color: textColor,
                  fontWeight: FontWeight.bold
              ),),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
            )
          ],
        );
      },
    );
  }



  Widget buildroom(rooms,aminities) {
    List<Widget> widgets = List.empty();
    rooms = rooms.split(",");

    for (int i=0;i<rooms.length;i++){
      bdata[1] = new bookingdata(1,1);
      print(bdata[i].rooms);
      var datasingle = data[i];
      setState(() {
        datasingle["adults"] =0;
        datasingle["rooms"]= 0;
      });

      widgets.add (
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Card(
              elevation: 0.5,
              child: Container(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Text(
                              rooms[i],
                              style: TextStyle(
                                  fontFamily: 'Quicksand',
                                  color: textColor,
                                  fontSize: 20.0
                              ),
                            ),
                            Text(
                              aminities,
                              style: TextStyle(
                                  fontFamily: 'Quicksand',
                                  color: textSecondry,
                                  fontSize: 13.0
                              ),
                            ),
                          ],
                        ),
                        FlatButton(
                          color: Colors.orange[100],
                          onPressed: (){
                            _showDialog(aminities);
                          },
                          textColor: Colors.white,
                          child: Text('BOOK',style: TextStyle(
                              fontFamily: 'Quicksand',
                              color: textColor,
                              fontWeight: FontWeight.bold
                          ),),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                        )
                      ],
                    ),
                    const SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.orange[100]!),
                              borderRadius: BorderRadius.all(Radius.circular(12))
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              GestureDetector(
                                onTap: (){
                                  setState(() {
                                    datasingle["adults"]--;
                                  });
                                  // print(roomsno);

                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.orange[100],
                                      borderRadius: BorderRadius.all(Radius.circular(10))
                                  ),
                                  padding: const EdgeInsets.fromLTRB(10, 3, 10, 3),
                                  child: Text('-', style:TextStyle(fontSize: 15,color: textColor)),
                                ),
                              ),
                              const SizedBox(width: 10,),
                              Text('ROOMS : '+ datasingle["adults"].toString(), style: TextStyle(color: textColor,fontFamily: 'Quicksand',fontSize: 12),),
                              const SizedBox(width: 10,),
                              GestureDetector(
                                onTap: (){
                                  setState(() {
                                    data[i];
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.orange[100],
                                      borderRadius: const BorderRadius.all(Radius.circular(10))
                                  ),
                                  padding: const EdgeInsets.fromLTRB(10, 3, 10, 3),
                                  child: Text('+', style: TextStyle(fontSize: 15,color: textColor)),
                                ),
                              ),
                            ],
                          ),
                        ),


                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.orange[100]!),
                              borderRadius: const BorderRadius.all(Radius.circular(12))
                          ),
                          child: Row(
                            children: <Widget>[
                              GestureDetector(
                                onTap: (){
                                  setState(() {
                                    datasingle["adults"]--;
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.orange[100],
                                      borderRadius: BorderRadius.all(Radius.circular(10))
                                  ),
                                  padding: const EdgeInsets.fromLTRB(10, 3, 10, 3),
                                  child: Text('-', style:TextStyle(fontSize: 15,color: textColor)),
                                ),
                              ),
                              const SizedBox(width: 10,),
                              Text('ADULTS : '+ data[i]["adults"].toString(), style: TextStyle(color: textColor,fontFamily: 'Quicksand',fontSize: 12),),
                              const SizedBox(width: 10,),
                              GestureDetector(
                                onTap: (){
                                  setState(() {
                                    datasingle["adults"]++;
                                  });

                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.orange[100],
                                      borderRadius: const BorderRadius.all(Radius.circular(10))
                                  ),
                                  padding: const EdgeInsets.fromLTRB(10, 3, 10, 3),
                                  child: Text('+', style:TextStyle(fontSize: 15,color: textColor)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )],
                ),
              ),
            ),
          )
      );
    }
    return Column(children: widgets);
  }

  @override
  Widget build(BuildContext context) {
    return buildroom(rooms,aminities);
  }
}

class Check extends StatefulWidget {
  Check(this.check);
  bool check;
  @override
  _CheckState createState() => _CheckState(check);
}

class _CheckState extends State<Check> {
  _CheckState(this.check);
  bool check;
  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: check,
      onChanged: (bool? val){
        setState(() {
          check = val!;
        });
      },
    );
  }
}


class bookingdata{
  int rooms = 0;
  int adults = 0;
  bookingdata(this.rooms,this.adults);
}