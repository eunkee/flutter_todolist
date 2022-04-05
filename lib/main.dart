import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class Todo {
  bool isDone = false;
  String title = '';

  Todo(this.title);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TodoListPage(),
    );
  }
}

class TodoListPage extends StatefulWidget {
  const TodoListPage({Key? key}) : super(key: key);

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  // 할 일 목록을 저장할 리스트
  final _items = <Todo>[];

  // 할 일 문자열 조작을 위한 컨트롤러
  var _todoController = TextEditingController();

  @override
  void dispose(){
    _todoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar (
        title: const Text('남은 할 일'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(child: TextField(
                  controller: _todoController,
                ),),
                ElevatedButton(onPressed: () => _addTodo(Todo(_todoController.text)), child: const Text('추가')),
              ],
            ),
            Expanded(child: ListView(
              children: _items.map((todo) => _buildItemWidget(todo)).toList(),
            ),),
          ],
        ),
      ),
    );
  }

  Widget _buildItemWidget(Todo todo) {
    return ListTile(
      onTap: () => _toggleTodo(todo), // Todo : 클릭 시 완료/취소 되도록 수정
      title: Text(
        todo.title,
        style: todo.isDone ?
          const TextStyle(
            decoration: TextDecoration.lineThrough, // 취소선
            fontStyle: FontStyle.italic, // 이탤릭체
          )
          : null,
      ),
      trailing: IconButton(
        icon: const Icon(Icons.delete_forever),
        onPressed: ()=>_deleteTodo(todo), //  Todo : 쓰레기통 클릭 시 삭제되도록
      ),
    );
  }

  // 할 일 추가 메서드
  void _addTodo(Todo todo) {
    setState(() {
      _items.add(todo);
      _todoController.text = ''; // 할 일 입력 필드를 피움
    });
  }

  // 할 일 삭제 메서드
  void _deleteTodo(Todo todo) {
    setState(() {
      _items.remove(todo);
    });
  }

  // 할 일 완료/미완료 메서드
  void _toggleTodo(Todo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }




}
