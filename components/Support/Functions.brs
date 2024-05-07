' test functions

' Function that contains functions inside
function Math(value)
	
	mathObj = {

		value: value
		add: function(operationValue) 
            ?"m.value: " m.value
            ?"m.add: " m.add
			?"m: " m
			?"type(m): " type(m)
            
            result = m.value + operationValue 
            return result 
        end function
		subtract: function(operationValue) 
            result = m.value - operationValue 
            return result 
        end function
		multiply: function(operationValue) 
            result = m.value * operationValue 
            return result 
        end function
		divide: function(operationValue) 
            if m.value = 0 then 
                print "Error: Division by zero!" 
                return invalid 
            else return m.value / operationValue 
            end if 
        end function
	}

    results = {

		value: value
		result1: function() 
            return "result" 
        end function
        result2: function() 
            return {"result": {"sd": "wer"}} 
        end function
	}

    result = {"mathObj": mathObj, "results": results}
    return result
end function

function xmlToJson1() 
    ' Create an XML parser
xmlParser = CreateObject("roXMLElement")

' Load XML data from file
xmlData = ReadAsciiFile("pkg:/components/Views/HomeScreenView/HomeScreenView.xml")

' Parse XML data
if xmlParser.Parse(xmlData) then
    ' Convert XML to JSON
    jsonData = xmlParser.ToJsonString()

    ' Output JSON data
    print"jsonData: "(jsonData)
else
    ' Handle parsing error
    print("Error parsing XML")
end if

' Function to read file content as string
end function

function xmlToJson() 

    xmlString = CreateObject("roString")
    xmlString = ReadAsciiFile("pkg:/components/Views/HomeScreenView/HomeScreenView.xml")


    'format = FormatJson(xmlString)' fica: "<?xml version=\"1.0\" encoding=\"utf-8\" ?>\r\n\r\n<component name=\"HomeScreenView\" extends=\"Group\"> \r\n\r\n <interface> \r\n\t<field id = \"movieIndex\" type = \"string\" alwaysnotify=\"true\" onChange = \"onMovieIndexChanged\"/>\r\n\t<field id = \"itemContent\" type = \"node\" />\r\n</interface>\r\n\r\n<script type = \"text/brightscript\" uri=\"pkg:/components/Views/HomeScreenView/HomeScreenView.brs\"/>\r\n\r\n\t<children>\r\n\t\t<Group id=\"contentHighlight\" translation = \"[0,0]\">\r\n\t\t\t<Poster\r\n\t\t\t\tid=\"contentHighlightImage\"\r\n\t\t\t\turi=\"pkg:/images/backgrounds/overlay_endcard.png\"\r\n\t\t\t\twidth=\"845\"\r\n\t\t\t\theight=\"510\"\r\n\t\t\t\ttranslation=\"[440,0]\" />\r\n\t\t\t<Poster\r\n\t\t\t\tid=\"contentHighlightOverlay\"\r\n\t\t\t\turi=\"pkg:/images/backgrounds/overlay_content_highlight_v2.png\"\r\n\t\t\t\twidth=\"1280\"\r\n\t\t\t\theight=\"720\"\r\n\t\t\t\ttranslation=\"[0,0]\" />\r\n\t\t\t<Label \r\n\t\t\t\tid=\"contentHighlightTitle\" \r\n\t\t\t\ttext = \"\"\r\n\t\t\t\twidth = \"0\" \r\n\t\t\t\theight = \"40\" \r\n\t\t\t\thorizAlign = \"left\"\r\n\t\t\t\tvertAlign =\"center\"\r\n\t\t\t\tcolor=\"0xc0c0c0ff\"\r\n\t\t\t\tfont=\"font:SmallSystemFont\"\r\n\t\t\t\ttranslation = \"[20,30]\"\r\n\t\t\t\t/>\r\n\t\t\t<Label\r\n\t\t\t\tid=\"contentHighlightText\"\r\n\t\t\t\ttext=\"\"\r\n\t\t\t\tcolor=\"0xc0c0c0ff\"\r\n\t\t\t\tfont=\"font:SmallestSystemFont\"\r\n\t\t\t\tvertAlign=\"center\"\r\n\t\t\t\tnumLines=\"6\"\r\n\t\t\t\twidth = \"530\" \r\n\t\t\t\theight = \"200\" \r\n\t\t\t\ttranslation = \"[20,90]\"\r\n\t\t\t\twrap=\"true\" />\r\n\t\t</Group>\r\n\t\t<Group id=\"contentRows\" translation = \"[0,330]\">\r\n\t\t\t<Label \r\n\t\t\t\tid=\"contentRowsLabel\" \r\n\t\t\t\ttext = \"Popular Shows\"\r\n\t\t\t\twidth = \"0\" \r\n\t\t\t\theight = \"40\" \r\n\t\t\t\thorizAlign = \"left\"\r\n\t\t\t\tvertAlign =\"center\"\r\n\t\t\t\tvisible = \"false\"\r\n\t\t\t\tfont=\"font:SmallSystemFont\"\r\n\t\t\t\ttranslation = \"[20,10]\"\r\n\t\t\t\t/>\r\n\t\t\t<Rowlist \r\n\t\t\t\tid=\"popularMoviesRowList\"\r\n\t\t\t\titemComponentName = \"RowListItem\" \r\n\t\t\t\titemSize = \"[1280,240]\" \r\n\t\t\t\trowItemSize = \"[[200, 200]]\"\r\n\t\t\t\trowItemSpacing = \"[[20, 0]]\"\r\n\t\t\t\trowCounterRightOffset = \"2.0\"\r\n\t\t\t\tdrawFocusFeedback = \"true\"\r\n\t\t\t\tdrawFocusFeedbackOnTop = \"false\"\r\n\t\t\t\tvertFocusAnimationStyle = \"fixedFocusWrap\" \r\n\t\t\t\trowFocusAnimationStyle = \"floatingfocus\"   \r\n\t\t\t\ttranslation = \"[20,55]\"\r\n\t\t\t/>\r\n\r\n\t\t\t<Rowlist \r\n\t\t\t\tid=\"popularMoviesRowList\"\r\n\t\t\t\titemComponentName = \"RowListItem\" \r\n\t\t\t\titemSize = \"[1216,240]\" \r\n\t\t\t\trowItemSize = \"[[200, 200]]\"\r\n\t\t\t\trowItemSpacing = \"[[20, 0]]\"\r\n\t\t\t\trowCounterRightOffset = \"2.0\"\r\n\t\t\t\tdrawFocusFeedback = \"true\"\r\n\t\t\t\tdrawFocusFeedbackOnTop = \"false\"\r\n\t\t\t\tvertFocusAnimationStyle = \"fixedFocusWrap\" \r\n\t\t\t\trowFocusAnimationStyle = \"floatingfocus\"   \r\n\t\t\t\ttranslation = \"[0,155]\"\r\n\t\t\t/>\r\n\t</Group>\r\n\t\r\n\t<!-- <Poster\r\n\t\tid=\"search\"\r\n\t\turi=\"pkg:/images/stars/search.png\"\r\n\t\twidth=\"75.0\"\r\n\t\theight=\"75.0\"\r\n\t\ttranslation=\"[440,425]\" />\r\n\r\n\t<ScrollingLabel \r\n\t\tid = \"exampleScrollingLabel\" \r\n\t\tmaxWidth = \"300\" \r\n\t\theight = \"0\" \r\n\t\tfont = \"font:LargeBoldSystemFont\" \r\n\t\ttext = \"Press * on remote to search videos.                Press * on remote to search videos.                Press * on remote to search videos.\"\r\n\t\thorizAlign = \"left\" \r\n\t\tvertAlign = \"top\" /> -->\r\n\t\r\n\t<!-- <SimpleLabel\r\n\t\tid=\"testLabel\"\r\n\t\tfont=\"fontUri:MediumBoldSystemFont\"\r\n\t\ttext = \"Press * to search videos!\"\r\n\t\thorizOrigin = \"left\"\r\n\t\tvertOrigin = \"baseline\"\r\n\t\ttranslation=\"[500,560]\" /> -->\r\n\r\n\t<!-- <Button \r\n\t\tid = \"searchButton\"\r\n\t\tshowFocusFootprint = \"true\"\r\n\t\ttext = \"Press * for Search\"\r\n\t\tfocusedTextColor = \"0x262626ff\"\r\n\t\theight = \"70\"\r\n\t\tminwidth = \"460\"\r\n\t\tmaxwidth = \"100\"\r\n\t\tfocusedIconUri = \"pkg:/images/backgrounds/btt_back.png\"\r\n\t\ticonUri = \"pkg:/images/stars/star4.png\" /> -->\r\n\r\n\t</children>\r\n\r\n</component>\r\n"
    'parse = parseJson(xmlString)

    '############################################################################################
    rsp=CreateObject("roXMLElement")
    rsp.Parse(ReadAsciiFile("pkg:/components/Views/HomeScreenView/HomeScreenView.xml"))
    rsp.GenXML(1)
    rsp.GenXML(0) 'sem tag inicial <?xml....?>
    

    ' xmlMainTagsArray = ["component","interface", "script", "children"]
    
    json = {}
    nameOfChildNode = []
    childNodeNameArray = []
    parentNameArray = []
    json.AddReplace(rsp.getname(), {})

    if rsp.getChildNodes() <> invalid and rsp.getChildNodes().count() > 0 then
        '?"rsp.getChildNodes(): " rsp.getChildNodes()
        i=0
        for each item in rsp.getChildNodes() 
            if item.getAttributes() <> invalid then 
                attributes = item.getAttributes()
                json.component.AddReplace(item.getname(), attributes)
                
                if item.getChildNodes() <> invalid and item.getChildNodes().Count() > 0 then
                    'nameOfChildNode = []
                    for i = 0 to item.getChildNodes().Count() - 1
                        'name of child node
                        nameOfChildNode.push(item.getChildNodes()[i].getName())
                        
                        ' check if child node has attributes and retrieve them
                        if item.getAttributes().Count()  > 0 then
                            itemName = item.getname()
                            itemAttributes = item.getattributes()

                            json.component.AddReplace(itemName, itemAttributes)

                        else if item.getChildNodes() <> invalid and item.getChildNodes().Count() > 0 then
                            childrenName = item.getchildnodes()[i].getname()
                            childrenName = childrenName + i.toStr()
                            childrenAttributes = item.getchildnodes()[i].getattributes()
                            
                            parentName = item.getname()
                            parentNameArray.Push(parentName)

                            if json.component.DoesExist(parentName) then
                                json.component[parentName].AddReplace(childrenName, childrenAttributes)
                            end if
                        else 
                            json.component.AddReplace(item.getName(), "") 'add interface field to json no attributes
                        end if
                    end for
                end if
            else
                json.component.AddReplace(item.getname(), "")
            end if
            i++
            'stop
        end for
        ?"json " json
        ?""
        ?""
        ?"json.component " json.component
        ?""
        ?""
        ?"json.component.interface " json.component.interface
        ?"json.component.interface.field0 " json.component.interface.field0
        ?"json.component.interface.field1 " json.component.interface.field1
        ?""
        ?""
        ?"json.component.script " json.component.script
        ?""
        ?""
        ?"json.component.children " json.component.children
        ?"json.component.children.group0 " json.component.children.group0
        ?"json.component.children.group1 " json.component.children.group1
        ?""
        ?""
        ?"nameOfChildNode " nameOfChildNode
    else
        json = {}
    end if


    '#############################################################################################
    'using FormatJson(json as Object, flags = 0 as Integer)
    formatedJson = FormatJson(rsp.GenXML(0), i)
    ' stop
    '#############################################################################################



    ' Brightscript Debugger> p rsp.getname()
    ' component
    
    ' Brightscript Debugger> p rsp.getbody()
    ' <Component: roXMLList> =
    ' (
    '     <Component: roXMLElement>
    '     <Component: roXMLElement>
    '     <Component: roXMLElement>
    ' )

    ' Brightscript Debugger> p rsp.getbody()[0].getname()
    ' interface

    ' Brightscript Debugger> p rsp.getbody()[1].getname()
    ' script

    ' Brightscript Debugger> p rsp.getbody()[2].getname()
    ' children

    ' Brightscript Debugger> p rsp.getbody()[0].getbody()
    ' <Component: roXMLList> =
    ' (
    '     <Component: roXMLElement>
    '     <Component: roXMLElement>
    ' )


    ' Brightscript Debugger> p rsp.getbody()[0].getbody()[0].getattributes()
    ' <Component: roAssociativeArray> =
    ' {
    '     alwaysnotify: "true"
    '     id: "movieIndex"
    '     onChange: "onMovieIndexChanged"
    '     type: "string"
    ' }

    ' Brightscript Debugger> p rsp.getbody()[1].getname()
    ' script

    ' Brightscript Debugger> p rsp.getbody()[1].getattributes()
    ' <Component: roAssociativeArray> =
    ' {
    '     type: "text/brightscript"
    '     uri: "pkg:/components/Views/HomeScreenView/HomeScreenView.brs"
    ' }

    ' Brightscript Debugger> p rsp.getbody()[0].getbody()[1].getattributes()
    ' <Component: roAssociativeArray> =
    ' {
    '     id: "itemContent"
    '     type: "node"
    ' }



    '''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

    ' Brightscript Debugger> p rsp.getbody()[0]
    ' <Component: roXMLElement>

    ' Brightscript Debugger> p rsp.getbody()[0].getchildnodes()
    ' <Component: roList> =
    ' (
    '     <Component: roXMLElement>
    '     <Component: roXMLElement>
    ' )
    ' Brightscript Debugger> p rsp.getbody()[0].getchildnodes()[0].getattributes()
    ' <Component: roAssociativeArray> =
    ' {
    '     alwaysnotify: "true"
    '     id: "movieIndex"
    '     onChange: "onMovieIndexChanged"
    '     type: "string"
    ' }
    ' Brightscript Debugger> p rsp.getbody()[0].getchildnodes()[1].getattributes()
    ' <Component: roAssociativeArray> =
    ' {
    '     id: "itemContent"
    '     type: "node"
    ' }
        
    mathObj = Math(5)
    ? mathObj.add(1) 'prints 6
    ? mathObj.subtract(1) 'prints 4
    ? mathObj.multiply(2) 'prints 10
    ? mathObj.divide(2) 'prints 2.5
    ? ""
    ? ""

    mObj = Math(5)
    ? mathObj.add(1) 'prints 6
    ? mathObj.subtract(1) 'prints 4
    ? mathObj.multiply(2) 'prints 10
    ? mathObj.divide(2) 'prints 2.5
end function