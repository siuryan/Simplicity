files = ["Airplane","City","Driver","FlightRoute","Shop"]
text = ""


for s in files:
    f = open("Driver/" + s + ".java",'r')
    text += s + "\n\n"
    line = f.readline()
    while line != "":
        if (len(line.split()) > 0) and (line.split()[0] == "public" or line.split()[0] == "private"):
            for word in line.split():
                if ";" in word:
                    text += word[:-1] + " "
                elif word != "{" and word != "=" and word != "//":
                    text += word + " "
                else:
                    break
            text += "\n"
        line = f.readline()
    text += "\n\n\n"
    f.close()


print(text)
