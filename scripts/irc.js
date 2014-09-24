var irc = require('irc');
var flowdock = require('flowdock');

var fdFlowId = '080cded7-aeea-446f-a1bb-5f5e09e66f54';
var fdApiKey = 'e8d8b40d1fd10cc3d33b76108456c920';
var ircChannel = '#cloudify_test';
var ircServer = 'irc.freenode.com';

var fds = new flowdock.Session(fdApiKey);

var fdUsers = [];
var clients = {};

fds.flows(function(flows) {
    var flowIds;
    flowIds = flows.map(function(f) {
        if (f.id == fdFlowId) {
            // console.log(f.users);
            f.users.forEach(function(user) {
                // fdUsers.push(user.nick)
                clients[user.nick] = new irc.Client(ircServer, user.nick, {
                    channels: [ircChannel],
                });
            });
            // console.log(fdUsers)
        };
    });
});

// fdUsers.forEach(function(user) {
//     clients[user] = new irc.Client(ircServer, user, {
//         channels: [ircChannel],
//     });
// });

listenerClient = new irc.Client(ircServer, 'listener', {
    channels: [ircChannel],
});

listenerClient.addListener('message', function (from, to, message) {
    console.log('(' + to + ') ' + from + ': ' + message);
    fds.message(fdFlowId, '(' + to + ') ' + from + ': ' + message, []);
});

stream = fds.stream(fdFlowId);
stream.on('message', function(message) {
    console.log('flowdock: ' + JSON.stringify(message, undefined, 2));
    if (message.event == 'message' && message.content.indexOf(ircChannel) < 0) {
        listenerClient.say(ircChannel, message.content);
    };
});