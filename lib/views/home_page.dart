import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_login_screen/services/authentication_service.dart';
import 'package:new_login_screen/services/firestore_service.dart';

class HomePage extends StatefulWidget {
  final User user;
  const HomePage({super.key, required this.user});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptController = TextEditingController();
  final FirestoreService _firestoreService = FirestoreService();

  void _openModalForm({String? docId}) async {
    if (docId != null) {
      DocumentSnapshot document = await _firestoreService.getTask(docId);
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;

      _titleController.text = data["title"] ?? "";
      _descriptController.text = data["description"] ?? "";
    }
    
    showModalBottomSheet(
      backgroundColor: Color.fromARGB(255, 99, 131, 151),
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 16,
            right: 16,
            top: 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Adicionar Tarefas", 
                style: TextStyle(fontSize: 17, color: Colors.white),
              ),
              Divider(color: Colors.white),
              SizedBox(height: 10),
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: "Título",
                  fillColor: Colors.white,
                  filled: true,
                  prefixIcon: Icon(Icons.text_fields),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _descriptController,
                decoration: InputDecoration(
                  labelText: "Descrição",
                  fillColor: Colors.white,
                  filled: true,
                  prefixIcon: Icon(Icons.text_fields),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  String title = _titleController.text.trim();
                  String description = _descriptController.text.trim();

                  if (title.isNotEmpty && description.isNotEmpty) {
                    if (docId == null) {
                      _firestoreService.addTasks(title, description);
                    } else {
                      _firestoreService.updateTask(docId, title, description);
                    }

                    _titleController.clear();
                    _descriptController.clear();
                    Navigator.pop(context);
                  } else {
                    // Adicionar lógica para exibir alerta de erro
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Por favor, preencha todos os campos.")),
                    );
                  }
                },
                child: Text("Salvar"),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tela Inicial'),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(widget.user.displayName != null ? widget.user.displayName! : "Não informado"),
              accountEmail: Text(widget.user.email != null ? widget.user.email! : "Não informado"),
            ),
            ListTile(
              title: Text("Deslogar"),
              leading: Icon(Icons.logout),
              onTap: () {
                AuthenticationService().logoutUser();
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _openModalForm();
        },
        child: Icon(Icons.add),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestoreService.getTasksStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List tasksList = snapshot.data!.docs;

            return ListView.builder(
              itemCount: tasksList.length,
              itemBuilder: (context, index) {
                DocumentSnapshot document = tasksList[index];
                String docId = document.id;
                Map<String, dynamic> data = document.data() as Map<String, dynamic>;

                String taskTitle = data["title"];
                String taskDescription = data["description"];

                return ListTile(
                  title: Text(taskTitle),
                  subtitle: Text(taskDescription),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TaskDetailsPage(taskId: docId),
                      ),
                    );
                  },
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          _openModalForm(docId: docId);
                        },
                        icon: Icon(Icons.settings),
                      ),
                      IconButton(
                        onPressed: () {
                          _firestoreService.deleteTask(docId);
                        },
                        icon: Icon(Icons.delete),
                      ),
                    ],
                  ),
                );
              },
            );
          } else {
            return Center(
              child: Text("Não encontrado dados!"),
            );
          }
        },
      ),
    );
  }
}

class TaskDetailsPage extends StatelessWidget {
  final String taskId;

  const TaskDetailsPage({super.key, required this.taskId});

  @override
  Widget build(BuildContext context) {
    final FirestoreService _firestoreService = FirestoreService();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Detalhes da Tarefa"),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: _firestoreService.getTask(taskId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(child: Text('Tarefa não encontrada.'));
          }

          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
          String title = data['title'];
          String description = data['description'];

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 10),
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
