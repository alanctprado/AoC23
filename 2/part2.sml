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

fun countBags (bags, r, g, b) =
  if bags = "" then (r, g, b)
  else let val (_, bags) = splitStringOnChar(bags, #" ")
           val (bag, next) = splitStringOnChar(bags, #",")
           val (count, color) = splitStringOnChar(bag, #" ")
           val SOME count = Int.fromString count in
    case color of
      "red" => countBags(next, count, g, b)
    | "green" => countBags(next, r, count, b)
    | "blue" => countBags(next, r, g, count)
    | _ => (0, 0, 0)
  end
;

fun maxColors((a1, a2, a3), (b1, b2, b3)) =
  let val m1 = if a1 > b1 then a1 else b1
      val m2 = if a2 > b2 then a2 else b2
      val m3 = if a3 > b3 then a3 else b3 in
    (m1, m2, m3)
  end
;

fun countGame (g) =
  if g = "" then (0, 0, 0)
  else let val (cur, next) = splitStringOnChar(g, #";") in
    maxColors(countBags(cur, 0, 0, 0), countGame(next))
  end
;

fun solve (line) =
  let val (line, _) = splitStringOnChar(line, #"\n")
      val (game, bags) = splitStringOnChar(line, #":")
      val (_, gameNumber) = splitStringOnChar(game, #" ")
      val (c1, c2, c3) = countGame(bags) in
    c1 * c2 * c3
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
