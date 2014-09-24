// TODO: MUCH better logging

var irc = require('irc');
var flowdock = require('flowdock');
var async = require('async');

var fdFlowId = '080cded7-aeea-446f-a1bb-5f5e09e66f54';
var fdApiKey = process.env.FLOWDOCK_API_KEY;
var ircChannel = '#cloudify_test';
var ircServer = 'irc.freenode.com';
var relayUser = 'cosmo-admin';

var fdUsers = {};
var clients = {};

var fds = new flowdock.Session(fdApiKey);


// TODO: make this check for new users periodically
async.waterfall(
    [
        function (callback) {
            fds.flows(function (flows) {
                flows.map(function (flow) {
                    if (flow.id === fdFlowId) { callback(null, flow); }
                });
            });
        },

        function (flow, callback) {
            flow.users.forEach(function (user) {
                fdUsers[user.id] = user.nick;
            });
            callback(null, fdUsers);
        },

        function (users) {
            var u;
            for (u in users) {
                if (users.hasOwnProperty(u)) {
                    console.log('logging in: ' + users[u]);
                    clients[u] = new irc.Client(ircServer, users[u], {
                        channels: [ircChannel],
                    });
                }
            }
        }
    ]
);

var relayClient = new irc.Client(ircServer, relayUser, {
    channels: [ircChannel],
});

relayClient.addListener('error', function (message) {
    console.log('error: ', message);
    fds.message(fdFlowId, 'CHANNEL_ERROR: ' + JSON.stringify(message), ['irc_channel_error']);
});

relayClient.addListener('message', function (from, to, message) {
    console.log('(' + to + ') ' + from + ': ' + message);
    // TODO: only print message in flow if it doesn't contain the tag
    if (message.indexOf(ircChannel) < 0) {
        fds.message(fdFlowId, '(' + to + ') ' + from + ': ' + message, []);
    }
});

var stream = fds.stream(fdFlowId);
stream.on('message', function (message) {
    console.log('flowdock: ' + JSON.stringify(message, undefined, 2));
    if (message.event === 'message' && message.content.indexOf(ircChannel) < 0) {
        // TODO: verify non-registered user can send messages to flow
        if (clients.hasOwnProperty(message.user)) {
        // if (message.user in clients) {
            clients[message.user].say(ircChannel, message.content);
        } else {
            relayClient.say(ircChannel, fdUsers[message.user] + ': ' + message.content);
        }
    }
});
