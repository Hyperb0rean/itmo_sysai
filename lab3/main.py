from pyswip import Prolog
from pyswip import Functor


def format_value(value):
    output = ""
    if isinstance(value, list):
        output = "[ " + ", ".join([format_value(val) for val in value]) + " ]"
    elif isinstance(value, Functor) and value.arity == 2:
        output = "{0}{1}{2}".format(value.args[0], value.name, value.args[1])
    else:
        output = "{}".format(value)

    return output

def format_result(result):
    result = list(result)

    if len(result) == 0:
        return "The countries are either not enemies either idea is not military one."

    if len(result) == 1 and len(result[0]) == 0:
        return "true."

    output = ""
    for res in result:
        tmpOutput = []
        for var in res:
            tmpOutput.append(var + " = " + format_value(res[var]))
        output += ", ".join(tmpOutput) + " ;\n"
    output = output[:-3] + " ."

    return output



prolog = Prolog()
prolog.consult("../lab1/lab1.pl")
print("Enter your Country name, Country that you want to check and idea they picked, separated by spaces")
args = input().split()
ideas = list(prolog.query(f"idea_pick('{args[0]}', '{args[1]}', '{args[2]}', List)"))

print(format_result(ideas))
