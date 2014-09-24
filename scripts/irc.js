var irc = require('irc');
var flowdock = require('flowdock');
var async = require('async')

var fdFlowId = '080cded7-aeea-446f-a1bb-5f5e09e66f54';
var fdApiKey = 'e8d8b40d1fd10cc3d33b76108456c920';
var ircChannel = '#cloudify_test';
var ircServer = 'irc.freenode.com';
var relayUser = 'cosmo-admin';

var fdUsers = {};
var clients = {};

var fds = new flowdock.Session(fdApiKey);


async.waterfall(
    [
        function(callback) {
            fds.flows(function(flows) {
                var flowIds;
                flows.map(function(flow) {
                    if (flow.id == fdFlowId) { callback(null, flow); }
                });
            });
        },

        function(flow, callback) {
            flow.users.forEach(function(user) {
                fdUsers[user.id] = user.nick
            });
            callback(null, fdUsers)
        },

        function(users, callback) {
            for (var u in users) {
                console.log('logging in: ' + users[u])
                clients[u] = new irc.Client(ircServer, users[u], {
                    channels: [ircChannel],
                });
            }
        }
    ]
)

relayClient = new irc.Client(ircServer, relayUser, {
    channels: [ircChannel],
});

// relayClient.whois('nir0s')

relayClient.addListener('message', function (from, to, message) {
    console.log('(' + to + ') ' + from + ': ' + message);
    fds.message(fdFlowId, '(' + to + ') ' + from + ': ' + message, []);
});

stream = fds.stream(fdFlowId);
stream.on('message', function(message) {
    console.log('flowdock: ' + JSON.stringify(message, undefined, 2));
    if (message.event == 'message' && message.content.indexOf(ircChannel) < 0) {
        clients[message.user].say(ircChannel, message.content);
    };
});
