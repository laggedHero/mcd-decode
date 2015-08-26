module.exports =
  activate: ->
    atom.commands.add 'atom-workspace', "mcd-decode:decode", => @decode()

  decode: ->
    editor = atom.workspace.getActivePaneItem()
    selection = editor.getLastSelection()

    pako = require('pako')
    binaryString = new Buffer(selection.getText(), 'base64')
    try
      restored = JSON.parse(pako.inflate(binaryString, { to: 'string' }))
      selection.insertText(JSON.stringify(restored, null, 4))
    catch error
      console.error(error)
