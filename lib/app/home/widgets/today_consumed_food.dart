import 'package:eat_smart/app/blocs/user/user_bloc.dart';
import 'package:eat_smart/utils/getDateId.dart';
import 'package:eat_smart/utils/timeago.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';

class TodayConsumedFood extends StatelessWidget {
  const TodayConsumedFood({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(35),
          topRight: Radius.circular(35),
        ),
        color: Theme.of(context).primaryColorLight.withOpacity(0.2),
      ),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Text(
              'All Food Today',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 10),
            _strmBuilder(context),
          ],
        ),
      ),
    );
  }

  StreamBuilder<List<FoodDetails>> _strmBuilder(BuildContext context) {
    return StreamBuilder<List<FoodDetails>>(
      stream: FirebaseUserRepository().getDayFoodList(
          uid: context.read<UserBloc>().uid, dayId: getDateId()),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final list = snapshot.data!;
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: list.length,
            itemBuilder: (context, index) {
              final food = list[index];
              return Card(
                child: Container(
                    child: ListTile(
                  leading: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(food.foodLink),
                      ),
                    ),
                  ),
                  title: Text(food.foodName),
                  subtitle: Text(getTimeAgo(food.timestamp.toDate())),
                )),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        return CircularProgressIndicator();
      },
    );
  }
}
