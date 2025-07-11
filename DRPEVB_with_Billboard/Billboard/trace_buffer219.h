#ifndef ___TRACE_BUFFER
#define ___TRACE_BUFFER

// Version of this file:  219 (Feb. 2019)

// This file is designed to be included (#include) in any source file that needs to use the trace buffer functions:
//    msg(), msgd(), msghalt()
// This file also provides the implementions of those functions, instead of putting them in a separate '.c' file.
// Although thalt, tbp, and tbuf[] are globals, users generally should not modify them directly.  They are intended
// to be modified only by the msg functions.

// The #if and #define statements above assure that this file will not be compiled more than once, even if it is
// included in more than one target file.

//===================================================================
// Trace Buffer (circular)
//===================================================================
/* This Software Trace Buffer is for applications where available memory is extremely limited.
   It is suggested to write single char's into the trace buffer, mostly a..z and 0..9.
   Special char's such as @, #, $, %, etc., can be reserved for expanded messages, such as
   a char followed by one or more data bytes, or events posted by msghalt().
   '_' is used by the msg() function to signify the end of the buffer, i.e., last write.
*/
UCHAR thalt = 0;  // Trace buffer running (0), halted (1), or in countdown to halt (>1)
USHORT tbp = 7;  // Trace buffer pointer, i.e., location of eob marker

// Buffer size.  Experiment with the size to avoid compiler error due to conflict with stack area.
#define TSIZE 0x10

UCHAR tbuf [TSIZE] = {'-', '-', '-', '-', '-', '#', '#'};
   // This is the actual buffer, initialized to a distinctive pattern for checking

//------------------
void msg (UCHAR d) {
   // Post char d into the trace buffer if recording is not halted
   if (thalt != 1) {  // not yet halted
      tbuf [tbp++] = d; // Write the d value into the trace buffer at the last marker position
      if (tbp >= TSIZE)  tbp = 0; // wrap the buffer pointer back to zero if needed
      tbuf [tbp] = '_'; // write '_' into the buffer as a marker for the last write
      if (thalt > 1)  thalt--;  // decrement the countdown to halt
   }
}

//----------------------
void msghalt (UCHAR d, UCHAR n) {
   	// Post a message byte (d) and set the countdown for halt (n) if not already counting
   // thalt specifies the number of additional bytes that can be written into tbuf before halting
   // thalt progression is 0 (free run), n..2 (counting down), 1 (halted)
   msg (d); // post the msg if not halted
   if (!thalt)  thalt = n;  // start the countdown to halt
}

//--------------------------------------
void msgd (UCHAR d, UCHAR n, UCHAR *p) {
   // Post an optional message byte (d) and n data bytes into the trace buffer
   // This function typically will be called as msgd (UCHAR d, UCHAR n, (void*) &v).
   int k;
   if (d) msg (d);  // post 'd' if it is nonzero   
   for (k=0; k<n; k++)  msg (p[k]);  // post each requested data byte
}

/* A typical debugger allows memory to be inspected when software execution is halted at a defined or manual
breakpoint.  Then tbuf can be located by searching in the variables list.  thalt and tbp are likely to occupy
2 bytes immediately preceding tbuf[]. 
*/

#endif

