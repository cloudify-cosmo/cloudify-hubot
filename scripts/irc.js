var irc = require('irc');
var flowdock = require('flowdock');
var async = require('async')

var fdFlowId = '080cded7-aeea-446f-a1bb-5f5e09e66f54';
var fdApiKey = process.env.FLOWDOCK_API_KEY
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

relayClient.addListener('error', function(message) {
    console.log('error: ', message);
    fds.message(fdFlowId, 'CHANNEL_ERROR: ' + JSON.stringify(message), ['irc_channel_error'])
});

relayClient.addListener('message', function (from, to, message) {
    console.log('(' + to + ') ' + from + ': ' + message);
    if (message.indexOf(ircChannel) < 0) {
        fds.message(fdFlowId, '(' + to + ') ' + from + ': ' + message, []);
    }
});

stream = fds.stream(fdFlowId);
stream.on('message', function(message) {
    console.log('flowdock: ' + JSON.stringify(message, undefined, 2));
    if (message.event == 'message' && message.content.indexOf(ircChannel) < 0) {
        if (message.user in clients) {
            clients[message.user].say(ircChannel, message.content);
        } else {
            relayClient.say(ircChannel, message.content)
        }
    };
});
