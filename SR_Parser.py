f = open("C:/Users/Kamil0232/Desktop/zapalanie.txt", "r")
out = open("C:/Users/Kamil0232/Desktop/sr_out2.txt", "w+")
commend_list = []
choose_command = []
arguments = []
for line in f:
    commend_list.append(line)
for i in range(len(commend_list)):
    commend_list[i].lower()
    commend_list[i] = commend_list[i].replace("\n", "")
    res = []
    res.append(0)
    for character in range(len(commend_list[i])):
        if commend_list[i][character] == " ":
            res[0] = character + 1
            break
    choose_command.append(commend_list[i][:res[0]-1])
    arguments.append(commend_list[i][res[0]:])
    arguments[i] = arguments[i].replace(" ", "")

print(commend_list)
print(choose_command)
print(arguments)

for command in range(len(choose_command)):
    if choose_command[command] == "movi":
        instr = ("00168{}".format(arguments[command][1]) + arguments[command][3:])
        out.write(instr)
        out.write("\n")
    if choose_command[command] == "mov":
        instr = ("001{}6{}00".format(arguments[command][-1], arguments[command][1]))
        out.write(instr)
        out.write("\n")
    if choose_command[command] == "nop":
        instr = "00166600"
        out.write(instr)
        out.write("\n")
    if choose_command[command] == "jump":
        instr = ("011{}6600".format(arguments[command][1]))
        out.write(instr)
        out.write("\n")
    if choose_command[command] == "jumpi":
        instr = ("0116E6{}".format(arguments[command]))
        out.write(instr)
        out.write("\n")
    if choose_command[command] == "jz":
        instr = ("023{}E0".format(arguments[command][1]) + arguments[command][3:])
        out.write(instr)
        out.write("\n")
    if choose_command[command] == "jnz":
        instr = ("0033{}E0".format(arguments[command][1]) + arguments[command][3:])
        out.write(instr)
        out.write("\n")
    if choose_command[command] == "add":
        instr = ("001{}{}{}00".format(arguments[command][4],arguments[command][7], arguments[command][1]))
        out.write(instr)
        out.write("\n")
    if choose_command[command] == "addi":
        instr = ("001{}E{}".format(arguments[command][4],arguments[command][1]) + arguments[command][6:])
        out.write(instr)
        out.write("\n")
    if choose_command[command] == "and":
        instr = ("000{}{}{}00".format(arguments[command][4],arguments[command][7],arguments[command][1]))
        out.write(instr)
        out.write("\n")
    if choose_command[command] == "andi":
        instr = ("000{}E{}".format(arguments[command][4],arguments[command][1]) + arguments[command][6:])
        out.write(instr)
        out.write("\n")
    if choose_command[command] == "load":
        mem = (arguments[command][1])
        int_mem = int(mem) + 8
        if int_mem > 9:
            if int_mem == 10:
                mem = "A"
            if int_mem == 11:
                mem = "B"
            if int_mem == 12:
                mem = "C"
            if int_mem == 13:
                mem = "D"
            if int_mem == 14:
                mem = "E"
            if int_mem == 15:
                mem = "F"
        instr = ("001{}6".format(arguments[command][4]) + mem + "00")
        out.write(instr)
        out.write("\n")
    if choose_command[command] == "loadi":
        mem = (arguments[command][1])
        int_mem = int(mem) + 8
        if int_mem > 9:
            if int_mem == 10:
                mem = "A"
            if int_mem == 11:
                mem = "B"
            if int_mem == 12:
                mem = "C"
            if int_mem == 13:
                mem = "D"
            if int_mem == 14:
                mem = "E"
            if int_mem == 15:
                mem = "F"
        instr = ("0036E" + mem + arguments[command][3:])
        out.write(instr)
        out.write("\n")


f.close()