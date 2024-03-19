import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_s/features/home_cubit/presentation/cubit/home_input_cubit.dart';
import 'package:flutter_s/features/home_cubit/presentation/cubit/home_input_states.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Cubit'),
        ),
        body: const HomeBody(),
        // bottomNavigationBar: _buildBottomNavigationBar(context),
      ),
    );
  }
}

class HomeBody extends StatelessWidget {
  const HomeBody({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Scaffold(
          body: _buildBody(context, state),
          bottomNavigationBar: _buildBottomNavigationBar(context),
        );
      },
    );
  }

  Widget _buildBody(BuildContext context, HomeState state) {
    if (state is InitialHomeState) {
      return const Center(
        child: Text("Sem tarefas"),
      );
    } else if (state is LoadingHomeState) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (state is LoadedHomeState) {
      return _buildList(state.todos);
    } else {
      final cubit = BlocProvider.of<HomeCubit>(context);
      return _buildList(cubit.todos);
    }
  }

  Widget _buildList(List<String> todos) {
    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (_, index) {
        return ListTile(
          leading: CircleAvatar(
            child: Center(
              child: Text(
                todos[index][0],
              ),
            ),
          ),
          title: Text(
            todos[index],
          ),
          trailing: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
          ),
        );
      },
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final cubit = BlocProvider.of<HomeCubit>(context);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.03),
            offset: const Offset(0, -5),
            blurRadius: 4,
          )
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                hintText: 'Digite algo',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          GestureDetector(
            onTap: () {
              cubit.addTodo(todo: nameController.text);
              nameController.clear();
            },
            child: const CircleAvatar(
              backgroundColor: Colors.red,
              child: Center(
                child: Icon(
                  Icons.add,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }
}
