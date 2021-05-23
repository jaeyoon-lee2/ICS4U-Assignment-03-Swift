/*
This program solves the text maze.
author  Jay Lee
version 1.0
since   2021-05-23
*/

var isSolved = false

// This method find direction to solve the maze.
func FindDirection(point: [Int], direction: [[Int]],
                   maze: [[Character]]) -> [[Int]] {
  var point = point
  var direction = direction
  var maze = maze
  let blockedSymbols: [Character] = ["#", "S", "+"]
  let row = point[0]
  let col = point[1]
  for counter in 0 ..< 4 {
    var newRow = row
    var newCol = col
    if (!isSolved) {
      if (counter == 0 && row - 1 >= 0
          && !(blockedSymbols.contains(maze[col][row - 1]))) {
        newRow -= 1
      } else if (counter == 1 && row + 1 < maze[0].count
                 && !(blockedSymbols.contains(maze[col][row + 1]))) {
        newRow += 1
      } else if (counter == 2 && col - 1 >= 0
                 && !(blockedSymbols.contains(maze[col - 1][row]))) {
        newCol -= 1
      } else if (counter == 3 && col + 1 < maze.count
                 && !(blockedSymbols.contains(maze[col + 1][row]))) {
        newCol += 1
      }
      if (maze[newCol][newRow] == ".") {
        point[0] = newRow
        point[1] = newCol
        maze[newCol][newRow] = "+"
        direction.append(point)
        direction = FindDirection(point: point, direction: direction,
                                  maze: maze)
        if (!isSolved) {
          direction.removeLast()
        }
        maze[newCol][newRow] = "."
        point[0] = row
        point[1] = col
      } else if (maze[newCol][newRow] == "G") {
        isSolved = true
        break
      }
    }
  }
  return direction
}

// This method finds start point 'S' from the maze.
func FindStartPoint(twoDMaze: [[Character]]) -> [Int] {
  for col in 0..<twoDMaze.count {
    for row in 0..<twoDMaze[col].count {
      if (twoDMaze[col][row] == "S") {
        let startPoint = [row, col]
        return startPoint
      }
    }
  }
  return [-1, -1]
}

// This method appends 2d directions to the maze.
func AppendDirection(direction: [[Int]], maze: [[Character]]) -> [[Character]] {
  var maze = maze
  for path in direction {
    maze[path[1]][path[0]] = "+"
  }
  return maze
}

// This method converts 1d string arraylist to 2d character array.
func Convert1Dto2DArray(oneDArray: [String], size: [Int]) -> [[Character]] {
  let row = size[0]
  let col = size[1]
  var twoDArray = [[Character]](repeating: [Character](repeating: "#",
                                  count: row), count: col)
  for colIndex in 0..<col {
    for rowIndex in 0..<row {
      twoDArray[colIndex][rowIndex] = Array(oneDArray[colIndex])[rowIndex]
    }
  }
  return twoDArray
}

// This method prints 2D Maze array.
func ShowMaze(twoDMaze: [[Character]]) {
  for col in 0..<twoDMaze.count {
    for row in 0..<twoDMaze[col].count {
      print(twoDMaze[col][row], terminator:"")
    }
    print("")
  }
  print("")
}


print("S:Start\n#: blocked\n.: open\n+: path\nG: goal\n")
print("MAZE:\n", terminator: "")
var col = 0
var row = 0
var oneDMaze = [String]()
while let eachRow = readLine() {
  if (eachRow.isEmpty) {
    break
  }
  row = eachRow.count
  oneDMaze.append(String(eachRow))
  col += 1
}
let size: [Int] = [row, col]
var twoDMaze: [[Character]] = Convert1Dto2DArray(oneDArray: oneDMaze,
                                                 size: size)
let startPoint: [Int] = FindStartPoint(twoDMaze: twoDMaze)
var direction = [[Int]]()
direction = FindDirection(point: startPoint, direction: direction,
                          maze: twoDMaze)
twoDMaze = AppendDirection(direction: direction, maze: twoDMaze)

if (isSolved) {
  print("Solved Maze:\n")
  ShowMaze(twoDMaze: twoDMaze)
} else {
  print("There is no direction to solve the maze!")
}
print("\nDone.")
