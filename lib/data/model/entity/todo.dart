import 'package:equatable/equatable.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class Todo extends Equatable {
  @Id()
  int obxId = 0;
  String name;
  @Property(type: PropertyType.dateNano)
  DateTime createdDate;
  @Property(type: PropertyType.dateNano)
  DateTime? finishedDate;

  Todo(this.name, this.createdDate);

  @override
  List<Object?> get props => [obxId, name];
}
