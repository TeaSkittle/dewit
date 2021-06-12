// Todo list written in D, started on: 2021-05-03
import std.stdio;
import std.string;
import std.conv;
import std.file;

// TODO: - Add OS detection
//       - Figure out placement of files on FS
//       - Create man page

int main( string[] args ){
  int id, opt;
  File file;
  if ( args.length < 2 ) {
    writeln( "usage: todo <option> [task]" );
    return 1;
  } else {
    opt = stringToInt( args[1] );
    parseOptions( opt, id, args, file );
  } return 0;
}

void parseOptions ( int opt, int id, string[] args, File f ) {
  if ( opt == 0 ) {                              // List tasks
    if ( exists( "tasks" )) {
      f = File( "tasks", "r" );
      int lineNumber = 1;
      writeln( "\nID  Task" );
      writeln( "--------" );
      while( !f.eof() ) {
        string line = f.readln();
        if ( line != null ) {
          writef( "%d   %s", lineNumber, line );
          lineNumber++;
        } else {
          writef( "\n" );
        }
      } f.close();
    } else {
      writeln( "No tasks in list" );
    }
  } else if ( opt == 1 ) {                         // Add task
    f = File( "tasks","a" );
    for ( int i = 2; i < args.length; i++ ) {
      f.write( args[i] );
      f.write( " " );
    } f.write( "\n" );
    f.close();
  } else if ( opt == 2 ) {                         // Delte a task
    if ( args.length < 3 ) {
      writeln( "usage: todo d [ID]" );
    } else {
      id = to!int( args[2] );
      if ( exists( "tasks" )) {
        int lineNumber = 1;
        File newFile = File( ".newTasks", "w" );
        f = File( "tasks", "r" );
        while( !f.eof() ) {
          if ( lineNumber < id ) {
            string line = f.readln();
            newFile.writef( "%s", line );
            lineNumber++;
          } else if ( lineNumber == id ) {
            string line = f.readln();
            lineNumber++;
          } else if ( lineNumber > id ) {
            string line = f.readln();
            newFile.writef( "%s", line );
            lineNumber++;
          }
        } if ( id > lineNumber || id < 1 ) {
          writefln( "Error: task ID out of bounds" );
        } else {
          writef( "Deleted task %d\n", id );
        } newFile.close();
        f.close(); 
        copy( ".newTasks", "tasks" );
      } else {
        writeln( "No tasks in list" );
      }
    }
  } else {                                        // Unkwon option
    writeln( "Error: unkown argument" );
  }
}

int stringToInt( string s ){
  if ( s == "l" ) { return 0; }
  else if ( s == "a" ) { return 1; }
  else if ( s == "d" ) { return 2; }
  else { return -1; }
}

