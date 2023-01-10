sub init()

    'Read Base URL From config file
    fs = CreateObject("roFileSystem")
    if fs.Exists("pkg:/configs/config.json")
        fileInStr = ReadAsciiFile("pkg:/configs/config.json") 'File in String
        fileInJson = ParseJSON(fileInStr)
        m.baseUrl = fileInJson.API_BASE_URL
        m.posterPathBaseUrl = fileInJson.POSTER_PATH_BASE_URL 
    else
        m.baseUrl = ""
    end if
    m.top.functionName = "getcontent"
end sub

' *************************************************
' Sub to fetch content 
' @param no params
' @return no return
' *************************************************
sub getcontent()
    print"m.top.callParams.movieIndex: "m.top.callParams.movieIndex
    
    if m.top.callParams.DoesExist("movieIndex")
        apiCallConfig = getAPICallConfig(m.top.callId, m.top.callParams.movieIndex)
    else 
        apiCallConfig = getAPICallConfig(m.top.callId)
    end if
    
    
    if apiCallConfig = invalid then return 'Avoid crash the app if callId is not set properly

    'ContentType indicates if we will have a list of items of apiCallConfig.ContentNodeType or just an item of apiCallConfig.ContentNodeType 
    if apiCallConfig.contentType = "ContentNodeList" then
        content = createObject("roSGNode", "ContentNode")
    else
        content = createObject("roSGNode", apiCallConfig.ContentNodeType)
    end if

    urlTransferObj = createObject("roUrlTransfer")
    
    'Process parameters if applicable
    parameters = ""
    if m.top.callParams <> invalid then
        callParams = m.top.callParams
        m.top.callParams = invalid
        'If we receive parameters for the call we check if that is valid for this call
        paramsArray=[]
        if apiCallConfig.parameters <> invalid and apiCallConfig.parameters.Count() > 0 then
            for each paramKey in callParams
                'If its a valid parameter
                if apiCallConfig.parameters[paramKey] <> invalid and callParams[paramKey] <> invalid then
                    paramsArray.push(paramKey+"="+urlTransferObj.escape(callParams[paramKey]))
                end if
            end for
        end if
        
        if paramsArray.Count() > 0 then
            parameters = paramsArray.join("&")
            parameters = "?" + parameters
        end if

    end if

    'print "Call Endpoint: "+m.baseUrl+apiCallConfig.endpoint+parameters
    'print "parameters: "parameters

    urlTransferObj.SetCertificatesFile("common:/certs/ca-bundle.crt")

    urlTransferObj.InitClientCertificates()
    urlTransferObj.setUrl(m.baseUrl+apiCallConfig.endpoint+parameters)
    
    response = urlTransferObj.getToString()
    'print"response: " response
    
    if response <> invalid then 
        
        jsonResponse = parseJSON(response)
        response = invalid
        print"jsonResponse: "jsonResponse
    end if
    'm.top.content = content
        PopularMoviesRow = createObject("roSGNode", "ContentNode")
        PopularMoviesRow.id = "PopularMoviesRow"
        for each item in JsonResponse
            child = PopularMoviesRow.CreateChild("ContentNode")
            child.addFields(item)
        end for
        m.top.content = PopularMoviesRow
        
        'test how to send which view we have at the moment
        if jsonResponse[0].show <> invalid
            m.top.view = "SearchView"
        end if
        print"m.top.content: "m.top.content

end sub

' *************************************************
' Function which provides config for api calls
' @param - callId
' @param - movieIndex
' @return - apiCallsList[callId]
' *************************************************
function getAPICallConfig(callId, movieIndex=invalid)
    if movieIndex = invalid then movieIndex = "1"
    query = "top" 'for test
    
    apiCallsList = {
        
        "shows": {
            "endpoint" : "/shows",
            "contentNodeType":"ShowsContentNode",
            "contentType":"ContentNodeList",
        },
        "seasons": {
            "endpoint" : "/shows/1/seasons",
            "contentNodeType":"ShowsContentNode",
            "contentType":"ContentNodeList",
        },
        "episodes": {
            "endpoint" : "/seasons/1/episodes",
            "contentNodeType":"ShowsContentNode",
            "contentType":"ContentNodeList",
        },
        "cast": {
            "endpoint" : "/shows/"+movieIndex+"/cast",
            "contentNodeType":"ShowsContentNode",
            "contentType":"ContentNodeList",
        },
        "search": {
            "endpoint" : "/search/shows?q=:"+query,
            "contentNodeType":"ShowsContentNode",
            "contentType":"ContentNodeList",
        }
    }

    return apiCallsList[callId]
        
end function