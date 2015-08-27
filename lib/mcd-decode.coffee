module.exports =
  activate: ->
    atom.commands.add 'atom-workspace', "mcd-decode:decode", => @decode()

  decode: ->
    editor = atom.workspace.getActivePaneItem()

    text = '';
    lines = editor.getBuffer().getLines()

    for line in lines
      line = line.trim()
      if line.length > 10
        text += line

    pako = require('pako')
    try
      restored = JSON.parse(pako.inflate(new Buffer(text, 'base64'), { to: 'string' }))
      editor.setText(JSON.stringify(restored, null, 4))
      editor.setGrammar(atom.grammars.grammarForScopeName('source.json'))
    catch error
      atom.notifications.addError('Invalid encoded string', {})
      console.error(error)
