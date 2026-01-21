class Grade {
  int? id;
  String title;
  String description;
  String priority;

  Grade({
    this.id,
    required this.title,
    required this.description,
    required this.priority,
  });

  Map<String, dynamic> toMap(){
    return{
      'id': id,
      'title': title,
      'description': description,
      'priority': priority,
    };
  }

  factory Grade.fromMap(Map<String, dynamic> map){
    return Grade(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      priority: map['priority'],
    );
  }
}