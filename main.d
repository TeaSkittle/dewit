// Todo list written in D, started on: 2021-05-03
import std.stdio;
import std.string;
import std.conv;

int main(string[] args){
  int id, opt;
  if (args.length < 2) {
    printUsage();
    return 1;
  } else {
    opt = stringToInt(args[1]);
    parseOptions(opt,id, args);
  }
  return 0;
}

void parseOptions(int opt, int id, string[] args){
  switch(opt){
  case 0:  // list
    writeln("list");
    break;
  case 1:  // add
    break;
  case 2:  // done
    id = to!int(args[2]);
    break;
  case 3:  // delete( may not use )
    break;
  default: // Error
    writeln("Unkown argument");
    break;
  }
}

int stringToInt(string s){
  switch(s){
  case "list":
    return 0;
    break;
  case "add":
    return 1;
    break;
  case "done":
    return 2;
    break;
  case "delete":
    return 3;
    break;
  default:
    return -1;
    break;
  }
}

void printUsage(){
  writeln("usage: todo <option> [task]");
}

// Not using
// --------
void input(){
  write("Enter: ");
  auto inputString = strip(stdin.readln());
  writeln(inputString);
}

