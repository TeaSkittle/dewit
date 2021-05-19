// Todo list written in D, started on: 2021-05-03
import std.stdio;
import std.string;
import std.conv;
import std.file;
import std.exception;

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
        string line = strip( f.readln() );
        writef( "%d   %s\n", lineNumber, line );
        lineNumber++;
        } f.close();
    } else {
      writeln( "No tasks in list" );
    }
  }
  else if ( opt == 1 ) {                         // Add task
    f = File( "tasks","a" );
    for ( int i = 2; i < args.length; i++ ) {
      f.write( args[i] );
      f.write( " " );
    } f.write( "\n" );
    f.close();
  }
  else if ( opt == 2 ) {                         // Delte a task
    if ( args.length < 3 ) {
      writeln( "usage: todo d [ID]" );
    } else {
      id = to!int( args[2] );
      if ( exists( "tasks" )) {
        int lineNumber = 1;
        //
        //File newFile = File( "newTasks", "w" );
        //
        // Finally got the task to remove
        //  TODO - Output to newTasks instead of stdout
        //       - Remove old file( tasks )
        //       - Rename newTasks to tasks
        //       - Add bounds checking
        // 
        f = File( "tasks", "r" );
        while( !f.eof() ) {
          if ( lineNumber < id ) {
            string line = strip( f.readln() );
            writef( "%s\n", line );
            lineNumber++;
          } else if ( lineNumber == id ) {
            string line = strip( f.readln() );
            //writef( "---%s--\n", line );
            lineNumber++;
          } else if ( lineNumber > id ) {
            string line = strip( f.readln() );
            writef( "%s\n", line );
            lineNumber++;
          } 
        } f.close();
        writef( "Deleted task %d\n", id );
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

