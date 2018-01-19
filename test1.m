clc
clear

%% Start message parameters
scenario.location = nan;
scenario.time = nan;
scenario.weather = nan;
scenario.vehicle = nan;
scenario.drivingMode = -1;

% dataset.rate = 20;
% dataset.frame = [227 227];
% dataset.vehicles = "true";
% dataset.peds = "false";
% dataset.trafficSigns = [];
% dataset.direction = [1234.8, 354.3, 0];
% dataset.reward = [15.0 0.5];
% dataset.throttle = "true";
% dataset.brake = "true";
% dataset.steering = "true";
% dataset.speed = [];
% dataset.yawRate = "false";
% dataset.drivingMode = [];
% dataset.location = [];
% dataset.time = "false";
dataset = nan;

out.start.scenario = scenario;
out.start.dataset = dataset;

%% Creating and sending the start message
start_msg = jsonencode(out);
start_msg = regexprep(start_msg, 'NaN', 'null');

start_msg = unicode2native(start_msg,'UTF-8');

% THIS DOESNT WORK FOR LONGER START MESSAGES
temp = length(start_msg):-255:0;
len_bytes = [temp zeros(1,4 - length(temp))];
len_bytes(len_bytes > 255) = 255;

% Connecting to the game
t = tcpip('localhost',8000);
t.OutputBufferSize = 3000;
fopen(t);

fwrite(t, len_bytes);
fwrite(t, start_msg);

%% Creating and sending the stop message, closing the connection
out_msg = uint8('{"stop": null}');
len_bytes = [length(out_msg) 0 0 0];

fwrite(t, len_bytes);
fwrite(t, out_msg);

fclose(t);
delete(t)
clear t
    
