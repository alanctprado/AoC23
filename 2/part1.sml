fun splitListOnChar (s, ch) =
  case s of
    [] => ([], [])
  | c :: s' =>
    if c = ch then ([], s')
    else let val (l, r) = splitListOnChar(s', ch)
      in (c::l, r)
    end
;

fun splitStringOnChar (s, ch) =
  let val (l, r) = splitListOnChar(String.explode(s), ch) in
    (String.implode(l), String.implode(r))
  end
;

fun checkBags (b) =
  if b = "" then true
  else let val (_, b) = splitStringOnChar(b, #" ")
           val (bag, next) = splitStringOnChar(b, #",")
           val (count, color) = splitStringOnChar(bag, #" ")
           val SOME count = Int.fromString count in
    case color of
      "red" => if count < 13 then checkBags(next) else false
    | "green" => if count < 14 then checkBags(next) else false
    | "blue" => if count < 15 then checkBags(next) else false
    | _ => false
  end
;


fun checkGame (g) =
  if g = "" then true
  else let val (cur, next) = splitStringOnChar(g, #";") in
    checkBags(cur) andalso checkGame(next)
  end
;


fun solve (line) =
  let val (line, _) = splitStringOnChar(line, #"\n")
      val (game, bags) = splitStringOnChar(line, #":")
      val (_, gameNumber) = splitStringOnChar(game, #" ") in
    if checkGame(bags) then valOf(Int.fromString gameNumber) else 0
  end
;

let
  val stream = TextIO.stdIn
  val done = ref false
  val result = ref 0
in
  while not (!done) do
    case TextIO.inputLine stream of
      SOME s => result := (!result + solve(s))
    | NONE => done := true;
  result
end
