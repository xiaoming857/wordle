import 'package:wordle/app/widgets/virtual_keyboard_controller.dart';

/// LetterStatus
///
/// ## description
/// The [LetterStatus] is used to label the status of the letters in the board. This
/// is useful for styling or applying some condition to the letters depending on its status:
///
/// - correct, indicating the letter is correct in both existence and position inside the wordle.
/// - wrongPosition, indicating the letter exist in the wordle but in the wrong position.
/// - wrong, indicating that the letter does not exist in the wordle.
/// - empty, indicating that there is no letter.
///
/// Note that the letter must be in the correct order. The [LetterStatus.correct] being
/// in the top most order, at index 0, followed by [LetterStatus.wrongPosition],
/// [LetterStatus.wrong], [LetterStatus.empty]. This is needed for the implementation
/// in [VirtualKeyboardController].
enum LetterStatus {
  correct,
  wrongPosition,
  wrong,
  empty,
}
