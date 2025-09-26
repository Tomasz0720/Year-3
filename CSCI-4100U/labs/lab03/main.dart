void main() {
  // PART 1
  // SCALING GRADES
  
  var grades = <double>[]; // Make an empty double list

  for (var i = 0; i <= 100; i++) { // Start at 0, increment by 1 until i <= 100, then add to the list
    grades.add(i.toDouble());
  }
  
  var scaledGrades = grades.map((g) => (g / 100 * 30) + 2).toList(); // Map to 0-30 and add 2
  
  print("List of scaled grades: $scaledGrades \n");
  
  
  // PART 3
  // ANONYMOUS FUNCTION

  List<int> numbers = [55, 65, 75, 85, 95];

  List<Student> studentList = numbers.map((n) {
     return Student(
       sid: (100000000 + n).toString(), 
       name: "Student #$n",);
  }).toList();


  // PART 4
  // PRINT STUDENTS

  studentList.forEach((student) {
    print(student);
  });
  
  
  // PART 6
  // MAGIC TEST

  Player player = Player(name: "Player", hp: 100, magicDamage: 35, mana: 50, defense: 20);
  Enemy enemy = Enemy(name: "Enemy", hp: 80, attackPower: 25, stamina: 50, defense: 15);

  int playerDamage = enemy.attack(player);

  int enemyDamage = player.castSpell(enemy);

  print("");
  print("${enemy.name} hits ${player.name} for ${playerDamage} points of damage!");
  print("${player.name} hits ${enemy.name} for ${enemyDamage} points of damage!");
}


// PART 2
// STUDENT CLASS

class Student{

  String sid;
  String name;

  Student({required this.sid, required this.name});


  @override
  String toString(){
    return 'Student(sid: $sid, name: $name)';
  }
}


// PART 5
// MIXINS

class Character {
  String name;
  int hp;
  int defense;
  Character({required this.name, required this.hp, required this.defense});
}

class Player extends Character with Magic {
  Player({name, hp, magicDamage, mana, defense})
  : super(name: name, hp: hp, defense: defense) {
    this.mana = mana;
    this.magicDamage = magicDamage;
  }
}

class Enemy extends Character with Melee {
  Enemy({name, hp, attackPower, stamina, defense})
    : super(name: name, hp: hp, defense: defense) {
    this.stamina = stamina;
    this.attackPower = attackPower;
  }
}

mixin Magic{
  int magicDamage = 0;
  int mana = 0;
  
  int castSpell(Character victim){
    mana -= 10;
    int damage = magicDamage - victim.defense;
    if (damage < 0) damage = 0;
    victim.hp -= damage;
    return damage;
  }
}

mixin Melee{
  int attackPower = 0;
  int stamina = 0;
  
  int attack(Character victim){
    stamina -= 10;
    int damage = attackPower - victim.defense;
    if (damage < 0) damage = 0;
    victim.hp -= damage;
    return damage;
  }
}