# The Runic Programming Language
# (c) 0xilis, 2024
# This compiler is intended for x86_64 macOS systems.
# (Maybe rename to party? .party?)
# The Party Programming Language
# (c) 0xilis, 2024
import os

# Array for existing function names
declaredFunctions = []
# Array for existing variable names; DOES NOT INCLUDE PartyInternalVar_ !!!
declaredVariables = []
segment_data = "" # __DATA section, added after __TEXT
protoVarName = "PartyInternalVar_"
protoVarCount = 0
internalVarNames = []
internalStringsLen = []

def end_compile(outf, inf):
  outf.close()
  inf.close()

def init_segment_data():
  # Initializes segment_data if not yet initialized
  global segment_data
  if segment_data == "":
    segment_data = "section .data\n"

def parse_one_arg(argString, args):
  global segment_data
  global internalVarNames
  global internalStringsLen
  global protoVarCount
  global protoVarName
  stringStartIndex = argString.find("\"")
  # TODO: Issues when \" is used in strings
  stringEndIndex = argString[stringStartIndex+1:].find("\"")
  if (stringStartIndex != -1 and stringEndIndex != -1):
    # String
    daString = argString[stringStartIndex+1:stringEndIndex+1]
    # Dumb workaround: Remove " if end with it...
    if daString.endswith("\""):
      daString = daString[:-1]
    daStringLen = len(daString)
    protoVarCount += 1
    internalVarName = protoVarName + str(protoVarCount)
    print("internalVarName: " + internalVarName)
    internalVarNames.append(internalVarName)
    internalStringsLen.append(daStringLen)
    dataLine1 = internalVarName + ": db \"" + daString + "\"," + str(daStringLen) + "\n"
    dataLine2 = ".len: equ $ - " + internalVarName + "\n"
    init_segment_data()
    segment_data += dataLine1 + dataLine2
    args.append(internalVarName)
  else:
    # Int or var name
    currentArgsStringNoSpace = argString.replace(" ", "")
    if currentArgsStringNoSpace in declaredVariables:
      # Var name
      args.append(currentArgsStringNoSpace)
    else:
      # Integer
      args.append(currentArgsStringNoSpace)
  return args

def super_duper_arg_parser(argsString):
  # You cannot have a ')' in strings, a ',' in strings, or a " in strings ATM.
  # argsString is string of the containing ()
  global segment_data # segment_data is the __DATA segment
  # TODO: This will have issues when "," is used in strings but not sure if I'll have enough time for final to support that
  global internalVarNames
  global internalStringsLen
  if argsString.startswith("("):
    # Dumb workaround... remove ( if start of argsString
    argsString = argsString[1:]
  if argsString.endswith(")"):
    # Dumb workaround... remove ) if end of argsString
    argsString = argsString[:-1]
  args = []
  currentArgsString = argsString
  commaIndex = argsString.find(",")
  prevCommaIndex = 0
  while (commaIndex != -1):
    currentArgsString = argsString[prevCommaIndex:commaIndex].replace(",","")
    prevCommaIndex = commaIndex
    args = parse_one_arg(currentArgsString, args) 
    commaIndex = currentArgsString[commaIndex+1:].find(",")
  # The last arg
  if prevCommaIndex == 0:
    # One arg only in argsString
    args = parse_one_arg(argsString, args)
  else:
    args = parse_one_arg(argsString[prevCommaIndex+1:], args)
  return args

def compile(path, outpath):
  # Initialize assembly
  if os.path.exists(outpath):
    os.remove(outpath)
  outf = open(outpath, 'w+')
  outf.write("global start\nsection .text\n\n")
  inFunkyMode = False # Are we in a function?
  isBlind = False # Are we declaring inline assembly?
  global segment_data
  inComment = False # Are we in a comment?
  autoReturn = True # Should we return from a function?
  # Prototype internal symbol names
  protoSecName = "PartyCodeSection_"
  protoSecName = 0
  global protoVarName
  global protoVarCount
  global internalVarNames
  global internalStringsLen
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
            print("PARTY ERROR: Cannot declare a function inside a function.")
            end_compile(outf,inf)
            return
          afterfunk = inputline[IndexFunc+5:]
          afterfunk = afterfunk.replace(" ", "")
          namelength = afterfunk.find("{")
          name = afterfunk[:namelength]
          if name in declaredFunctions:
            print("PARTY ERROR: Function already declared (" + name + ").")
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
            print("PARTY ERROR: Cannot end a function outside of one.")
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
              argsString = inputline[argBeginIndex:argEndIndex+1].replace("\")","\\n\"")
              args = super_duper_arg_parser(argsString)
              # println is special in the syscall wrappers
              outf.write(" mov rax, 0x2000004\n")
              outf.write(" mov rdi, 1\n")
              outf.write(" mov rsi, " + args[0] + "\n")
              internalVarNameIndex = internalVarNames.index(args[0])
              if internalVarNameIndex == -1:
                print("PARTY ERROR: Variable not declared.")
                end_compile(outf,inf)
                return
              outf.write(" mov rdx, " + str(internalStringsLen[internalVarNameIndex]) + "\n")
              outf.write(" syscall\n")
            elif existingName == "exit":
              # exit declaration; we only do exit(0)
              outf.write(" mov rax, 0x2000001\n mov rdi, 0\n syscall\n")
            elif existingName == "syscall":
              # Syscall declaration
              print("syscall()")
              argBeginIndex = inputline.find("(")
              # TODO: Oh yeah uh this will have problems with strings that contain ) oops
              argEndIndex = inputline.find(")")
              # +1 is ugly hack bc my arg parser buggy
              argsString = inputline[argBeginIndex+1:argEndIndex]
              args = super_duper_arg_parser(argsString)
              # We only support a maximum of 5 args ATM. (not including the syscall number in !syscall())
              # This is an array of the x86 calling conversions
              registerCallingConversions = ["rax", "rdi", "rsi", "rdx", "r8", "r9"]
              argc = 0
              for arg in args:
                if argc == 6:
                  print("PARTY ERROR: Too many arguments for println.")
                registerForArg = registerCallingConversions[argc]
                outf.write(" mov " + registerForArg + ", " + arg + "\n")
                argc += 1
              outf.write(" syscall\n")
            else:
              if existingName not in declaredFunctions:
                print("PARTY ERROR: Function does not exist (" + existingName + ").")
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
          else:
            # Var declaration parsing
            strstart = inputline.find("string ")
            intstart = inputline.find("int ")
            if strstart != -1:
              # String declaration
              print("String declaration")
              noDeclare = inputline[strstart+7:]
              equalSignIndex = noDeclare.find("=")
              stringName = noDeclare[:equalSignIndex].replace(" ","")
              stringToSave = noDeclare[equalSignIndex+1:].replace("\n","")
              stringToSaveRaw = stringToSave.replace("\"", "")
              stringToSaveRawLen = len(stringToSaveRaw)
              declaredVariables.append(stringName)
              internalVarNames.append(stringName)
              internalStringsLen.append(stringToSaveRawLen)
              init_segment_data()
              segment_data += stringName + ": db \"" + stringToSaveRaw + "\"," + str(stringToSaveRawLen) + "\n"
            elif intstart != -1:
              # Integer declaration
              print("Integer declaration")
              noDeclare = inputline[intstart+4:]
              equalSignIndex = noDeclare.find("=")
              intName = noDeclare[:equalSignIndex].replace(" ","")
              intToSave = noDeclare[equalSignIndex+1:].replace("\n","")
              declaredVariables.append(intName)
              init_segment_data()
              # dq for quadword, 64 bit
              segment_data += intName + ": dq " + intToSave + "\n"
  outf.write(segment_data)
  inf.close()
  outf.close()

compile("tests/hello.party", "out/hello.s")