import lldb
import os
import sys
import itertools
from time import sleep


def disassemble_instructions(insts):
    for i in insts:
        print(i)


debugger = lldb.SBDebugger.Create()
debugger.SetAsync(False)

exe = "/home/s1g/Workspaces/BSc/llvm--2/crc32b"

print("Creating a target for '%s'" % exe)

target = debugger.CreateTargetWithFileAndArch(exe, lldb.LLDB_ARCH_DEFAULT)

if target:
    # If the target is valid set a breakpoint at main
    main_bp = target.BreakpointCreateByRegex(
        "^_\\$break_[0-9]+\\$", target.GetExecutable().GetFilename())

    print(main_bp)

    # Launch the process. Since we specified synchronous mode, we won't return
    # from this function until we hit the breakpoint at main
    process = target.LaunchSimple(None, None, os.getcwd())

    # Make sure the launch went ok
    if process:
        regvals = {}
        for _ in iter(int, 1):
            # Print some simple process info
            state = process.GetState()
            print(process)
            if state == lldb.eStateStopped:
                # Get the first thread
                thread = process.GetThreadAtIndex(0)
                if thread:
                    # Print some simple thread info
                    print(thread)
                    # Get the first frame
                    frame = thread.GetFrameAtIndex(0)
                    if frame:
                        # Print some simple frame info
                        print(frame)
                        function = frame.GetFunction()
                        # See if we have debug info (a function)
                        if function:
                            # We do have a function, print some info for the function
                            print(function)
                            # Now get all instructions for this function and print them
                            insts = function.GetInstructions(target)
                            disassemble_instructions(insts)
                        else:
                            # See if we have a symbol in the symbol table for where we stopped
                            symbol = frame.GetSymbol()
                            if symbol:
                                # We do have a symbol, print some info for the symbol
                                print(symbol)
                                # Now get all instructions for this symbol and print them
                                insts = symbol.GetInstructions(target)
                                disassemble_instructions(insts)

                        value = frame.GetRegisters()[0]
                        # print('Frame registers (size of register set = %d):' % registerList.GetSize())
                        # print value
                        print('%s (number of children = %d):' %
                              (value.GetName(), value.GetNumChildren()))
                        # grab the first five elements
                        gprs = itertools.islice(value, 2, 16)
                        changed = 0
                        for child in gprs:
                            if child.GetName() in regvals:
                                if regvals[child.GetName()] != child.GetValue():
                                    regvals[child.GetName()] = child.GetValue()
                                    changed += 1
                                    print(child.GetName(), child.GetValue())
                            else:
                                regvals[child.GetName()] = child.GetValue()
                                print(child.GetName(), child.GetValue())
                        if changed > 2:
                            raise "changed more than two!"

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
