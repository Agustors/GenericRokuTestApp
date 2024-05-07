'IMPORTS=utilities/types utilities/device
' ******************************************************
' Copyright Steven Kean 2010-2020
' All Rights Reserved.
' ******************************************************
'=====================
' Strings
'=====================
function isNullOrEmpty(value as dynamic) as boolean
    if isString(value) then
        return (value = invalid or value = "")
    else
        return not isValid(value)
    end if
end function

function startsWith(stringToCheck as dynamic, valueToCheck as string) as boolean
    if isString(stringToCheck) and not isNullOrEmpty(stringToCheck) and not isNullOrEmpty(valueToCheck) then
        return stringToCheck.inStr(valueToCheck) = 0
    end if
    return false
end function

function endsWith(stringToCheck as dynamic, valueToCheck as string) as boolean
    if isString(stringToCheck) and not isNullOrEmpty(stringToCheck) and not isNullOrEmpty(valueToCheck) then
        return stringToCheck.mid(stringToCheck.len() - valueToCheck.len()) = valueToCheck
    end if
    return false
end function

function padLeft(value as dynamic, padChar as string, totalLength as integer) as string
    value = asString(value)
    while value.len() < totalLength
        value = padChar + value
    end while
    return value
end function

function wrapText(value as dynamic, maxCharLength as integer) as dynamic
    if isNullOrEmpty(value) then
        return value
    end if

    lines = []
    if value.len() > maxCharLength then
        textArray = split(value, " ")
        currentLine = ""
        for each text in textArray
            tempLine = (currentLine + " " + text)
            tempLine = tempLine.trim()
            if tempLine.len() <= maxCharLength then
                currentLine = tempLine
            else
                if not isNullOrEmpty(currentLine) then
                    lines.push(currentLine)
                end if
                currentLine = text
            end if
        end for
        if not isNullOrEmpty(currentLine) then
            lines.push(currentLine)
        end if
    else
        lines.push(value)
    end if
    return join(lines, chr(10))
end function

'=====================
' Replacement
'=====================
function isRegexSafe(text as string) as boolean
    regexSpecials = ["\", "[", "]", "^", "$", ".", "|", "?", "*", "+", "(", ")"]
    for each special in regexSpecials
        if text.inStr(special) > -1 then
            return false
        end if
    end for
    return true
end function

function regexEscape(text as dynamic) as dynamic
    if not isString(text) or isNullOrEmpty(text) then
        return text
    end if

    regexSpecials = ["\", "[", "]", "^", "$", ".", "|", "?", "*", "+", "(", ")", "{", "}"]
    for each special in regexSpecials
        text = join(split(text, special), "\" + special)
    end for
    return text
end function

function regexReplace(text as dynamic, toReplace as dynamic, replaceWith as dynamic, options = "" as string) as dynamic
    if not isString(text) or isNullOrEmpty(text) then
        return text
    else if not isString(toReplace) or isNullOrEmpty(toReplace) then
        return text
    else if not isString(replaceWith) then
        return text
    end if

    regex = createObject("roRegex", toReplace, options)
    result = regex.ReplaceAll(text, replaceWith)
    return result
end function

function replace(text as dynamic, toReplace as dynamic, replaceWith as dynamic) as dynamic
    if not isString(text) or isNullOrEmpty(text) then
        return text
    else if not isString(toReplace) or isNullOrEmpty(toReplace) then
        return text
    else if not isString(replaceWith) then
        return text
    else if text.inStr(toReplace) = -1 then
        return text
    end if

    toReplace = regexEscape(toReplace)
    replaceWith = regexEscape(replaceWith)
    return regexReplace(text, toReplace, replaceWith)
end function

function split(toSplit as string, delim as string) as object
    result = []
    if not isNullOrEmpty(toSplit) then
        char = 0
        while char <= toSplit.len()
            match = toSplit.inStr(char, delim)
            if match = -1 then
                result.push(toSplit.mid(char))
                exit while
            end if
            if match >= char then
                result.push(toSplit.mid(char, match - char))
                char = match
            end if
            char = char + delim.len()
        end while
    end if
    return result
end function

function join(array as object, delim = "" as string) as string
    result = ""
    if isArray(array) then
        for i = 0 to array.Count() - 1
            item = AsString(array[i])
            if i > 0 then
                result = result + delim
            end if
            result = result + item
        end for
    end if
    return result
end function

function iso8859ToUtf8(input as string) as dynamic
    output = ""
    if not isNullOrEmpty(input) then
        for i = 0 to input.len() - 1
            char = input.mid(i, 1)
            ascii = asc(char)
            if ascii < 0 then
                ascii = ascii + 256
            end if
            newChar = ""
            if ascii < 160 then
                newChar = char
            else if ascii < 192 then
                newChar = chr(194) + chr(ascii)
            else
                newChar = chr(195) + chr(ascii - 64)
            end if
            output = output + newChar
        end for
    end if
    return output
end function

function replaceUCodes(text as string) as string
    if isNullOrEmpty(text) then
        return ""
    end if

    regex = createObject("roRegex", "\\u([a-fA-F0-9]{4})", "i")
    matches = regex.match(text)

    iCount = 0
    while matches.Count() > 1
        iCount = iCount + 1
        text = regex.replace(text, chr(hexToInt(matches[1])))
        matches = regex.match(text)

        if iCount > 5000 then
            exit while
        end if
    end while
    return text
end function

function toPascalCase(input as string, separator = "_" as string, retainSeparator = false as boolean) as string
    output = ""
    parts = input.split(separator)
    for each part in parts
        if not isNullOrEmpty(output) and retainSeparator then
            output = output + separator
        end if
        output = output + uCase(part.mid(0, 1)) + part.mid(1)
    end for
    return output
end function

function toCamelCase(input as string, separator = "_" as string, retainSeparator = false as boolean) as string
    output = toPascalCase(input, separator, retainSeparator)
    output = lCase(output.mid(0, 1)) + output.mid(1)
    return output
end function
