jQuery(document).ready(function($) {
  $('body').terminal(function(command, term){
    $.ajax({
      type: "GET",
      url: "command/" + command,
      data: { command: command },
      asynch: true
    })
    .done(function( msg ) {
      term.echo(msg.result)
    })
    .fail(function() {
      term.echo("unknown command");
    });
  }, {prompt: '> ', name: 'test', greetings: "Welcome to my resume!"});
});
