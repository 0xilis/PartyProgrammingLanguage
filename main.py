# The Runic Programming Language
# (c) 0xilis, 2024
# This compiler is intended for x86_64 macOS systems.
# (Maybe rename to party? .party?)
# The Party Programming Language
# (c) 0xilis, 2024
import os

# Array for existing functions
declaredFunctions = []

def end_compile(outf, inf):
  outf.close()
  inf.close()

def compile(path, outpath):
  # Initialize assembly
  if os.path.exists(outpath):
    os.remove(outpath)
  outf = open(outpath, 'w+')
  outf.write("global start\nsection .text\n\n")
  inFunkyMode = False # Are we in a function?
  isBlind = False # Are we declaring inline assembly?
  segment_data = "" # __DATA section, added after __TEXT
  inComment = False # Are we in a comment?
  autoReturn = True # Should we return from a function?
  with open(path, 'r') as inf:
    InputLines = inf.readlines()
    for inputline in InputLines:
      nospaces = inputline.replace(" ", "")
      nospacesorln = nospaces.replace("\n", "")
      #Here is support for ugly "force the Party compiler" hacks if our compiler is buggy and a program needs to workaround it. TODO: Don't do this in comments.
      if nospacesorln == "#define__NO_AUTORETURN1":
        # Disable auto return
        print("Disable auto return")
        autoReturn = False
      elif nospacesorln == "#define__NO_AUTORETURN0":
        # Re-Enable auto return
        print("Enable auto return")
        autoReturn = True
      elif nospacesorln == "#define__FLAG_ISBLIND0":
        # Force isBlind off
        print("Force isBlind = False")
        isBlind = False
      elif nospacesorln == "#define__FLAG_ISBLIND1":
        # Force isBlind on
        print("Force isBlind = True")
        isBlind = True
      elif nospacesorln == "#define__FLAG_ISINFUNC0":
        # Force inFunkyMode off
        print("Force inFunkyMode = False")
        inFunkyMode = False
      elif nospacesorln == "#define__FLAG_ISINFUNC1":
        # Force inFunkyMode on
        print("Force inFunkyMode = True")
        inFunkyMode = True
      elif isBlind:
        # blind, inline assembly.
        if nospaces.startswith("}"):
          isBlind = False
          print("End of inline assembly.")
        else:
          outf.write(inputline)
      elif inComment:
        # inside a multi-line comment
        if nospacesorln.endswith("*/"):
          print("Comment End")
          inComment = False
      else:
        IndexFunc = inputline.find("funky")
        if (IndexFunc != -1):
          # This is a function declaration
          if inFunkyMode:
            print("RUNIC ERROR: Cannot declare a function inside a function.")
            end_compile(outf,inf)
            return
          afterfunk = inputline[IndexFunc+5:]
          afterfunk = afterfunk.replace(" ", "")
          namelength = afterfunk.find("{")
          name = afterfunk[:namelength]
          if name in declaredFunctions:
            print("RUNIC ERROR: Function already declared (" + name + ").")
            end_compile(outf,inf)
            return
          declaredFunctions.append(name)
          print("Function declared: " + name)
          inFunkyMode = True
          outf.write(name + ":\n")
        elif nospaces.startswith("}"):
          # Declare function stop.
          print("Function end")
          if not inFunkyMode:
            print("RUNIC ERROR: Cannot end a function outside of one.")
            end_compile(outf,inf)
            return
          inFunkyMode = False
          if autoReturn:
            outf.write(" ret\n\n")
          else:
            outf.write("\n")
        else:
          # Code!
          print("Code!")
          if nospaces.startswith("!"):
            # Call function
            print("Function call")
            argBeginIndex = nospaces.find("(")
            if argBeginIndex == -1:
              existingName = nospaces.replace("\n", "")[1:]
            else:
              existingName = nospaces.replace("\n", "")[1:argBeginIndex]
            if existingName == "println":
              # println declaration
              argBeginIndex = inputline.find("(")
              argEndIndex = inputline.find(")")
              args = inputline[argBeginIndex+1:argEndIndex]
              # TODO: Check for valid arguments
              # TODO: Check __DATA_cache to see arg
              # add_string_to_data(args, segment_data)
            elif existingName == "exit":
              # exit declaration; we only do exit(0)
              outf.write(" mov rax, 0x2000001\n mov rdi, 0\n syscall\n")
            else:
              if existingName not in declaredFunctions:
                print("RUNIC ERROR: Function does not exist (" + existingName + ").")
                end_compile(outf,inf)
                return
              outf.write(" call " + existingName + "\n")
          elif nospaces.startswith("//"):
            # Comment
            print("Comment")
          elif nospaces.startswith("blind{"):
            # Declare blind inline asm
            print("Blind inline assembly")
            isBlind = True
          elif nospacesorln == "return":
            # Return
            print("Return")
            outf.write(" ret\n")
          elif nospaces.startswith("/*"):
            # Multi-Line Comment
            print("Multi-Line Comment")
            inComment = True
            if nospacesorln.endswith("*/"):
              print("Comment End")
              inComment = False
          elif nospacesorln == "nothing":
            # Nothing
            print("Nothing")
            outf.write(" nop\n")
  inf.close()
  outf.close()

compile("tests/hello.party", "out/hello.s")