import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'crud',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  List<Contact> contacts = List.empty(growable: true);

  int selectedIndex = -1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle:true, title: Text('Contact Lsit'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(height: 10),
             TextField(
              controller: nameController,
              decoration: InputDecoration(
                hintText: 'Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10),
                  )
                )
              ),
            ),
            const SizedBox(height: 10),
              TextField(
               controller: contactController,
               keyboardType: TextInputType.number,
              maxLength: 12,
              decoration: InputDecoration(
                hintText: 'Number',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10),
                  )
                )
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
              ElevatedButton(onPressed: (){
                String name = nameController.text.trim();
                String contact = contactController.text.trim();
                if(name.isNotEmpty && contact.isNotEmpty){
                  setState(() {
                    nameController.text='';
                    contactController.text='';
                    contacts.add(Contact(name: name, contact: contact));
                  });
                }
              },
                style:ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,),
               child: const Text('save'),),
              ElevatedButton(onPressed: (){
                String name = nameController.text.trim();
                String contact = contactController.text.trim();
                if(name.isNotEmpty && contact.isNotEmpty){
                  setState(() {
                    nameController.text='';
                    contactController.text='';
                    contacts[selectedIndex].name=name;
                    contacts[selectedIndex].contact=contact;
                    selectedIndex=-1;
                  });
                }

              },
                style:ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,),
               child: const Text('update'),)
            ],),
            const SizedBox(height: 20),
            contacts.isEmpty ? Text('no contact yet...',style:TextStyle(fontSize: 22) ,):
            Expanded(
              child: ListView.builder(
                itemCount: contacts.length,
                itemBuilder: (context, index)=>getRow(index),),
            )
          ],
        ),
      ),
    );
  }

  Widget getRow(int index) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: index%2==0 ? Colors.deepPurpleAccent: Colors.purple,
          foregroundColor:Colors.white,
            child: Text(contacts[index].name[0], style: const TextStyle(fontWeight: FontWeight.bold),),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(contacts[index].name, style: TextStyle(fontWeight: FontWeight.bold),),
          Text(contacts[index].contact),
        ],
      ),
        trailing: SizedBox(
          width: 70,
          child: Row(
            children: [
              InkWell(
                  onTap:(() {
                nameController.text = contacts[index].name;
                contactController.text = contacts[index].contact;
                setState(() {
                  selectedIndex = index;
                });
              }),
                  child: const Icon(Icons.edit)),
              InkWell(
                  onTap: (() {
                setState(() {
                  contacts.removeAt(index);
                });
              }),
                  child: const Icon(Icons.delete))
            ],
          ),
        ),
      ),
    );
  }
  }

class Contact{
  String name;
  String contact;
  Contact({required this.name, required this.contact});
}
