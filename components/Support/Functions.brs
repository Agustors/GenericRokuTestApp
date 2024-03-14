' getFocusedNodeObj - Returns focused node
' @param {object} root - root
' @param {object} maxDeep - search depth
' @return {object} - focused node
Function getFocusedNodeObj(root, maxDeep = 25) as Object
    node = root
    focusedChild = node.focusedChild
    while maxDeep > 0 AND focusedChild <> Invalid AND not node.isSameNode(focusedChild)
        node = focusedChild
        focusedChild = node.focusedChild
        maxDeep--
    end while
    return node
End Function