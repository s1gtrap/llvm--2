#!/usr/bin/env python3

import lldb
import os
import re
import sys
import itertools
from time import sleep


def disassemble_instructions(insts):
    for i in insts:
        print(i)


debugger = lldb.SBDebugger.Create()
debugger.SetAsync(False)

exe = sys.argv[1]

print("Creating a target for '%s'" % exe)

target = debugger.CreateTargetWithFileAndArch(exe, lldb.LLDB_ARCH_DEFAULT)

if target:
    # If the target is valid set a breakpoint at main
    main_bp = target.BreakpointCreateByRegex(
        "^_\\$break\\$[a-zA-Z0-9_]+\\$[0-9]+\\$$", target.GetExecutable().GetFilename())

    print(main_bp)

    # Launch the process. Since we specified synchronous mode, we won't return
    # from this function until we hit the breakpoint at main
    process = target.LaunchSimple(sys.argv[2:], None, os.getcwd())
    fstate = {}
    rebp = re.compile("^_\\$break\\$([a-zA-Z0-9_]+)\\$[0-9]+\\$$")

    # Make sure the launch went ok
    if process:
        for _ in iter(int, 1):
            # Print some simple process info
            state = process.GetState()
            if state == lldb.eStateStopped:
                # Get the first thread
                thread = process.GetThreadAtIndex(0)
                if thread:
                    # Print some simple thread info
                    # Get the first frame
                    frame = thread.GetFrameAtIndex(0)
                    if frame:
                        # Print some simple frame info
                        # print(frame, "  asdf ", frame.name)
                        matches = rebp.match(frame.name)
                        fname = matches.group(1)
                        function = frame.GetFunction()
                        # See if we have debug info (a function)

                        value = frame.GetRegisters()[0]
                        # print('Frame registers (size of register set = %d):' % registerList.GetSize())
                        # print value
                        print('%s (number of children = %d):' %
                              (value.GetName(), value.GetNumChildren()))
                        # grab the first five elements
                        gprs = itertools.islice(value, 0, 16)
                        changed = 0
                        if fname not in fstate:
                            fstate[fname] = {}
                        for child in gprs:
                            if child.GetName() in fstate[fname]:
                                if fstate[fname][child.GetName()] != child.GetValue():
                                    fstate[fname][child.GetName()
                                                  ] = child.GetValue()
                                    changed += 1
                                    print(child.GetName(),
                                          child.GetValue())
                            else:
                                fstate[fname][child.GetName()] = child.GetValue()
                                # print( child.GetName(), child.GetValue())
                        if changed > 2:
                            if function:
                                # We do have a function, print some info for the function
                                # print(function)
                                # Now get all instructions for this function and print them
                                insts = function.GetInstructions(target)
                                disassemble_instructions(insts)
                            else:
                                # See if we have a symbol in the symbol table for where we stopped
                                symbol = frame.GetSymbol()
                                if symbol:
                                    # We do have a symbol, print some info for the symbol
                                    # print(symbol)
                                    # Now get all instructions for this symbol and print them
                                    insts = symbol.GetInstructions(target)
                                    disassemble_instructions(insts)

                # print("Hit the breakpoint at main, enter to continue and wait for program to exit or 'Ctrl-D'/'quit' to terminate the program")
                next = sys.stdin.readline()
                if not next or next.rstrip('\n') == 'quit':
                    print('Terminating the inferior process...')
                    process.Kill()
                else:
                    # Now continue to the program exit
                    process.Continue()
                    # When we return from the above function we will hopefully be at the
                    # program exit. Print out some process info
                    print(process)
            elif state == lldb.eStateExited:
                print("Didn't hit the breakpoint at main, program has exited...")
            else:
                print('Unexpected process state: %s, killing process...' %
                      debugger.StateAsCString(state))
                process.Kill()
