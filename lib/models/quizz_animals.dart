import 'animal.dart';

class QuizzAnimals {
  QuizzAnimals(this.goodAnswer, List<Animal> questions) {
    questions = List.from(questions);
    questions.remove(goodAnswer);
    questions = questions.sublist(0, 7);
    questions.add(goodAnswer);
    questions.shuffle();
    candidates = questions;
  }

  Animal goodAnswer;
  List<Animal> candidates;
  List<String> get chooserCandidates {
    List<String> chooserCandidates = candidates.map((candidate) => (candidate.name)).toList();
    return chooserCandidates;
  }
}
